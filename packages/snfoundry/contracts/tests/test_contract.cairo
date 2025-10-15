use contracts::your_collectible::YourCollectible;
use contracts::your_collectible::YourCollectible::{WrappedIERC721MetadataImpl, YourCollectibleImpl};
use core::traits::TryInto;
use openzeppelin_token::erc721::ERC721Component;
use openzeppelin_token::erc721::ERC721Component::{ERC721Impl, InternalImpl as ERC721InternalImpl};
use openzeppelin_token::erc721::extensions::erc721_enumerable::ERC721EnumerableComponent;
use openzeppelin_token::erc721::extensions::erc721_enumerable::ERC721EnumerableComponent::{
    ERC721EnumerableImpl, InternalImpl as EnumerableInternalTrait,
};
use snforge_std::{CheatSpan, cheat_caller_address, test_address};
use starknet::ContractAddress;

// Constants
const NEW_OWNER: ContractAddress = 'NEW_OWNER'.try_into().unwrap();
const TESTER_ADDRESS: ContractAddress = 'TESTER_ADDRESS'.try_into().unwrap();

// Component states
type EnumerableComponentState =
    ERC721EnumerableComponent::ComponentState<YourCollectible::ContractState>;
type ERC721ComponentState = ERC721Component::ComponentState<YourCollectible::ContractState>;

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

// Initialize the contract's ERC721 and ERC721Enumerable components
fn setup() {
    let mut erc721_state = ERC721_COMPONENT_STATE();
    let mut enumerable_state = ENUMERABLE_COMPONENT_STATE();
    enumerable_state.initializer();
    let name: ByteArray = "YourCollectible";
    let symbol: ByteArray = "YCB";
    let base_uri: ByteArray = "https://ipfs.io/ipfs/";
    erc721_state.initializer(name, symbol, base_uri);
}

