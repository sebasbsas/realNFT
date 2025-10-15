#!/bin/bash

# Script para verificar si la cuenta está deployed en mainnet

ACCOUNT_ADDRESS="0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565"
RPC_URL="https://starknet-mainnet.public.blastapi.io/rpc/v0_7"

echo "🔍 Verificando estado de la cuenta..."
echo "Dirección: $ACCOUNT_ADDRESS"
echo ""

# Verificar si el contrato (cuenta) existe
RESPONSE=$(curl -s -X POST $RPC_URL \
  -H "Content-Type: application/json" \
  -d "{\"jsonrpc\":\"2.0\",\"method\":\"starknet_getClassHashAt\",\"params\":{\"block_id\":\"latest\",\"contract_address\":\"$ACCOUNT_ADDRESS\"},\"id\":1}")

# Verificar si hay error
if echo "$RESPONSE" | grep -q "Contract not found"; then
    echo "❌ Cuenta NO está deployed todavía"
    echo ""
    echo "Esperando... Verifica en Braavos el estado de tu transacción."
    echo "O verifica en: https://voyager.online/contract/$ACCOUNT_ADDRESS"
    echo ""
    echo "Ejecuta este script nuevamente cuando veas que la transacción está confirmada."
    exit 1
elif echo "$RESPONSE" | grep -q "error"; then
    echo "⚠️  Error al verificar:"
    echo "$RESPONSE" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE"
    exit 1
else
    echo "✅ ¡Cuenta DEPLOYED exitosamente!"
    echo ""
    CLASS_HASH=$(echo "$RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin).get('result', 'N/A'))" 2>/dev/null)
    if [ ! -z "$CLASS_HASH" ] && [ "$CLASS_HASH" != "N/A" ]; then
        echo "Class Hash: $CLASS_HASH"
    fi
    echo ""
    echo "🎉 Tu cuenta está lista para desplegar contratos!"
    echo ""
    echo "📋 Próximos pasos:"
    echo "1. Configura tus credenciales: ./configure-mainnet.sh"
    echo "2. Despliega el NFT: cd packages/snfoundry && yarn deploy --network mainnet"
    exit 0
fi

