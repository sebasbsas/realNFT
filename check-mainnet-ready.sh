#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Verificando configuración para Mainnet...${NC}"
echo ""

WARNINGS=0
ERRORS=0
CHECKS_PASSED=0

# Check 1: deploy.ts
echo -e "${BLUE}1️⃣ Verificando deploy.ts...${NC}"
if grep -q "0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691" packages/snfoundry/scripts-ts/deploy.ts 2>/dev/null; then
    echo -e "${RED}❌ CRÍTICO: deploy.ts tiene dirección hardcodeada de devnet${NC}"
    echo -e "${YELLOW}   Archivo: packages/snfoundry/scripts-ts/deploy.ts${NC}"
    echo -e "${YELLOW}   Cambiar a: deployer.address${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅ deploy.ts está configurado correctamente${NC}"
    CHECKS_PASSED=$((CHECKS_PASSED + 1))
fi

# Check 2: scaffold.config.ts
echo ""
echo -e "${BLUE}2️⃣ Verificando scaffold.config.ts...${NC}"
if grep -q "chains\.devnet" packages/nextjs/scaffold.config.ts 2>/dev/null; then
    echo -e "${RED}❌ CRÍTICO: scaffold.config.ts está configurado para devnet${NC}"
    echo -e "${YELLOW}   Archivo: packages/nextjs/scaffold.config.ts${NC}"
    echo -e "${YELLOW}   Cambiar a: chains.mainnet${NC}"
    ERRORS=$((ERRORS + 1))
elif grep -q "chains\.mainnet" packages/nextjs/scaffold.config.ts 2>/dev/null; then
    echo -e "${GREEN}✅ scaffold.config.ts está configurado para mainnet${NC}"
    CHECKS_PASSED=$((CHECKS_PASSED + 1))
elif grep -q "chains\.sepolia" packages/nextjs/scaffold.config.ts 2>/dev/null; then
    echo -e "${YELLOW}⚠️  ADVERTENCIA: scaffold.config.ts está configurado para sepolia (testnet)${NC}"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "${YELLOW}⚠️  No se pudo determinar la configuración de red${NC}"
    WARNINGS=$((WARNINGS + 1))
fi

# Check 3: .env snfoundry
echo ""
echo -e "${BLUE}3️⃣ Verificando .env de snfoundry...${NC}"
if [ ! -f "packages/snfoundry/.env" ]; then
    echo -e "${RED}❌ CRÍTICO: packages/snfoundry/.env no existe${NC}"
    echo -e "${YELLOW}   Crear el archivo con las credenciales de mainnet${NC}"
    ERRORS=$((ERRORS + 1))
else
    ENV_CHECKS=0
    if grep -q "ACCOUNT_ADDRESS_MAINNET" packages/snfoundry/.env 2>/dev/null; then
        ENV_CHECKS=$((ENV_CHECKS + 1))
    else
        echo -e "${RED}❌ Falta ACCOUNT_ADDRESS_MAINNET en .env${NC}"
    fi
    
    if grep -q "PRIVATE_KEY_MAINNET" packages/snfoundry/.env 2>/dev/null; then
        ENV_CHECKS=$((ENV_CHECKS + 1))
    else
        echo -e "${RED}❌ Falta PRIVATE_KEY_MAINNET en .env${NC}"
    fi
    
    if grep -q "RPC_URL_MAINNET" packages/snfoundry/.env 2>/dev/null; then
        ENV_CHECKS=$((ENV_CHECKS + 1))
    else
        echo -e "${YELLOW}⚠️  Falta RPC_URL_MAINNET en .env (se usará uno por defecto)${NC}"
    fi
    
    if [ $ENV_CHECKS -eq 3 ]; then
        echo -e "${GREEN}✅ .env de snfoundry configurado correctamente${NC}"
        CHECKS_PASSED=$((CHECKS_PASSED + 1))
    elif [ $ENV_CHECKS -eq 2 ]; then
        echo -e "${YELLOW}⚠️  .env de snfoundry parcialmente configurado ($ENV_CHECKS/3)${NC}"
        WARNINGS=$((WARNINGS + 1))
    else
        echo -e "${RED}❌ .env de snfoundry mal configurado ($ENV_CHECKS/3)${NC}"
        ERRORS=$((ERRORS + 1))
    fi
fi

# Check 4: .env nextjs
echo ""
echo -e "${BLUE}4️⃣ Verificando .env de nextjs...${NC}"
if [ ! -f "packages/nextjs/.env" ]; then
    echo -e "${YELLOW}⚠️  packages/nextjs/.env no existe${NC}"
    echo -e "${YELLOW}   Se usará RPC público (puede tener rate limits)${NC}"
    WARNINGS=$((WARNINGS + 1))
