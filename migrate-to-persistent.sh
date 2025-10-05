#!/bin/bash

# Script para migrar el devnet actual a modo persistente manteniendo el contrato
# Este script NO detiene el devnet actual, solo prepara la migración

echo "🔄 Preparando migración a devnet persistente..."

# Información del contrato actual
CONTRACT_ADDRESS="0x077b1aaf5f519938a4de3bd0b948e8eb17b9a6569f16b1c8c10c63329df9e4e8"
DEVNET_URL="http://127.0.0.1:5050"

echo "📍 Contract Address actual: $CONTRACT_ADDRESS"

# Crear directorio para la migración
mkdir -p ./devnet-migration

# Crear script de migración completa
cat > ./devnet-migration/migrate.sh << 'EOF'
#!/bin/bash

echo "🚀 Iniciando migración completa a devnet persistente..."

# Información del contrato
CONTRACT_ADDRESS="0x077b1aaf5f519938a4de3bd0b948e8eb17b9a6569f16b1c8c10c63329df9e4e8"

# 1. Detener el devnet actual (esto lo harás manualmente)
echo "⏸️  PASO 1: Detén el devnet actual (Ctrl+C en la terminal donde corre)"
echo "   Presiona Enter cuando hayas detenido el devnet..."
read

# 2. Crear directorio para devnet persistente
mkdir -p ./devnet-data

# 3. Iniciar devnet persistente con configuración idéntica
echo "🚀 PASO 2: Iniciando devnet persistente con configuración idéntica..."
starknet-devnet \
    --port 5050 \
    --db-path ./devnet-data/devnet.db \
    --seed 0 \
    --accounts 1 \
    --initial-balance 1000000000000000000000 \
    --gas-price 1000000000 \
    --chain-id SN_DEVNET \
    --host 127.0.0.1 \
    --timeout 60 \
    --disable-rpc-request-validation \
    --disable-request-validation \
    --allow-max-fee-override \
    --max-fee-override 1000000000000000000000 &

DEVNET_PID=$!
echo "✅ Devnet persistente iniciado (PID: $DEVNET_PID)"

# 4. Esperar a que el devnet esté listo
echo "⏳ Esperando a que el devnet esté listo..."
sleep 10

# 5. Redeployar el contrato (esto debería generar la misma dirección con el mismo seed)
echo "🔄 PASO 3: Redeployando contrato para mantener la misma dirección..."
cd packages/snfoundry
yarn deploy

# 6. Verificar que el contrato se desplegó correctamente
echo "✅ PASO 4: Verificando deployment..."
if [ -f "contracts/deployedContracts.ts" ]; then
    NEW_ADDRESS=$(grep -A 1 "address:" contracts/deployedContracts.ts | head -2 | tail -1 | tr -d ' "' | tr -d ',')
    echo "📍 Nueva dirección del contrato: $NEW_ADDRESS"
    
    if [ "$NEW_ADDRESS" = "0x077b1aaf5f519938a4de3bd0b948e8eb17b9a6569f16b1c8c10c63329df9e4e8" ]; then
        echo "🎉 ¡ÉXITO! El contrato mantiene la misma dirección"
    else
        echo "⚠️  El contrato tiene una nueva dirección: $NEW_ADDRESS"
        echo "💡 Actualiza tu aplicación con la nueva dirección"
    fi
fi

cd ../..

echo ""
echo "✅ Migración completada"
echo "📊 Base de datos persistente: ./devnet-data/devnet.db"
echo "🌐 URL: http://127.0.0.1:5050"
echo "🔗 Chain ID: SN_DEVNET"
echo ""
echo "🎯 Tu aplicación NextJS debería funcionar igual que antes"
echo "💾 Los datos se mantendrán entre reinicios del devnet"
EOF

chmod +x ./devnet-migration/migrate.sh

echo "✅ Script de migración creado"
echo "📁 Ubicación: ./devnet-migration/migrate.sh"
echo ""
echo "🚀 Para ejecutar la migración:"
echo "  ./devnet-migration/migrate.sh"
echo ""
echo "📋 El script te guiará paso a paso:"
echo "  1. Detener el devnet actual"
echo "  2. Iniciar devnet persistente"
echo "  3. Redeployar el contrato"
echo "  4. Verificar que todo funciona"
echo ""
echo "⚠️  IMPORTANTE: Con el mismo seed (0), el contrato debería mantener la misma dirección"
