# 🧪 Testing Guide - Scaffold-Stark 2

> Guía completa para testear contratos Cairo con Starknet Foundry

**Herramienta:** Starknet Foundry (`snforge`)  
**Framework:** Cairo Test Framework

---

## 🚀 Quick Start

### Ejecutar TODOS los tests:

```bash
cd packages/snfoundry
yarn test
```

O directamente:

```bash
cd packages/snfoundry
snforge test
```

### Ejecutar un test específico:

```bash
snforge test test_mint_item
```

### Ejecutar con output detallado:

```bash
snforge test --detailed
```

---

## 📁 Estructura de Testing

```
packages/snfoundry/
├── contracts/
│   ├── src/
│   │   └── your_collectible.cairo  ← Tu contrato
│   └── tests/
│       └── test_contract.cairo     ← Tus tests ⭐
├── Scarb.toml                      ← Configuración
└── snfoundry.toml                  ← Config de Foundry
```

---

## 📝 Anatomía de un Test

### Estructura básica:

```cairo
#[test]
fn test_my_function() {
    // 1. Setup: Preparar el entorno
    setup();
    
    // 2. Arrange: Configurar datos
    let mut contract_state = CONTRACT_STATE();
    let test_address = TESTER_ADDRESS;
    
    // 3. Act: Ejecutar la función a testear
    let result = contract_state.mint_item(test_address, "uri");
    
    // 4. Assert: Verificar el resultado
    assert(result == 1, 'Token ID must be 1');
}
```

---

## 🛠️ Herramientas Disponibles

### 1. **snforge_std** - Utilidades de testing

```cairo
use snforge_std::{
    CheatSpan,              // Control de llamadas
    cheat_caller_address,   // Simular caller
    test_address,           // Dirección de prueba
    start_cheat_caller_address,  // Iniciar simulación
    stop_cheat_caller_address,   // Detener simulación
};
```

### 2. **Assertions**

```cairo
// Assertion simple
assert(condition, 'Error message');

// Assertion con comparación
assert_eq!(value1, value2, "Values must be equal");

// Assertion con diferencia
assert_ne!(value1, value2, "Values must be different");
```

### 3. **Print/Debug**

```cairo
// Imprimir en tests
println!("Value: {:?}", my_value);
println!("Address: 0x{:x}", address);
```

---

## 📚 Ejemplo Completo: Test de Mint

### Test actual del proyecto:

```cairo
#[test]
fn test_mint_item() {
    // 1. SETUP: Inicializar componentes
    setup();
    
    // 2. ARRANGE: Preparar datos
    let tester_address = TESTER_ADDRESS;
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address();
    
    println!("Tester address: 0x{:x}", tester_address);
    let starting_balance = contract_state.erc721.balance_of(tester_address);
    println!("Starting balance: {:?}", starting_balance);
    
    // 3. ACT: Ejecutar mint
    println!("Minting...");
    let url: ByteArray = "QmfVMAmNM1kDEBYrC2TPzQDoCRFH6F5tE1e9Mr4FkkR5Xr";
    let first_token_id = contract_state.mint_item(tester_address, url);
    
    // 4. ASSERT: Verificar resultados
    let expected_token_id = 1;
    assert(first_token_id == expected_token_id, 'Token ID must be 1');
    println!("Item minted! Token ID: {:?}", first_token_id);
    
    let new_balance = contract_state.erc721.balance_of(tester_address);
    assert_eq!(
        new_balance, 
        starting_balance + 1, 
        "Starting Balance must be increased by 1"
    );
    println!("Tester address new balance: {:?}", new_balance);
}
```

---

## 🎯 Ejemplos de Tests Comunes

### 1. Test de Balance

```cairo
#[test]
fn test_balance_after_mint() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let recipient = TESTER_ADDRESS;
    
    // Balance inicial
    let initial_balance = contract_state.erc721.balance_of(recipient);
    
    // Mintear
    contract_state.mint_item(recipient, "ipfs://test");
    
    // Verificar balance
    let new_balance = contract_state.erc721.balance_of(recipient);
    assert_eq!(new_balance, initial_balance + 1, "Balance should increase");
}
```

### 2. Test de Ownership

```cairo
#[test]
fn test_nft_ownership() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let owner = TESTER_ADDRESS;
    
    // Mintear NFT
    let token_id = contract_state.mint_item(owner, "ipfs://test");
    
    // Verificar owner
    let nft_owner = contract_state.erc721.owner_of(token_id);
    assert(nft_owner == owner, 'Owner must match');
}
```

### 3. Test de Transfer

```cairo
#[test]
fn test_transfer_nft() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address();
    let from = TESTER_ADDRESS;
    let to = NEW_OWNER;
    
    // Mintear NFT
    let token_id = contract_state.mint_item(from, "ipfs://test");
    
    // Simular que el caller es 'from'
    cheat_caller_address(contract_address, from, CheatSpan::TargetCalls(1));
    
    // Transferir
    contract_state.erc721.transfer_from(from, to, token_id);
    
    // Verificar nuevo owner
    let new_owner = contract_state.erc721.owner_of(token_id);
    assert(new_owner == to, 'Transfer failed');
}
```

