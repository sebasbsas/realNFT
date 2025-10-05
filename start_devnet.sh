#!/bin/bash

# Script para iniciar devnet con estado persistente
set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/packages/snfoundry"

DEVNET_STATE_FILE="./devnet_state.json"

echo "🚀 Iniciando Starknet Devnet..."
echo "📁 Directorio de trabajo: $(pwd)"

if [ -f "$DEVNET_STATE_FILE" ]; then
    echo "🔄 Cargando devnet con estado guardado..."
    echo "📄 Archivo de estado: $DEVNET_STATE_FILE"
    starknet-devnet --dump-path "$DEVNET_STATE_FILE" --load-path "$DEVNET_STATE_FILE"
else
    echo "🆕 Iniciando devnet limpio con seed 0..."
    echo "🌱 Seed: 0 (generará las mismas cuentas predefinidas)"
    starknet-devnet --seed 0 --dump-path "$DEVNET_STATE_FILE" --dump-on exit
fi
