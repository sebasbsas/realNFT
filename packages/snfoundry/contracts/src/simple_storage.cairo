/// Interface representing `SimpleStorage`.
#[starknet::interface]
pub trait ISimpleStorage<TContractState> {
    /// Set a value in storage.
    fn set_value(ref self: TContractState, value: u256);
    /// Retrieve the stored value.
    fn get_value(self: @TContractState) -> u256;
}

/// Simple storage contract for managing a single value.
#[starknet::contract]
mod SimpleStorage {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage {
        stored_value: u256,
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        self.stored_value.write(0);
    }

    #[abi(embed_v0)]
    impl SimpleStorageImpl of super::ISimpleStorage<ContractState> {
        fn set_value(ref self: ContractState, value: u256) {
            self.stored_value.write(value);
        }

        fn get_value(self: @ContractState) -> u256 {
            self.stored_value.read()
        }
    }
}