### 4. Test de URI

```cairo
#[test]
fn test_token_uri() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let owner = TESTER_ADDRESS;
    let uri: ByteArray = "QmTest123";
    
    // Mintear con URI específico
    let token_id = contract_state.mint_item(owner, uri);
    
    // Verificar URI
    let stored_uri = contract_state.token_uri(token_id);
    let expected_uri = format!("https://ipfs.io/ipfs/{}", uri);
    assert(stored_uri == expected_uri, 'URI mismatch');
}
```

### 5. Test de Enumerable

```cairo
#[test]
fn test_token_enumeration() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let owner = TESTER_ADDRESS;
    
    // Mintear 3 NFTs
    contract_state.mint_item(owner, "uri1");
    contract_state.mint_item(owner, "uri2");
    contract_state.mint_item(owner, "uri3");
    
    // Verificar total supply
    let total = contract_state.enumerable.total_supply();
    assert(total == 3, 'Total supply must be 3');
    
    // Verificar token por índice
    let token_at_index_0 = contract_state.enumerable.token_by_index(0);
    assert(token_at_index_0 == 1, 'First token must be 1');
}
```

---

## 🎭 Testing con Múltiples Usuarios

```cairo
// Definir constantes para usuarios
const ALICE: felt252 = 'ALICE';
const BOB: felt252 = 'BOB';
const CHARLIE: felt252 = 'CHARLIE';

#[test]
fn test_multiple_users() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address();
    
    let alice: ContractAddress = ALICE.try_into().unwrap();
    let bob: ContractAddress = BOB.try_into().unwrap();
    
    // Alice mintea un NFT
    cheat_caller_address(contract_address, alice, CheatSpan::TargetCalls(1));
    let token_1 = contract_state.mint_item(alice, "alice_nft");
    
    // Bob mintea un NFT
    cheat_caller_address(contract_address, bob, CheatSpan::TargetCalls(1));
    let token_2 = contract_state.mint_item(bob, "bob_nft");
    
    // Verificar owners
    assert(contract_state.erc721.owner_of(token_1) == alice, 'Alice owns token 1');
    assert(contract_state.erc721.owner_of(token_2) == bob, 'Bob owns token 2');
}
```

---

## 🚨 Testing de Errores

### Test que debe fallar:

```cairo
#[test]
#[should_panic(expected: ('INVALID_TOKEN_ID',))]
fn test_invalid_token_uri() {
    setup();
    let contract_state = CONTRACT_STATE();
    
    // Intentar obtener URI de token inexistente (debe fallar)
    contract_state.token_uri(999);
}
```

### Test de autorización:

```cairo
#[test]
#[should_panic(expected: ('ERC721: unauthorized caller',))]
fn test_unauthorized_transfer() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address();
    let owner = TESTER_ADDRESS;
    let attacker = NEW_OWNER;
    
    // Owner mintea
    let token_id = contract_state.mint_item(owner, "uri");
    
    // Attacker intenta transferir (debe fallar)
    cheat_caller_address(contract_address, attacker, CheatSpan::TargetCalls(1));
    contract_state.erc721.transfer_from(owner, attacker, token_id);
}
```

---

## 📊 Comandos Útiles

### Ejecutar tests:

```bash
# Todos los tests
snforge test

# Con output detallado
snforge test --detailed

# Test específico
snforge test test_mint_item

# Con gas report
snforge test --gas-report

# Solo mostrar failures
snforge test --quiet

# Con coverage (si está configurado)
snforge test --coverage
```

### Compilar antes de testear:

```bash
scarb build
```

### Ver tests disponibles:

```bash
snforge test --list
```

---

## 🎨 Setup y Helpers

### Función Setup típica:

```cairo
fn setup() {
    let mut erc721_state = ERC721_COMPONENT_STATE();
    let mut enumerable_state = ENUMERABLE_COMPONENT_STATE();
    
    // Inicializar componentes
    enumerable_state.initializer();
    
    let name: ByteArray = "YourCollectible";
    let symbol: ByteArray = "YCB";
    let base_uri: ByteArray = "https://ipfs.io/ipfs/";
    
    erc721_state.initializer(name, symbol, base_uri);
}
```

### Helper para crear estado:

```cairo
// Contract state
fn CONTRACT_STATE() -> YourCollectible::ContractState {
    YourCollectible::contract_state_for_testing()
}

// Component states
fn ENUMERABLE_COMPONENT_STATE() -> EnumerableComponentState {
    ERC721EnumerableComponent::component_state_for_testing()
}

fn ERC721_COMPONENT_STATE() -> ERC721ComponentState {
    ERC721Component::component_state_for_testing()
}
```

---

## 💡 Mejores Prácticas

### 1. **Nombrar tests descriptivamente**

```cairo
❌ fn test1() { }
✅ fn test_mint_increases_balance() { }

❌ fn test_transfer() { }
✅ fn test_transfer_updates_owner_correctly() { }
```

### 2. **Usar patrón AAA (Arrange-Act-Assert)**

