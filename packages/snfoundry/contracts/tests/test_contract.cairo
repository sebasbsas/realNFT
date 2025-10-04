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
    assert_eq!(new_balance, starting_balance + 1, "Starting Balance must be increased by 1");
    println!("Tester address new balance: {:?}", new_balance);

    // Should track tokens of owner by index
    let index = new_balance - 1;
    let first_token_id = contract_state.enumerable.token_of_owner_by_index(tester_address, index);
    println!("Token of owner(0x{:x}) by index({:?}): {:?}", tester_address, index, first_token_id);
    assert_eq!(first_token_id, expected_token_id, "Token must be 1");

    // mint another item
    let url2: ByteArray = "QmVHi3c4qkZcH3cJynzDXRm5n7dzc9R9TUtUcfnWQvhdcw";
    let second_token_id = contract_state.mint_item(tester_address, url2);
    let expected_token_id = 2;
    assert(second_token_id == expected_token_id, 'Token ID must be 2');
    println!("Item minted! Token ID: {:?}", second_token_id);
    let new_balance = contract_state.erc721.balance_of(tester_address);
    assert_eq!(new_balance, starting_balance + 2, "Starting Balance must be increased by 2");
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
    assert_eq!(new_balance, starting_balance + 1, "Starting Balance must be increased by 1");
    println!("Tester address new balance: {:?}", new_balance);

    // Should track tokens of owner by index
    let index = new_balance - 1;
    let first_token_id = contract_state.enumerable.token_of_owner_by_index(tester_address, index);
    println!("Token of owner(0x{:x}) by index({:?}): {:?}", tester_address, index, first_token_id);
    assert_eq!(first_token_id, expected_token_id, "Token must be 1");

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
