#!/bin/bash

# Script para iniciar Starknet Devnet en modo persistente
# Este script NO detiene el devnet actual, solo inicia uno nuevo con persistencia

echo "🚀 Iniciando Starknet Devnet en modo persistente..."

# Crear directorio para la base de datos si no existe
mkdir -p ./devnet-data

# Iniciar devnet con persistencia en puerto 5050 (reemplaza el actual)
starknet-devnet \
    --port 5050 \
    --db-path ./devnet-data/devnet.db \
    --seed 0 \
    --accounts 1 \
    --initial-balance 1000000000000000000000 \
    --gas-price 1000000000 \
    --chain-id SN_DEVNET \
    --fork-network devnet \
    --fork-block 0 \
    --host 127.0.0.1 \
    --timeout 60 \
    --disable-rpc-request-validation \
    --disable-request-validation \
    --allow-max-fee-override \
    --max-fee-override 1000000000000000000000 &

echo "✅ Devnet persistente iniciado en puerto 5050"
echo "📊 Base de datos: ./devnet-data/devnet.db"
echo "🌐 URL: http://127.0.0.1:5050"
echo "🔗 Chain ID: SN_DEVNET"
echo ""
echo "✅ Tu aplicación NextJS ya está configurada para este puerto"
echo "✅ Los contratos desplegados se mantendrán entre reinicios"
echo ""
echo "PID del proceso: $!"
