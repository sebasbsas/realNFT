use starknet::ContractAddress;
use starknet::storage::*;

#[starknet::interface]
pub trait IMinimalNFT<T> {
    fn mint(ref self: T, to: ContractAddress) -> u256;
    fn owner_of(self: @T, token_id: u256) -> ContractAddress;
    fn balance_of(self: @T, owner: ContractAddress) -> u256;
    fn name(self: @T) -> ByteArray;
    fn symbol(self: @T) -> ByteArray;
    fn total_supply(self: @T) -> u256;
}

#[starknet::contract]
pub mod MinimalNFT {
    use starknet::get_caller_address;
    use starknet::storage::*;
    use super::{ContractAddress, IMinimalNFT};

    #[storage]
    pub struct Storage {
        name: ByteArray,
        symbol: ByteArray,
        next_token_id: u256,
        owners: Map<u256, ContractAddress>,
        balances: Map<ContractAddress, u256>,
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
    }

    #[constructor]
    fn constructor(ref self: ContractState, name: ByteArray, symbol: ByteArray) {
        self.name.write(name);
        self.symbol.write(symbol);
        self.next_token_id.write(1);
        self.total_supply.write(0);
    }

    #[abi(embed_v0)]
    impl MinimalNFTImpl of IMinimalNFT<ContractState> {
        fn mint(ref self: ContractState, to: ContractAddress) -> u256 {
            let token_id = self.next_token_id.read();
            self.owners.write(token_id, to);

            let current_balance = self.balances.read(to);
            self.balances.write(to, current_balance + 1);

            let current_supply = self.total_supply.read();
            self.total_supply.write(current_supply + 1);

            self.next_token_id.write(token_id + 1);

            self.emit(Mint { to, token_id });
            token_id
        }

        fn owner_of(self: @ContractState, token_id: u256) -> ContractAddress {
            self.owners.read(token_id)
        }

        fn balance_of(self: @ContractState, owner: ContractAddress) -> u256 {
            self.balances.read(owner)
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
