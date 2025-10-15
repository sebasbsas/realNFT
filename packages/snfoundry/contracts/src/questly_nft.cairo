use starknet::ContractAddress;
use starknet::storage::*;

#[starknet::interface]
pub trait IQuestlyNFT<T> {
    fn mint_item(ref self: T, recipient: ContractAddress, uri: ByteArray) -> u256;
    fn owner_of(self: @T, token_id: u256) -> ContractAddress;
    fn balance_of(self: @T, owner: ContractAddress) -> u256;
    fn token_uri(self: @T, token_id: u256) -> ByteArray;
    fn name(self: @T) -> ByteArray;
    fn symbol(self: @T) -> ByteArray;
    fn total_supply(self: @T) -> u256;
}

#[starknet::contract]
pub mod QuestlyNFT {
    use starknet::storage::*;
    use super::{ContractAddress, IQuestlyNFT};

    #[storage]
    pub struct Storage {
        name: ByteArray,
        symbol: ByteArray,
        next_token_id: u256,
        owners: Map<u256, ContractAddress>,
        balances: Map<ContractAddress, u256>,
        token_uris: Map<u256, ByteArray>,
        total_supply: u256,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Transfer: Transfer,
        Mint: Mint,
    }

    #[derive(Drop, starknet::Event)]
    pub struct Transfer {
        pub from: ContractAddress,
        pub to: ContractAddress,
        pub token_id: u256,
    }

    #[derive(Drop, starknet::Event)]
    pub struct Mint {
        pub to: ContractAddress,
        pub token_id: u256,
        pub uri: ByteArray,
    }

    #[constructor]
    fn constructor(ref self: ContractState, name: ByteArray, symbol: ByteArray) {
        self.name.write(name);
        self.symbol.write(symbol);
        self.next_token_id.write(1);
        self.total_supply.write(0);
    }

    #[abi(embed_v0)]
    impl QuestlyNFTImpl of IQuestlyNFT<ContractState> {
        fn mint_item(ref self: ContractState, recipient: ContractAddress, uri: ByteArray) -> u256 {
            let token_id = self.next_token_id.read();
            
            // Set owner
            self.owners.write(token_id, recipient);

            // Update balance
            let current_balance = self.balances.read(recipient);
            self.balances.write(recipient, current_balance + 1);

            // Update supply
            let current_supply = self.total_supply.read();
            self.total_supply.write(current_supply + 1);

            // Store URI
            self.token_uris.write(token_id, uri.clone());

            // Increment token id
            self.next_token_id.write(token_id + 1);

            // Emit events
            self.emit(Transfer { 
                from: starknet::contract_address_const::<0>(), 
                to: recipient, 
                token_id 
            });
            self.emit(Mint { to: recipient, token_id, uri });
            
            token_id
        }

        fn owner_of(self: @ContractState, token_id: u256) -> ContractAddress {
            self.owners.read(token_id)
        }

        fn balance_of(self: @ContractState, owner: ContractAddress) -> u256 {
            self.balances.read(owner)
        }

        fn token_uri(self: @ContractState, token_id: u256) -> ByteArray {
            self.token_uris.read(token_id)
        }

        fn name(self: @ContractState) -> ByteArray {
            self.name.read()
        }

        fn symbol(self: @ContractState) -> ByteArray {
            self.symbol.read()
        }

        fn total_supply(self: @ContractState) -> u256 {
            self.total_supply.read()
        }
    }
}

