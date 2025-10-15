#!/bin/bash

# Script para listar todos los tests disponibles en YourCollectible

echo "📋 Tests disponibles en test_contract.cairo:"
echo ""

cd "$(dirname "$0")/packages/snfoundry" || exit 1

# Buscar todas las funciones de test
grep "^fn test" contracts/tests/test_contract.cairo | \
    sed 's/fn //' | \
    sed 's/() {//' | \
    nl -w2 -s'. '

echo ""
echo "Total de tests: $(grep -c "^fn test" contracts/tests/test_contract.cairo)"
echo ""
echo "Para ejecutar todos: cd packages/snfoundry && yarn test"
echo "Para ejecutar uno específico: snforge test <nombre_del_test>"

