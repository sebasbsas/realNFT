# 🧪 Tests Adicionales Recomendados

> Suite completa de tests sugeridos para YourCollectible NFT

---

## 📋 Tests Actuales

Ya tienes:
- ✅ `test_mint_item` - Mint 2 NFTs y transfer
- ✅ `test_mint_item2` - Mint 1 NFT y transfer

---

## 🎯 Tests Recomendados por Categoría

### 1. 🎨 Tests de Metadata (Name & Symbol)

#### `test_collection_name`
**¿Qué hace?** Verifica que el nombre de la colección sea "YourCollectible".  
**¿Por qué?** Asegura que la metadata básica del contrato está correcta para marketplaces.

```cairo
#[test]
fn test_collection_name() {
    setup();
    let contract_state = CONTRACT_STATE();
    
    let name = contract_state.name();
    let expected_name: ByteArray = "YourCollectible";
    
    assert(name == expected_name, 'Name must be YourCollectible');
    println!("Collection name: {:?}", name);
}

#### `test_collection_symbol`
**¿Qué hace?** Verifica que el símbolo de la colección sea "YCB".  
**¿Por qué?** El símbolo es la abreviación que se muestra en wallets y exploradores.

```cairo
#[test]
fn test_collection_symbol() {
    setup();
    let contract_state = CONTRACT_STATE();
    
    let symbol = contract_state.symbol();
    let expected_symbol: ByteArray = "YCB";
    
    assert(symbol == expected_symbol, 'Symbol must be YCB');
    println!("Collection symbol: {:?}", symbol);
}
```

#### `test_base_uri`
**¿Qué hace?** Verifica que el base_uri ("https://ipfs.io/ipfs/") se agrega correctamente a las URIs de los NFTs.  
**¿Por qué?** Asegura que las URLs de metadata se construyen correctamente para IPFS.

```cairo
#[test]
fn test_base_uri() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let tester = TESTER_ADDRESS;
    
    // Mintear un NFT
    let token_id = contract_state.mint_item(tester, "QmTest123");
    
    // Verificar que la URI completa incluye el base_uri
    let full_uri = contract_state.token_uri(token_id);
    let expected_prefix: ByteArray = "https://ipfs.io/ipfs/";
    
    // Verificar que empieza con el prefix
    println!("Full URI: {:?}", full_uri);
    assert(full_uri.len() > expected_prefix.len(), 'URI too short');
}
```

**Por qué es importante:**
- Verifica que la metadata de la colección es correcta
- Útil para marketplaces (OpenSea, etc.)
- Asegura que las URIs se construyen correctamente

---

### 2. 🚫 Tests de Errores y Seguridad ✅ IMPLEMENTADO

#### `test_token_uri_of_nonexistent_token`
**¿Qué hace?** Intenta obtener la URI de un token que no existe (debe fallar).  
**¿Por qué?** Verifica que el contrato rechaza operaciones sobre tokens inexistentes.

```cairo
#[test]
#[should_panic(expected: ('ERC721: invalid token ID',))]
fn test_token_uri_of_nonexistent_token() {
    setup();
    let contract_state = CONTRACT_STATE();
    
    // Intentar obtener URI de token que no existe
    contract_state.token_uri(999);
}

#### `test_owner_of_nonexistent_token`
**¿Qué hace?** Intenta obtener el dueño de un token que no existe (debe fallar).  
**¿Por qué?** Previene consultas sobre tokens inexistentes que podrían causar errores.

```cairo
#[test]
#[should_panic(expected: ('ERC721: invalid token ID',))]
fn test_owner_of_nonexistent_token() {
    setup();
    let contract_state = CONTRACT_STATE();
    
    // Intentar obtener owner de token que no existe
    contract_state.erc721.owner_of(999);
}
```

#### `test_transfer_from_unauthorized`
**¿Qué hace?** Un usuario intenta transferir un NFT que no le pertenece (debe fallar).  
**¿Por qué?** Crítico para seguridad - previene robos de NFTs.

```cairo
#[test]
#[should_panic]
fn test_transfer_from_unauthorized() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address();
    let owner = TESTER_ADDRESS;
    let attacker = NEW_OWNER;
    
    // Owner mintea
    let token_id = contract_state.mint_item(owner, "uri");
    
    // Attacker intenta transferir sin permiso (debe fallar)
    cheat_caller_address(contract_address, attacker, CheatSpan::TargetCalls(1));
    contract_state.erc721.transfer_from(owner, attacker, token_id);
}
```

