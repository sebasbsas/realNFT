#!/bin/bash

# 🚀 Quick Start Script para Scaffold-Stark 2
# Este script inicia el devnet y despliega contratos automáticamente

set -e  # Salir si hay error

echo "🚀 Quick Start - Scaffold-Stark 2"
echo "=================================="
echo ""

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 1. Verificar si ya hay un devnet corriendo
if lsof -Pi :5050 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  Ya hay un devnet corriendo en el puerto 5050${NC}"
    read -p "¿Quieres detenerlo y reiniciar? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🛑 Deteniendo devnet existente..."
        pkill -f starknet-devnet || true
        sleep 2
    else
        echo "❌ Abortando. Detén el devnet manualmente con: pkill starknet-devnet"
        exit 1
    fi
fi

# 1.5 Limpiar dump previo para evitar conflictos
if [ -f "./devnet-data/devnet_dump.pkl" ]; then
    echo -e "${YELLOW}🧹 Limpiando dump previo...${NC}"
    rm -f ./devnet-data/devnet_dump.pkl
fi

# 2. Iniciar devnet en background
echo -e "${BLUE}📡 Iniciando Starknet Devnet...${NC}"
./start-devnet-persistent.sh > /tmp/devnet.log 2>&1 &
DEVNET_PID=$!

# 3. Esperar a que el devnet esté listo
echo -e "${BLUE}⏳ Esperando a que el devnet esté listo...${NC}"
MAX_RETRIES=30
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    if curl -s http://127.0.0.1:5050/is_alive >/dev/null 2>&1; then
        echo -e "${GREEN}✅ Devnet listo!${NC}"
        break
    fi
    RETRY_COUNT=$((RETRY_COUNT + 1))
    echo -n "."
    sleep 1
done

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
    echo -e "\n${YELLOW}❌ Error: El devnet no respondió en 30 segundos${NC}"
    echo "Logs del devnet:"
    cat /tmp/devnet.log
    exit 1
fi

echo ""

# 4. Desplegar contratos
echo -e "${BLUE}📦 Desplegando contratos...${NC}"
cd packages/snfoundry
yarn deploy --network devnet 2>&1 | tee /tmp/deploy.log

# Extraer información del deployment
if grep -q "Contract Deployed at" /tmp/deploy.log; then
    echo ""
    echo -e "${GREEN}=================================="
    echo "✅ ¡Todo listo para desarrollar!"
    echo -e "==================================${NC}"
    echo ""
    
    # Mostrar información útil
    echo -e "${BLUE}📊 Información del Devnet:${NC}"
    echo "  🌐 URL: http://127.0.0.1:5050"
    echo "  🆔 PID: $(pgrep -f 'starknet-devnet.*--port 5050' | head -1)"
    echo ""
    
    echo -e "${BLUE}📝 Cuenta Pre-desplegada:${NC}"
    echo "  Address:     0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691"
    echo "  Private Key: 0x0000000000000000000000000000000071d7bb07b9a64f6f78ac4c816aff4da9"
    echo "  Balance:     1000 ETH"
    echo ""
    
    echo -e "${BLUE}📦 Contratos Desplegados:${NC}"
    grep "Contract Deployed at" /tmp/deploy.log | while read -r line; do
        CONTRACT_ADDRESS=$(echo "$line" | grep -oP '0x[a-fA-F0-9]+')
        echo "  ✅ $CONTRACT_ADDRESS"
    done
    echo ""
    
    echo -e "${BLUE}🚀 Siguiente paso:${NC}"
    echo "  cd packages/nextjs && yarn start"
    echo ""
    
    echo -e "${YELLOW}💡 Tip:${NC} Para detener el devnet: ${BLUE}pkill starknet-devnet${NC}"
    echo ""
    
else
    echo -e "${YELLOW}⚠️  El deployment completó pero no se encontraron contratos${NC}"
    echo "Revisa los logs en /tmp/deploy.log"
fi

cd ../..