#[test]
// Test: Should be able to mint "two" NFTs and transfer the first item to another account
fn test_mint_item() {
    setup();
    let tester_address = TESTER_ADDRESS;
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address(); // mock contract address

    println!("Tester address: 0x{:x}", tester_address);
    let starting_balance = contract_state.erc721.balance_of(tester_address);
    println!("Starting balance: {:?}", starting_balance);
    println!("Minting...");
    let url: ByteArray = "QmfVMAmNM1kDEBYrC2TPzQDoCRFH6F5tE1e9Mr4FkkR5Xr";
    let first_token_id = contract_state.mint_item(tester_address, url);
    let expected_token_id = 1;
    assert(first_token_id == expected_token_id, 'Token ID must be 1');
    println!("Item minted! Token ID: {:?}", first_token_id);
    let new_balance = contract_state.erc721.balance_of(tester_address);
    assert(new_balance == starting_balance + 1, 'Balance must increase by 1');
    println!("Tester address new balance: {:?}", new_balance);

    // Should track tokens of owner by index
    let index = new_balance - 1;
    let first_token_id = contract_state.enumerable.token_of_owner_by_index(tester_address, index);
    println!("Token of owner(0x{:x}) by index({:?}): {:?}", tester_address, index, first_token_id);
    assert(first_token_id == expected_token_id, 'Token must be 1');

    // mint another item
    let url2: ByteArray = "QmVHi3c4qkZcH3cJynzDXRm5n7dzc9R9TUtUcfnWQvhdcw";
    let second_token_id = contract_state.mint_item(tester_address, url2);
    let expected_token_id = 2;
    assert(second_token_id == expected_token_id, 'Token ID must be 2');
    println!("Item minted! Token ID: {:?}", second_token_id);
    let new_balance = contract_state.erc721.balance_of(tester_address);
    assert(new_balance == starting_balance + 2, 'Balance must increase by 2');
    println!("Tester address New balance: {:?}", new_balance);

    // transfer item
    let new_owner = NEW_OWNER;
    println!("new_owner address: 0x{:x}", new_owner);
    let new_owner_starting_balance = contract_state.erc721.balance_of(new_owner);
    println!("Starting balance new_owner: {:?}", new_owner_starting_balance);

    println!("Transfering first item...");
    // Change the caller address of the YourCollectible to the tester_address
    cheat_caller_address(contract_address, tester_address, CheatSpan::TargetCalls(1));
    contract_state
        .erc721
        .transfer_from(tester_address, new_owner, first_token_id); // first_token_id = 1
    let balance_new_owner = contract_state.erc721.balance_of(new_owner);
    assert(balance_new_owner == new_owner_starting_balance + 1, 'Balance must be increased by 1');
    println!("New balance new_owner: {:?}", balance_new_owner);

    let balance_tester = contract_state.erc721.balance_of(tester_address);
    assert(balance_tester == new_balance - 1, 'Balance must be decreased by 1');
    println!("New balance tester: {:?}", balance_tester);

    let token_uri = contract_state.token_uri(first_token_id); // first_token_id = 1
    println!("Token URI: {:?}", token_uri);

    // owner_of
    let owner = contract_state.erc721.owner_of(first_token_id); // first_token_id = 1
    assert(owner == new_owner, 'Owner must be new_owner');

    let owner = contract_state.erc721.owner_of(second_token_id); // second_token_id = 2
    assert(owner == tester_address, 'Owner must be tester_address');

    let index = contract_state.enumerable.token_of_owner_by_index(new_owner, balance_new_owner - 1);
    println!("token of owner by index: {:?}", index);
    assert(index == 1, 'Token must be 1');

    let index = contract_state
        .enumerable
        .token_of_owner_by_index(tester_address, balance_tester - 1);
    println!("token of owner by index: {:?}", index);
    assert(index == 2, 'Token must be 2');
}
#[test]
// Test: Should be able to mint a NFT and transfer it to another account
fn test_mint_item2() {
    setup();
    let tester_address = TESTER_ADDRESS;
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address(); // mock contract address

    println!("Tester address: 0x{:x}", tester_address);
    let starting_balance = contract_state.erc721.balance_of(tester_address);
    println!("Starting balance: {:?}", starting_balance);
    println!("Minting...");
    let url: ByteArray = "QmfVMAmNM1kDEBYrC2TPzQDoCRFH6F5tE1e9Mr4FkkR5Xr";
    let first_token_id = contract_state.mint_item(tester_address, url);
    let expected_token_id = 1;
    assert(first_token_id == expected_token_id, 'Token ID must be 1');
    println!("Item minted! Token ID: {:?}", first_token_id);
    let new_balance = contract_state.erc721.balance_of(tester_address);
    assert(new_balance == starting_balance + 1, 'Balance must increase by 1');
    println!("Tester address new balance: {:?}", new_balance);

    // Should track tokens of owner by index
    let index = new_balance - 1;
    let first_token_id = contract_state.enumerable.token_of_owner_by_index(tester_address, index);
    println!("Token of owner(0x{:x}) by index({:?}): {:?}", tester_address, index, first_token_id);
    assert(first_token_id == expected_token_id, 'Token must be 1');

    // transfer item
    let new_owner = NEW_OWNER;
    println!("new_owner address: 0x{:x}", new_owner);
    let new_owner_starting_balance = contract_state.erc721.balance_of(new_owner);
    println!("Starting balance new_owner: {:?}", new_owner_starting_balance);

    println!("Transfering first item...");
    // Change the caller address of the YourCollectible to the tester_address
    cheat_caller_address(contract_address, tester_address, CheatSpan::TargetCalls(1));
    contract_state
        .erc721
        .transfer_from(tester_address, new_owner, first_token_id); // first_token_id = 1 
    let balance_new_owner = contract_state.erc721.balance_of(new_owner);
    assert(balance_new_owner == new_owner_starting_balance + 1, 'Balance must be increased by 1');
    println!("New balance new_owner: {:?}", balance_new_owner);

    let balance_tester = contract_state.erc721.balance_of(tester_address);
    assert(balance_tester == new_balance - 1, 'Balance must be decreased by 1');
    println!("New balance tester: {:?}", balance_tester);

    let token_uri = contract_state.token_uri(first_token_id); // first_token_id = 1
    println!("Token URI: {:?}", token_uri);

    // owner_of
    let owner = contract_state.erc721.owner_of(first_token_id);
    assert(owner == new_owner, 'Owner must be new_owner');

    let index = contract_state.enumerable.token_of_owner_by_index(new_owner, balance_new_owner - 1);
    println!("token of owner by index: {:?}", index);
    assert(index == 1, 'Token must be 1');
}