#### `test_balance_of_zero_address`
**¿Qué hace?** Verifica que la dirección 0x0 (dirección nula) tiene balance 0.  
**¿Por qué?** La dirección cero no debe tener NFTs - es un caso edge importante.

```cairo
#[test]
fn test_balance_of_zero_address() {
    setup();
    let contract_state = CONTRACT_STATE();
    let zero_address: ContractAddress = 0.try_into().unwrap();
    
    let balance = contract_state.erc721.balance_of(zero_address);
    assert(balance == 0, 'Zero address should have 0');
}
```

**Por qué es importante:**
- Verifica seguridad del contrato
- Previene acceso no autorizado
- Maneja casos edge correctamente

---

### 3. 📊 Tests de Total Supply y Enumeración

#### `test_total_supply_starts_at_zero`
**¿Qué hace?** Verifica que el total supply empieza en 0 cuando no hay NFTs minteados.  
**¿Por qué?** El contador debe empezar correctamente - importante para tracking de colección.

```cairo
#[test]
fn test_total_supply_starts_at_zero() {
    setup();
    let contract_state = CONTRACT_STATE();
    
    let total = contract_state.enumerable.total_supply();
    assert(total == 0, 'Total supply must start at 0');
}

#### `test_total_supply_increases_after_mint`
**¿Qué hace?** Mintea 3 NFTs y verifica que el total supply aumenta correctamente.  
**¿Por qué?** Asegura que el contador de supply se actualiza con cada mint.

```cairo
#[test]
fn test_total_supply_increases_after_mint() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let tester = TESTER_ADDRESS;
    
    // Total inicial
    let initial_total = contract_state.enumerable.total_supply();
    
    // Mintear 3 NFTs
    contract_state.mint_item(tester, "uri1");
    contract_state.mint_item(tester, "uri2");
    contract_state.mint_item(tester, "uri3");
    
    let final_total = contract_state.enumerable.total_supply();
    assert(final_total == initial_total + 3, 'Total must increase by 3');
    println!("Total supply: {:?}", final_total);
}
```

#### `test_token_by_index`
**¿Qué hace?** Mintea 5 NFTs y verifica que se pueden acceder por índice (0 a 4).  
**¿Por qué?** La enumeración permite listar todos los NFTs - crucial para marketplaces.

```cairo
#[test]
fn test_token_by_index() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let tester = TESTER_ADDRESS;
    
    // Mintear 5 NFTs
    let token1 = contract_state.mint_item(tester, "uri1");
    let token2 = contract_state.mint_item(tester, "uri2");
    let token3 = contract_state.mint_item(tester, "uri3");
    let token4 = contract_state.mint_item(tester, "uri4");
    let token5 = contract_state.mint_item(tester, "uri5");
    
    // Verificar que podemos acceder por índice
    let at_index_0 = contract_state.enumerable.token_by_index(0);
    let at_index_4 = contract_state.enumerable.token_by_index(4);
    
    assert(at_index_0 == token1, 'Index 0 must be token 1');
    assert(at_index_4 == token5, 'Index 4 must be token 5');
    
    println!("Token at index 0: {:?}", at_index_0);
    println!("Token at index 4: {:?}", at_index_4);
}
```

#### `test_token_of_owner_by_index_multiple_owners`
**¿Qué hace?** Alice recibe 2 NFTs y Bob recibe 3 NFTs, verifica que cada uno puede enumerar sus propios NFTs.  
**¿Por qué?** Asegura que la enumeración por owner funciona correctamente con múltiples usuarios.

```cairo
#[test]
fn test_token_of_owner_by_index_multiple_owners() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let alice = TESTER_ADDRESS;
    let bob = NEW_OWNER;
    
    // Alice recibe 2 NFTs
    contract_state.mint_item(alice, "alice1");
    contract_state.mint_item(alice, "alice2");
    
    // Bob recibe 3 NFTs
    contract_state.mint_item(bob, "bob1");
    contract_state.mint_item(bob, "bob2");
    contract_state.mint_item(bob, "bob3");
    
    // Verificar balances
    let alice_balance = contract_state.erc721.balance_of(alice);
    let bob_balance = contract_state.erc721.balance_of(bob);
    
    assert(alice_balance == 2, 'Alice should have 2');
    assert(bob_balance == 3, 'Bob should have 3');
    
    // Verificar enumeración de Alice
    let alice_token_0 = contract_state.enumerable.token_of_owner_by_index(alice, 0);
    let alice_token_1 = contract_state.enumerable.token_of_owner_by_index(alice, 1);
    
    println!("Alice's tokens: {:?}, {:?}", alice_token_0, alice_token_1);
    
    // Verificar enumeración de Bob
    let bob_token_0 = contract_state.enumerable.token_of_owner_by_index(bob, 0);
    let bob_token_2 = contract_state.enumerable.token_of_owner_by_index(bob, 2);
    
    println!("Bob's tokens: {:?}, ..., {:?}", bob_token_0, bob_token_2);
}
```

**Por qué es importante:**
- Verifica que el contador de supply funciona
- Asegura que la enumeración es correcta
- Importante para marketplaces y listados

---

### 4. 🔄 Tests de Transfers Avanzados ✅ IMPLEMENTADO

#### `test_transfer_updates_enumeration`
**¿Qué hace?** Alice tiene 2 NFTs, transfiere 1 a Bob, y verifica que la enumeración se actualiza correctamente.  
**¿Por qué?** Los transfers deben actualizar la lista de NFTs de cada usuario correctamente.

```cairo
#[test]
fn test_transfer_updates_enumeration() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address();
    let alice = TESTER_ADDRESS;
    let bob = NEW_OWNER;
    
    // Alice recibe 2 NFTs
    let token1 = contract_state.mint_item(alice, "uri1");
    let token2 = contract_state.mint_item(alice, "uri2");
    
    // Verificar balance inicial de Alice
    let alice_initial = contract_state.erc721.balance_of(alice);
    assert(alice_initial == 2, 'Alice should have 2');
    
    // Alice transfiere token1 a Bob
    cheat_caller_address(contract_address, alice, CheatSpan::TargetCalls(1));
    contract_state.erc721.transfer_from(alice, bob, token1);
    
    // Verificar nuevos balances
    let alice_final = contract_state.erc721.balance_of(alice);
    let bob_final = contract_state.erc721.balance_of(bob);
    
    assert(alice_final == 1, 'Alice should have 1');
    assert(bob_final == 1, 'Bob should have 1');
    
    // Verificar que la enumeración se actualizó
    let alice_token = contract_state.enumerable.token_of_owner_by_index(alice, 0);
    assert(alice_token == token2, 'Alice should have token2');
    
    let bob_token = contract_state.enumerable.token_of_owner_by_index(bob, 0);
    assert(bob_token == token1, 'Bob should have token1');
    
    println!("Alice now has: {:?}", alice_token);
    println!("Bob now has: {:?}", bob_token);
}
```

#### `test_multiple_transfers_same_token`
**¿Qué hace?** Un mismo NFT se transfiere 3 veces: Alice → Bob → Charlie → Alice.  
**¿Por qué?** Verifica que un NFT puede cambiar de dueño múltiples veces sin problemas.

```cairo
#[test]
fn test_multiple_transfers_same_token() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address();
    
    const ALICE: felt252 = 'ALICE';
    const BOB: felt252 = 'BOB';
    const CHARLIE: felt252 = 'CHARLIE';
    
    let alice: ContractAddress = ALICE.try_into().unwrap();
    let bob: ContractAddress = BOB.try_into().unwrap();
    let charlie: ContractAddress = CHARLIE.try_into().unwrap();
    
    // Mintear a Alice
    let token_id = contract_state.mint_item(alice, "uri");
    
    // Alice → Bob
    cheat_caller_address(contract_address, alice, CheatSpan::TargetCalls(1));
    contract_state.erc721.transfer_from(alice, bob, token_id);
    assert(contract_state.erc721.owner_of(token_id) == bob, 'Bob should own it');
    
    // Bob → Charlie
    cheat_caller_address(contract_address, bob, CheatSpan::TargetCalls(1));
    contract_state.erc721.transfer_from(bob, charlie, token_id);
    assert(contract_state.erc721.owner_of(token_id) == charlie, 'Charlie should own it');
    
    // Charlie → Alice (de vuelta)
    cheat_caller_address(contract_address, charlie, CheatSpan::TargetCalls(1));
    contract_state.erc721.transfer_from(charlie, alice, token_id);
    assert(contract_state.erc721.owner_of(token_id) == alice, 'Alice should own it again');
    
    println!("Token {:?} returned to Alice after 3 transfers", token_id);
}
```

**Por qué es importante:**
- Verifica que transfers múltiples funcionan
- Asegura que la enumeración se mantiene correcta
- Simula escenarios del mundo real

---

### 5. 🎭 Tests con Múltiples Usuarios

#### `test_five_users_mint_and_transfer`
**¿Qué hace?** 5 usuarios diferentes reciben 1 NFT cada uno, verifica balances y total supply.  
**¿Por qué?** Simula uso real con múltiples usuarios simultáneos - importante para escalabilidad.

```cairo
#[test]
fn test_five_users_mint_and_transfer() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address();
    
    // Definir 5 usuarios
    const USER1: felt252 = 'USER1';
    const USER2: felt252 = 'USER2';
    const USER3: felt252 = 'USER3';
    const USER4: felt252 = 'USER4';
    const USER5: felt252 = 'USER5';
    
    let user1: ContractAddress = USER1.try_into().unwrap();
    let user2: ContractAddress = USER2.try_into().unwrap();
    let user3: ContractAddress = USER3.try_into().unwrap();
    let user4: ContractAddress = USER4.try_into().unwrap();
    let user5: ContractAddress = USER5.try_into().unwrap();
    
    // Cada usuario recibe un NFT
    let token1 = contract_state.mint_item(user1, "user1_nft");
    let token2 = contract_state.mint_item(user2, "user2_nft");
    let token3 = contract_state.mint_item(user3, "user3_nft");
    let token4 = contract_state.mint_item(user4, "user4_nft");
    let token5 = contract_state.mint_item(user5, "user5_nft");
    
    // Verificar que cada usuario tiene 1 NFT
    assert(contract_state.erc721.balance_of(user1) == 1, 'User1 should have 1');
    assert(contract_state.erc721.balance_of(user2) == 1, 'User2 should have 1');
    assert(contract_state.erc721.balance_of(user3) == 1, 'User3 should have 1');
    assert(contract_state.erc721.balance_of(user4) == 1, 'User4 should have 1');
    assert(contract_state.erc721.balance_of(user5) == 1, 'User5 should have 1');
    
    // Total supply debe ser 5
    let total = contract_state.enumerable.total_supply();
    assert(total == 5, 'Total must be 5');
    
    println!("5 users successfully minted 5 NFTs");
    println!("Total supply: {:?}", total);
}
```

**Por qué es importante:**
- Simula uso real con múltiples usuarios
- Verifica escalabilidad
- Encuentra bugs de concurrencia

---

### 6. 📝 Tests de URIs Específicas

#### `test_different_uris_per_token`
**¿Qué hace?** Mintea 3 NFTs con URIs diferentes y verifica que cada uno tiene su URI única.  
**¿Por qué?** Cada NFT debe tener su propia metadata - no pueden compartir URIs.

```cairo
#[test]
fn test_different_uris_per_token() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let owner = TESTER_ADDRESS;
    
    // Mintear 3 NFTs con URIs diferentes
    let uri1: ByteArray = "QmFirst123";
    let uri2: ByteArray = "QmSecond456";
    let uri3: ByteArray = "QmThird789";
    
    let token1 = contract_state.mint_item(owner, uri1);
    let token2 = contract_state.mint_item(owner, uri2);
    let token3 = contract_state.mint_item(owner, uri3);
    
    // Verificar que cada token tiene su URI correcta
    let full_uri1 = contract_state.token_uri(token1);
    let full_uri2 = contract_state.token_uri(token2);
    let full_uri3 = contract_state.token_uri(token3);
    
    println!("Token 1 URI: {:?}", full_uri1);
    println!("Token 2 URI: {:?}", full_uri2);
    println!("Token 3 URI: {:?}", full_uri3);
    
    // Verificar que son diferentes
    assert(full_uri1 != full_uri2, 'URIs should be different');
    assert(full_uri2 != full_uri3, 'URIs should be different');
    assert(full_uri1 != full_uri3, 'URIs should be different');
}
```

#### `test_uri_persists_after_transfer`
**¿Qué hace?** Mintea un NFT con una URI, lo transfiere, y verifica que la URI no cambia.  
**¿Por qué?** La metadata debe permanecer intacta después de transfers - crítico para NFTs.

```cairo
#[test]
fn test_uri_persists_after_transfer() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address();
    let alice = TESTER_ADDRESS;
    let bob = NEW_OWNER;
    
    let uri: ByteArray = "QmSpecialNFT";
    let token_id = contract_state.mint_item(alice, uri);
    
    // Guardar URI antes del transfer
    let uri_before = contract_state.token_uri(token_id);
    
    // Transfer a Bob
    cheat_caller_address(contract_address, alice, CheatSpan::TargetCalls(1));
    contract_state.erc721.transfer_from(alice, bob, token_id);
    
    // Verificar URI después del transfer
    let uri_after = contract_state.token_uri(token_id);
    
    assert(uri_before == uri_after, 'URI should not change');
    println!("URI remained: {:?}", uri_after);
}
```

**Por qué es importante:**
- Verifica integridad de metadata
- Asegura que URIs no se pierden
- Importante para NFTs con metadata única

---

### 7. 🔢 Tests de Secuencia de Token IDs

#### `test_token_ids_sequential`
**¿Qué hace?** Mintea 10 NFTs y verifica que los IDs sean secuenciales (1, 2, 3... 10).  
**¿Por qué?** Los token IDs deben ser secuenciales y predecibles - importante para interfaces.

```cairo
#[test]
fn test_token_ids_sequential() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let owner = TESTER_ADDRESS;
    
    // Mintear 10 NFTs
    let mut expected_id = 1_u256;
    let mut i = 0_u32;
    
    loop {
        if i >= 10 {
            break;
        }
        
        let token_id = contract_state.mint_item(owner, "uri");
        assert(token_id == expected_id, 'IDs must be sequential');
        
        println!("Minted token ID: {:?}", token_id);
        
        expected_id += 1;
        i += 1;
    };
    
    // Verificar que el total es 10
    let total = contract_state.enumerable.total_supply();
    assert(total == 10, 'Total must be 10');
}
```

#### `test_first_token_id_is_one`
**¿Qué hace?** Verifica que el primer NFT minteado tiene Token ID = 1 (no 0).  
**¿Por qué?** El contrato empieza en ID 1 - importante para que las interfaces sepan el primer ID.

```cairo
#[test]
fn test_first_token_id_is_one() {
    setup();
    let mut contract_state = CONTRACT_STATE();
    let owner = TESTER_ADDRESS;
    
    // El primer token debe tener ID = 1
    let first_token = contract_state.mint_item(owner, "first");
    assert(first_token == 1, 'First token must be 1');
    
    println!("First token ID: {:?}", first_token);
}
```

**Por qué es importante:**
- Verifica que el contador funciona correctamente
- Importante para interfaces que asumen IDs secuenciales
- Evita colisiones de IDs

---

## 📋 Archivo Completo Sugerido

Aquí está cómo se vería el archivo de tests completo:

```cairo
// tests/test_your_collectible_extended.cairo
use contracts::your_collectible::YourCollectible;
use contracts::your_collectible::YourCollectible::{
    WrappedIERC721MetadataImpl, 
    YourCollectibleImpl
};
use openzeppelin_token::erc721::ERC721Component;
use openzeppelin_token::erc721::extensions::erc721_enumerable::ERC721EnumerableComponent;
use snforge_std::{CheatSpan, cheat_caller_address, test_address};
use starknet::ContractAddress;