```cairo
#[test]
fn test_example() {
    // ARRANGE: Preparar
    setup();
    let mut state = CONTRACT_STATE();
    let user = TEST_ADDRESS;
    
    // ACT: Ejecutar
    let result = state.some_function(user);
    
    // ASSERT: Verificar
    assert(result == expected, 'Error message');
}
```

### 3. **Mensajes de error claros**

```cairo
❌ assert(result == 1, 'error');
✅ assert(result == 1, 'Token ID must be 1');

❌ assert_eq!(balance, 5, "fail");
✅ assert_eq!(balance, 5, "Balance should be 5 after minting");
```

### 4. **Testear casos edge**

```cairo
// Caso normal
#[test]
fn test_mint_normal() { }

// Casos edge
#[test]
fn test_mint_to_zero_address() { }

#[test]
fn test_mint_with_empty_uri() { }

#[test]
fn test_mint_max_supply() { }
```

### 5. **Un test, un concepto**

```cairo
❌ // Test que hace demasiado
#[test]
fn test_everything() {
    // mint, transfer, approve, burn...
}

✅ // Tests específicos
#[test]
fn test_mint() { }

#[test]
fn test_transfer() { }

#[test]
fn test_approve() { }
```

---

## 🔧 Configuración Avanzada

### snfoundry.toml:

```toml
[snforge]
exit_first = false  # No parar en primer error
fuzzer_runs = 256   # Runs para fuzzing

[profile.default]
sierra = true

[profile.release]
sierra = true
```

### Scarb.toml (dev-dependencies):

```toml
[dev-dependencies]
snforge_std = "0.44.0"
assert_macros = "2.11.4"
```

---

## 📈 Ejemplo: Test Suite Completa

```cairo
// test_your_collectible.cairo
use contracts::your_collectible::YourCollectible;
use snforge_std::{CheatSpan, cheat_caller_address, test_address};
use starknet::ContractAddress;

// Constantes
const OWNER: ContractAddress = 'OWNER'.try_into().unwrap();
const USER1: ContractAddress = 'USER1'.try_into().unwrap();
const USER2: ContractAddress = 'USER2'.try_into().unwrap();

// Setup
fn setup() -> YourCollectible::ContractState {
    let mut state = CONTRACT_STATE();
    // Inicializar...
    state
}

// Tests de Mint
mod mint_tests {
    use super::*;
    
    #[test]
    fn test_mint_increases_balance() { }
    
    #[test]
    fn test_mint_increments_token_id() { }
    
    #[test]
    fn test_mint_sets_correct_owner() { }
    
    #[test]
    fn test_mint_sets_token_uri() { }
}

// Tests de Transfer
mod transfer_tests {
    use super::*;
    
    #[test]
    fn test_transfer_updates_owner() { }
    
    #[test]
    fn test_transfer_updates_balances() { }
    
    #[test]
    #[should_panic]
    fn test_transfer_unauthorized_fails() { }
}

// Tests de Enumerable
mod enumerable_tests {
    use super::*;
    
    #[test]
    fn test_total_supply_increases() { }
    
    #[test]
    fn test_token_by_index() { }
    
    #[test]
    fn test_token_of_owner_by_index() { }
}
```

---

## 🎯 Testing en CI/CD

### GitHub Actions ejemplo:

```yaml
# .github/workflows/test.yml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Install Scarb
        run: |
          curl -L https://github.com/software-mansion/scarb/releases/download/v2.11.4/scarb-v2.11.4-x86_64-unknown-linux-gnu.tar.gz | tar -xz
          echo "$PWD/scarb-v2.11.4-x86_64-unknown-linux-gnu/bin" >> $GITHUB_PATH
      
      - name: Run tests
        run: |
          cd packages/snfoundry
          scarb build
          snforge test
```

---

## 📚 Recursos Adicionales

### Documentación:
- [Starknet Foundry Book](https://foundry-rs.github.io/starknet-foundry/)
- [Cairo Testing Guide](https://book.cairo-lang.org/ch10-00-testing-cairo-programs.html)
- [OpenZeppelin Cairo Tests](https://github.com/OpenZeppelin/cairo-contracts)

### Ejemplos:
- Tests actuales: `packages/snfoundry/contracts/tests/test_contract.cairo`
- OpenZeppelin tests: Excelentes ejemplos de tests

---

## 🚀 Quick Reference

```bash
# Ejecutar tests
yarn test                          # Desde raíz del proyecto
cd packages/snfoundry && snforge test  # Directo

# Con opciones
snforge test --detailed            # Output detallado
snforge test --gas-report          # Reporte de gas
snforge test test_mint_item        # Test específico

# Compilar
scarb build                        # Compilar contratos

# Ver tests
snforge test --list                # Listar tests
```

---

## ✅ Checklist de Testing

Antes de hacer push:

- [ ] Todos los tests pasan
- [ ] Tests para funciones nuevas
- [ ] Tests para casos edge
- [ ] Tests de errores (should_panic)
- [ ] Mensajes de error claros
- [ ] Sin warnings en compilación
- [ ] Gas usage razonable

---

¡Ya estás listo para testear como un pro! 🧪🚀

**Siguiente paso:** Ejecuta `yarn test` y verifica que todo funciona.

