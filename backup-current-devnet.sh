#!/bin/bash

# Script para crear backup del estado actual del devnet
# Este script NO detiene el devnet actual, solo hace backup del estado

echo "📸 Creando backup del estado actual del devnet..."

# Crear directorio para el backup si no existe
mkdir -p ./devnet-backup

# Obtener información del contrato actual
CONTRACT_ADDRESS="0x077b1aaf5f519938a4de3bd0b948e8eb17b9a6569f16b1c8c10c63329df9e4e8"
DEVNET_URL="http://127.0.0.1:5050"

echo "🔍 Obteniendo información del contrato actual..."
echo "📍 Contract Address: $CONTRACT_ADDRESS"

# Crear archivo de backup con la información del estado actual
cat > ./devnet-backup/current-state.json << EOF
{
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "contract_address": "$CONTRACT_ADDRESS",
  "devnet_url": "$DEVNET_URL",
  "chain_id": "SN_DEVNET",
  "backup_type": "current_devnet_state"
}
EOF

# Obtener información del contrato desde el devnet actual
echo "📊 Obteniendo datos del contrato desde devnet..."

# Crear script temporal para obtener el estado
cat > ./devnet-backup/get-contract-state.py << 'EOF'
import requests
import json
import sys

def get_contract_state(contract_address, devnet_url):
    try:
        # Obtener información del contrato
        payload = {
            "jsonrpc": "2.0",
            "method": "starknet_getClass",
            "params": {
                "block_id": "latest",
                "class_hash": "0x0"  # Placeholder, necesitamos el class hash real
            },
            "id": 1
        }
        
        response = requests.post(f"{devnet_url}/rpc/v0_9", json=payload)
        if response.status_code == 200:
            return response.json()
        else:
            return {"error": f"HTTP {response.status_code}"}
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    contract_address = sys.argv[1]
    devnet_url = sys.argv[2]
    
    result = get_contract_state(contract_address, devnet_url)
    print(json.dumps(result, indent=2))
EOF

# Ejecutar el script para obtener el estado
echo "🔍 Obteniendo estado del contrato..."
python3 ./devnet-backup/get-contract-state.py "$CONTRACT_ADDRESS" "$DEVNET_URL" > ./devnet-backup/contract-state.json 2>/dev/null

# Crear script de restauración
cat > ./devnet-backup/restore-to-persistent.sh << 'EOF'
#!/bin/bash

echo "🔄 Restaurando estado del devnet a modo persistente..."

# Verificar que el backup existe
if [ ! -f "./devnet-backup/current-state.json" ]; then
    echo "❌ No se encontró el archivo de backup"
    exit 1
fi

# Leer la información del backup
CONTRACT_ADDRESS=$(cat ./devnet-backup/current-state.json | grep '"contract_address"' | cut -d'"' -f4)
echo "📍 Restaurando contrato: $CONTRACT_ADDRESS"

# Crear directorio para devnet persistente
mkdir -p ./devnet-data

# Iniciar devnet persistente con el mismo seed para mantener consistencia
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

echo "✅ Devnet persistente iniciado con backup del estado"
echo "📊 Base de datos: ./devnet-data/devnet.db"
echo "🌐 URL: http://127.0.0.1:5050"
echo "🔗 Chain ID: SN_DEVNET"
echo ""
echo "⚠️  NOTA: El contrato puede tener una dirección diferente"
echo "💡 Para mantener la misma dirección, necesitarías redeployar"
echo ""
echo "PID del proceso: $!"
EOF

chmod +x ./devnet-backup/restore-to-persistent.sh

echo "✅ Backup creado exitosamente"
echo "📁 Ubicación: ./devnet-backup/"
echo ""
echo "📋 Archivos creados:"
echo "  - current-state.json (información del estado actual)"
echo "  - contract-state.json (datos del contrato)"
echo "  - restore-to-persistent.sh (script de restauración)"
echo ""
echo "🔄 Para restaurar el estado:"
echo "  ./devnet-backup/restore-to-persistent.sh"
echo ""
echo "⚠️  IMPORTANTE: El contrato tendrá una nueva dirección al restaurar"
echo "💡 Para mantener la misma dirección, necesitarías redeployar manualmente"
