#!/bin/bash

# Script para configurar credenciales de mainnet de forma segura

echo "🔐 Configuración de Credenciales de Mainnet"
echo "=========================================="
echo ""

# Archivo .env
ENV_FILE="packages/snfoundry/.env"

echo "📍 Tu dirección de Braavos:"
echo "0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565"
echo ""

# Solicitar clave privada de forma segura
echo "🔑 Ahora necesito tu CLAVE PRIVADA de Braavos"
echo "⚠️  IMPORTANTE: Esta clave se guardará SOLO en tu .env local"
echo "⚠️  NUNCA la compartas con nadie más"
echo ""
echo "Ingresa tu clave privada (debe empezar con 0x):"
read -s PRIVATE_KEY

echo ""
echo ""
echo "📝 Configurando archivo .env..."

# Backup del .env actual si existe
if [ -f "$ENV_FILE" ]; then
    cp "$ENV_FILE" "${ENV_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
    echo "✅ Backup creado: ${ENV_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Leer el contenido actual y actualizar las líneas de mainnet
if [ -f "$ENV_FILE" ]; then
    # Descomentar y actualizar las líneas de mainnet
    sed -i 's/# ACCOUNT_ADDRESS_MAINNET=.*/ACCOUNT_ADDRESS_MAINNET=0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565/' "$ENV_FILE"
    sed -i "s|# PRIVATE_KEY_MAINNET=.*|PRIVATE_KEY_MAINNET=$PRIVATE_KEY|" "$ENV_FILE"
    sed -i 's|# RPC_URL_MAINNET=.*|RPC_URL_MAINNET=https://starknet-mainnet.public.blastapi.io/rpc/v0_7|' "$ENV_FILE"
    
    # Si las líneas no existen (no están comentadas), agregarlas
    if ! grep -q "ACCOUNT_ADDRESS_MAINNET=" "$ENV_FILE"; then
        echo "" >> "$ENV_FILE"
        echo "# Mainnet Configuration" >> "$ENV_FILE"
        echo "ACCOUNT_ADDRESS_MAINNET=0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565" >> "$ENV_FILE"
        echo "PRIVATE_KEY_MAINNET=$PRIVATE_KEY" >> "$ENV_FILE"
        echo "RPC_URL_MAINNET=https://starknet-mainnet.public.blastapi.io/rpc/v0_7" >> "$ENV_FILE"
    fi
else
    # Crear nuevo archivo .env
    cat > "$ENV_FILE" << EOF
# Mainnet Configuration
ACCOUNT_ADDRESS_MAINNET=0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565
PRIVATE_KEY_MAINNET=$PRIVATE_KEY
RPC_URL_MAINNET=https://starknet-mainnet.public.blastapi.io/rpc/v0_7

# Devnet Configuration (keep for local development)
ACCOUNT_ADDRESS_DEVNET=0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691
PRIVATE_KEY_DEVNET=0x71d7bb07b9a64f6f78ac4c816aff4da9
RPC_URL_DEVNET=http://127.0.0.1:5050
EOF
fi

echo "✅ Archivo .env configurado correctamente"
echo ""
echo "🔒 Verificando seguridad..."

# Verificar que .env está en .gitignore
if grep -qE "^\.env$|^\*\*\/\.env|^\.env\*|^\*\*\/\.env\*" .gitignore 2>/dev/null; then
    echo "✅ .env está protegido en .gitignore"
else
    echo "⚠️  Agregando .env a .gitignore por seguridad..."
    echo ".env" >> .gitignore
    echo "✅ .env agregado a .gitignore"
fi

echo ""
echo "🎉 ¡Configuración completada!"
echo ""
echo "📋 Próximos pasos:"
echo "1. Verifica que tu cuenta esté deployed"
echo "2. Ejecuta: cd packages/snfoundry && yarn deploy --network mainnet"
echo ""

