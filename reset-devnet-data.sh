#!/bin/bash

# Script para resetear la base de datos persistente de Devnet
# Este script NO detiene el devnet, solo limpia los datos

echo "🗑️  Reseteando base de datos persistente de Devnet..."

# Verificar si existe el directorio de datos
if [ -d "./devnet-data" ]; then
    echo "📁 Directorio devnet-data encontrado"
    
    # Hacer backup de la base de datos actual
    if [ -f "./devnet-data/devnet.db" ]; then
        echo "💾 Creando backup de la base de datos actual..."
        cp ./devnet-data/devnet.db ./devnet-data/devnet.db.backup.$(date +%Y%m%d_%H%M%S)
        echo "✅ Backup creado"
    fi
    
    # Eliminar la base de datos actual
    echo "🗑️  Eliminando base de datos actual..."
    rm -f ./devnet-data/devnet.db
    rm -f ./devnet-data/devnet.db-wal
    rm -f ./devnet-data/devnet.db-shm
    
    echo "✅ Base de datos reseteada"
    echo ""
    echo "🔄 Para aplicar los cambios:"
    echo "1. Detén el devnet persistente (Ctrl+C en la terminal donde corre)"
    echo "2. Ejecuta: ./start-devnet-persistent.sh"
    echo ""
    echo "📊 El devnet se reiniciará con estado limpio"
    
else
    echo "❌ Directorio devnet-data no encontrado"
    echo "💡 Ejecuta primero: ./start-devnet-persistent.sh"
fi
