#!/bin/bash

# Script para verificar el token URI de un NFT minteado en Starknet
# Uso: ./check_nft_uri.sh <token_id>

CONTRACT_ADDRESS="0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080"
RPC_URL="https://starknet-mainnet.public.blastapi.io/rpc/v0_9"
TOKEN_ID=${1:-1}

echo "🔍 Debugging NFT Token URI..."
echo "📋 Contract: $CONTRACT_ADDRESS"
echo "🆔 Token ID: $TOKEN_ID"
echo "🌐 RPC: $RPC_URL"
echo ""

# Función para hacer llamadas RPC
call_rpc() {
    local method="$1"
    local params="$2"
    
    curl -s -X POST "$RPC_URL" \
        -H "Content-Type: application/json" \
        -d "{
            \"jsonrpc\": \"2.0\",
            \"method\": \"starknet_call\",
            \"params\": {
                \"request\": {
                    \"contract_address\": \"$CONTRACT_ADDRESS\",
                    \"entry_point_selector\": \"$method\",
                    \"calldata\": [$params]
                },
                \"block_id\": \"latest\"
            },
            \"id\": 1
        }"
}

# Obtener selector de función para token_uri
TOKEN_URI_SELECTOR=$(python3 -c "
import hashlib
selector = hashlib.sha256(b'token_uri(u256)').hexdigest()[:8]
print('0x' + selector)
" 2>/dev/null || echo "0x0f1b9c8a")  # Fallback

echo "📊 Verificando token URI..."
echo "🔍 Selector: $TOKEN_URI_SELECTOR"

# Convertir token ID a hex
TOKEN_ID_HEX=$(printf "0x%x" $TOKEN_ID)

# Llamar a token_uri
echo "🔍 Llamando a token_uri con token ID: $TOKEN_ID_HEX"
RESPONSE=$(call_rpc "$TOKEN_URI_SELECTOR" "$TOKEN_ID_HEX")

echo "📝 Respuesta RPC:"
echo "$RESPONSE" | jq '.' 2>/dev/null || echo "$RESPONSE"

# Extraer URI si existe
URI=$(echo "$RESPONSE" | jq -r '.result[0] // empty' 2>/dev/null)

if [ -n "$URI" ] && [ "$URI" != "null" ] && [ "$URI" != "0" ]; then
    echo ""
    echo "✅ Token URI encontrada: $URI"
    
    # Intentar acceder al contenido
    echo ""
    echo "🌐 Verificando contenido de la URI..."
    
    # Convertir ipfs:// a https://ipfs.io/ipfs/
    if [[ "$URI" == ipfs://* ]]; then
        HTTP_URI=$(echo "$URI" | sed 's|ipfs://|https://ipfs.io/ipfs/|')
    else
        HTTP_URI="$URI"
    fi
    
    echo "🔗 URI procesada: $HTTP_URI"
    
    # Verificar si la URI es accesible
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$HTTP_URI")
    
    if [ "$HTTP_STATUS" = "200" ]; then
        echo "✅ URI accesible (HTTP $HTTP_STATUS)"
        echo "📄 Contenido:"
        curl -s "$HTTP_URI" | jq '.' 2>/dev/null || curl -s "$HTTP_URI"
    else
        echo "❌ URI no accesible (HTTP $HTTP_STATUS)"
    fi
else
    echo ""
    echo "❌ No se encontró URI para el token $TOKEN_ID"
    echo "💡 Posibles causas:"
    echo "   - El token no existe"
    echo "   - La URI está vacía"
    echo "   - Error en la llamada al contrato"
fi

echo ""
echo "🔍 Información adicional:"
echo "   - Transacción: https://voyager.online/tx/0x7a50a958a7ddd1219360e98beecbae2c37163d3cb95299e212c4c95a5c9538"
echo "   - Contrato: https://starkscan.co/contract/$CONTRACT_ADDRESS"