// ============================================
// Tests de Errores y Seguridad
// ============================================

#[test]
#[should_panic(expected: ('ERC721: invalid token ID',))]
fn test_token_uri_of_nonexistent_token() {
    // ¿Qué hace? Intenta obtener la URI de un token que no existe (debe fallar)
    // ¿Por qué? Verifica que el contrato rechaza operaciones sobre tokens inexistentes
    setup();
    let contract_state = CONTRACT_STATE();
    
    // Intentar obtener URI de token que no existe
    contract_state.token_uri(999);
}

#[test]
#[should_panic(expected: ('ERC721: invalid token ID',))]
fn test_owner_of_nonexistent_token() {
    // ¿Qué hace? Intenta obtener el dueño de un token que no existe (debe fallar)
    // ¿Por qué? Previene consultas sobre tokens inexistentes que podrían causar errores
    setup();
    let contract_state = CONTRACT_STATE();
    
    // Intentar obtener owner de token que no existe
    contract_state.erc721.owner_of(999);
}

#[test]
#[should_panic]
fn test_transfer_from_unauthorized() {
    // ¿Qué hace? Un usuario intenta transferir un NFT que no le pertenece (debe fallar)
    // ¿Por qué? Crítico para seguridad - previene robos de NFTs
    setup();
    let mut contract_state = CONTRACT_STATE();
    let contract_address = test_address();
    let owner = TESTER_ADDRESS;
    let attacker = NEW_OWNER;
    
    // Owner mintea un NFT
    let token_id = contract_state.mint_item(owner, "uri");
    
    // Attacker intenta transferir sin permiso (debe fallar)
    cheat_caller_address(contract_address, attacker, CheatSpan::TargetCalls(1));
    contract_state.erc721.transfer_from(owner, attacker, token_id);
}

#[test]
#[should_panic(expected: ('ERC721: invalid account',))]
fn test_balance_of_zero_address() {
    // ¿Qué hace? Verifica que consultar balance de dirección 0x0 falla (debe rechazarse)
    // ¿Por qué? La dirección cero es inválida - el contrato debe rechazar operaciones con ella
    setup();
    let contract_state = CONTRACT_STATE();
    let zero_address: ContractAddress = 0.try_into().unwrap();
    
    // Debe fallar porque la dirección cero es inválida
    contract_state.erc721.balance_of(zero_address);
}

// ============================================
// Tests de Transfers Avanzados
// ============================================

#[test]
fn test_transfer_updates_enumeration() {
    // ¿Qué hace? Alice tiene 2 NFTs, transfiere 1 a Bob, y verifica que la enumeración se actualiza correctamente
    // ¿Por qué? Los transfers deben actualizar la lista de NFTs de cada usuario correctamente
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
    
    println!("Alice now has token: {:?}", alice_token);
    println!("Bob now has token: {:?}", bob_token);
}

#[test]
fn test_multiple_transfers_same_token() {
    // ¿Qué hace? Un mismo NFT se transfiere 3 veces: Alice → Bob → Charlie → Alice
    // ¿Por qué? Verifica que un NFT puede cambiar de dueño múltiples veces sin problemas
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