else
    if grep -q "NEXT_PUBLIC_MAINNET_PROVIDER_URL" packages/nextjs/.env 2>/dev/null; then
        echo -e "${GREEN}✅ .env de nextjs configurado${NC}"
        CHECKS_PASSED=$((CHECKS_PASSED + 1))
    else
        echo -e "${YELLOW}⚠️  NEXT_PUBLIC_MAINNET_PROVIDER_URL no configurado${NC}"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

# Check 5: .gitignore
echo ""
echo -e "${BLUE}5️⃣ Verificando .gitignore...${NC}"
if grep -qE "^\.env$|^\*\*\/\.env|^\.env\*|^\*\*\/\.env\*" .gitignore 2>/dev/null; then
    echo -e "${GREEN}✅ .env está en .gitignore (seguridad)${NC}"
    CHECKS_PASSED=$((CHECKS_PASSED + 1))
else
    echo -e "${RED}❌ SEGURIDAD: .env NO está en .gitignore${NC}"
    echo -e "${YELLOW}   Ejecuta: echo '.env' >> .gitignore${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Check 6: Compilation
echo ""
echo -e "${BLUE}6️⃣ Verificando compilación de contratos...${NC}"
cd packages/snfoundry/contracts 2>/dev/null
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ No se pudo acceder a packages/snfoundry/contracts${NC}"
    ERRORS=$((ERRORS + 1))
else
    if scarb build &> /dev/null; then
        echo -e "${GREEN}✅ Contratos compilan correctamente${NC}"
        CHECKS_PASSED=$((CHECKS_PASSED + 1))
    else
        echo -e "${RED}❌ ERROR: Los contratos no compilan${NC}"
        echo -e "${YELLOW}   Ejecuta 'cd packages/snfoundry/contracts && scarb build' para ver errores${NC}"
        ERRORS=$((ERRORS + 1))
    fi
    cd ../../.. 2>/dev/null
fi

# Check 7: NFT Metadata (info only)
echo ""
echo -e "${BLUE}7️⃣ Verificando metadata del NFT...${NC}"
if [ -f "packages/snfoundry/contracts/src/your_collectible.cairo" ]; then
    NAME=$(grep -A 1 'let name: ByteArray' packages/snfoundry/contracts/src/your_collectible.cairo | grep -oP '"\K[^"]+' | head -1)
    SYMBOL=$(grep -A 1 'let symbol: ByteArray' packages/snfoundry/contracts/src/your_collectible.cairo | grep -oP '"\K[^"]+' | head -1)
    
    if [ ! -z "$NAME" ] && [ ! -z "$SYMBOL" ]; then
        echo -e "${BLUE}   Nombre: ${NC}$NAME"
        echo -e "${BLUE}   Símbolo: ${NC}$SYMBOL"
        echo -e "${YELLOW}   ⚠️  Verifica que estos valores sean correctos para producción${NC}"
    else
        echo -e "${YELLOW}   ⚠️  No se pudieron leer los valores de metadata${NC}"
    fi
else
    echo -e "${YELLOW}   ⚠️  No se encontró your_collectible.cairo${NC}"
fi

# Summary
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📊 RESUMEN${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Verificaciones exitosas: $CHECKS_PASSED${NC}"
echo -e "${YELLOW}⚠️  Advertencias: $WARNINGS${NC}"
echo -e "${RED}❌ Errores críticos: $ERRORS${NC}"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Todo listo para desplegar a mainnet!${NC}"
    echo ""
    echo -e "${BLUE}Próximos pasos:${NC}"
    echo -e "  1. Revisa la metadata del NFT (nombre, símbolo)"
    echo -e "  2. Asegúrate de tener fondos en mainnet (≥0.1 STRK)"
    echo -e "  3. Ejecuta: ${YELLOW}cd packages/snfoundry && yarn deploy --network mainnet${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  Hay advertencias pero puedes continuar${NC}"
    echo -e "${YELLOW}   Revisa los puntos anteriores antes de desplegar${NC}"
    echo ""
    echo -e "${BLUE}Para desplegar:${NC}"
    echo -e "  ${YELLOW}cd packages/snfoundry && yarn deploy --network mainnet${NC}"
    exit 0
else
    echo -e "${RED}🚨 HAY ERRORES CRÍTICOS - NO DESPLEGAR AÚN${NC}"
    echo -e "${RED}   Corrige los errores marcados con ❌ antes de continuar${NC}"
    echo ""
    echo -e "${BLUE}Para más información, consulta:${NC}"
    echo -e "  ${YELLOW}HARDCODED_VALUES_CHECKLIST.md${NC}"
    echo -e "  ${YELLOW}MAINNET_DEPLOYMENT_GUIDE.md${NC}"
    exit 1
fi

