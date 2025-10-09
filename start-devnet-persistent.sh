#!/bin/bash

# Script para iniciar Starknet Devnet en modo persistente
# Compatible con starknet-devnet 0.5.1
# NOTA: Esta versión solo GUARDA el estado, NO puede recargarlo automáticamente

echo "🚀 Iniciando Starknet Devnet con guardado de estado..."

# Crear directorio para dumps si no existe
mkdir -p ./devnet-data

# Verificar si existe dump previo
if [ -f "./devnet-data/devnet_dump.pkl" ]; then
    echo "⚠️  Dump previo encontrado en ./devnet-data/devnet_dump.pkl"
    echo "⚠️  Esta versión de devnet NO puede recargarlo automáticamente"
    echo "⚠️  El dump será sobrescrito con el nuevo estado"
    echo ""
fi

# Iniciar devnet con guardado de estado
starknet-devnet \
    --port 5050 \
    --seed 0 \
    --accounts 1 \
    --initial-balance 1000000000000000000000 \
    --gas-price 1000000000 \
    --host 127.0.0.1 \
    --timeout 60 \
    --dump-path ./devnet-data/devnet_dump.pkl \
    --dump-on block &

DEVNET_PID=$!

echo "✅ Devnet iniciado en puerto 5050"
echo "📊 El estado se guardará en: ./devnet-data/devnet_dump.pkl"
echo "🌐 URL: http://127.0.0.1:5050"
echo "🆔 PID del proceso: $DEVNET_PID"
echo ""
echo "💾 Modo: --dump-on block (guarda después de cada bloque minado)"
echo ""
echo "⚠️  LIMITACIÓN DE VERSIÓN 0.5.1:"
echo "   - Guarda el estado en tiempo real ✅"
echo "   - NO puede recargar el estado automáticamente ❌"
echo "   - Para persistencia real, actualiza a starknet-devnet-rs"
echo ""
echo "Para detener: kill $DEVNET_PID (o pkill starknet-devnet)"
echo ""
