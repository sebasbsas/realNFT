#!/bin/bash

# Script para limpiar estado del devnet
set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/packages/snfoundry"

echo "🧹 Limpiando estado del devnet..."
echo "📁 Directorio de trabajo: $(pwd)"

# Eliminar archivo de estado
DEVNET_STATE_FILE="./devnet_state.json"
if [ -f "$DEVNET_STATE_FILE" ]; then
    rm "$DEVNET_STATE_FILE"
    echo "✅ Estado guardado eliminado: $DEVNET_STATE_FILE"
else
    echo "ℹ️  No hay estado guardado que eliminar"
fi

# Eliminar archivos de deploy
DEPLOYMENTS_DIR="./deployments"
if [ -d "$DEPLOYMENTS_DIR" ] && [ "$(ls -A $DEPLOYMENTS_DIR 2>/dev/null)" ]; then
    echo "🗑️  Eliminando deployments..."
    rm -rf "$DEPLOYMENTS_DIR"/*
    echo "✅ Deployments eliminados"
else
    echo "ℹ️  No hay deployments que eliminar"
fi

# Limpiar target de compilación
TARGET_DIR="./contracts/target"
if [ -d "$TARGET_DIR" ] && [ "$(ls -A $TARGET_DIR 2>/dev/null)" ]; then
    echo "🔨 Limpiando compilaciones..."
    rm -rf "$TARGET_DIR"/*
    echo "✅ Compilaciones eliminadas"
else
    echo "ℹ️  No hay compilaciones que eliminar"
fi

echo ""
echo "🎉 Limpieza completada. Próximo inicio será con estado limpio."
echo "💡 Usa './start_devnet.sh' para iniciar el devnet"