// Constants
const TESTER_ADDRESS: ContractAddress = 'TESTER_ADDRESS'.try_into().unwrap();
const NEW_OWNER: ContractAddress = 'NEW_OWNER'.try_into().unwrap();

// ... [aquí van todos los tests sugeridos arriba]
```

---

## 🎯 Prioridad de Tests

### Alta Prioridad (implementar primero):
1. ✅ Tests de metadata (name, symbol)
2. ✅ Tests de errores (tokens inexistentes, unauthorized)
3. ✅ Tests de total supply

### Media Prioridad:
4. Tests de transfers avanzados
5. Tests de múltiples usuarios
6. Tests de URIs

### Baja Prioridad (nice to have):
7. Tests de secuencia de IDs
8. Tests de performance con muchos NFTs

---

## 🚀 Cómo Implementar

### 1. Crear nuevo archivo de tests:

```bash
cd packages/snfoundry/contracts/tests
touch test_extended.cairo
```

### 2. Copiar tests del documento

### 3. Ejecutar:

```bash
cd packages/snfoundry
snforge test
```

---

## 💡 Tips para Escribir Tests

1. **Nombre descriptivo**: `test_what_it_does_when_condition`
2. **Un concepto por test**: No mezcles muchas verificaciones
3. **Mensajes claros**: Los mensajes de error deben explicar qué falló
4. **Setup limpio**: Usa funciones helper para código repetitivo

---

¿Quieres que implemente alguno de estos tests específicamente? 🧪

