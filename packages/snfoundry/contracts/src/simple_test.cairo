use starknet::ContractAddress;

#[starknet::interface]
pub trait ISimpleTest<TContractState> {
    fn get_value(self: @TContractState) -> u256;
    fn set_value(ref self: TContractState, new_value: u256);
}

#[starknet::contract]
pub mod SimpleTest {
    use starknet::storage::*;
    use super::{ContractAddress, ISimpleTest};

    #[storage]
    pub struct Storage {
        value: u256,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        ValueSet: ValueSet,
    }

    #[derive(Drop, starknet::Event)]
    pub struct ValueSet {
        pub new_value: u256,
    }

    #[constructor]
    fn constructor(ref self: ContractState, initial_value: u256) {
        self.value.write(initial_value);
    }

    #[abi(embed_v0)]
    pub impl SimpleTestImpl of ISimpleTest<ContractState> {
        fn get_value(self: @ContractState) -> u256 {
            self.value.read()
        }

        fn set_value(ref self: ContractState, new_value: u256) {
            self.value.write(new_value);
            self.emit(Event::ValueSet(ValueSet { new_value }));
        }
    }
}
