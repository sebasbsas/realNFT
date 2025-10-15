use starknet::ContractAddress;

#[starknet::interface]
pub trait IYourCollectible<T> {
    fn mint_item(ref self: T, recipient: ContractAddress, uri_hash: felt252) -> u256;
    fn token_uri_hash(self: @T, token_id: u256) -> felt252;
}

#[starknet::contract]
pub mod YourCollectibleOptimized {
    use contracts::components::counter::CounterComponent;
    use openzeppelin_access::ownable::OwnableComponent;
    use openzeppelin_introspection::src5::SRC5Component;
    use openzeppelin_token::erc721::ERC721Component;
    use starknet::storage::*;
    use super::{ContractAddress, IYourCollectible};

    component!(path: ERC721Component, storage: erc721, event: ERC721Event);
    component!(path: SRC5Component, storage: src5, event: SRC5Event);
    component!(path: OwnableComponent, storage: ownable, event: OwnableEvent);
    component!(path: CounterComponent, storage: token_id_counter, event: CounterEvent);

    // Expose entrypoints
    #[abi(embed_v0)]
    impl OwnableImpl = OwnableComponent::OwnableImpl<ContractState>;
    #[abi(embed_v0)]
    impl CounterImpl = CounterComponent::CounterImpl<ContractState>;
    #[abi(embed_v0)]
    impl ERC721Impl = ERC721Component::ERC721Impl<ContractState>;
    #[abi(embed_v0)]
    impl SRC5Impl = SRC5Component::SRC5Impl<ContractState>;

    // Use internal implementations but do not expose them
    impl ERC721InternalImpl = ERC721Component::InternalImpl<ContractState>;
    impl OwnableInternalImpl = OwnableComponent::InternalImpl<ContractState>;

    #[storage]
    pub struct Storage {
        #[substorage(v0)]
        pub erc721: ERC721Component::Storage,
        #[substorage(v0)]
        src5: SRC5Component::Storage,
        #[substorage(v0)]
        ownable: OwnableComponent::Storage,
        #[substorage(v0)]
        token_id_counter: CounterComponent::Storage,
        // Optimized: Store only IPFS hash as felt252 instead of full ByteArray
        token_uri_hashes: Map<u256, felt252>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        ERC721Event: ERC721Component::Event,
        #[flat]
        SRC5Event: SRC5Component::Event,
        #[flat]
        OwnableEvent: OwnableComponent::Event,
        CounterEvent: CounterComponent::Event,
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        let name: ByteArray = "Questly Platinums";
        let symbol: ByteArray = "QEST";
        let base_uri: ByteArray = ""; // Empty base_uri

        // Initialize components
        self.ownable.initializer(owner);
        self.erc721.initializer(name, symbol, base_uri);
    }

    #[abi(embed_v0)]
    pub impl YourCollectibleImpl of IYourCollectible<ContractState> {
        fn mint_item(ref self: ContractState, recipient: ContractAddress, uri_hash: felt252) -> u256 {
            self.token_id_counter.increment();
            let token_id = self.token_id_counter.current();
            self.erc721.mint(recipient, token_id);
            // Store only the hash (much smaller than full URI)
            self.token_uri_hashes.write(token_id, uri_hash);
            token_id
        }

        fn token_uri_hash(self: @ContractState, token_id: u256) -> felt252 {
            assert(self.erc721.exists(token_id), ERC721Component::Errors::INVALID_TOKEN_ID);
            self.token_uri_hashes.read(token_id)
        }
    }

    // Implement ERC721 hooks with empty implementation
    impl ERC721HooksImpl of ERC721Component::ERC721HooksTrait<ContractState> {
        fn before_update(
            ref self: ERC721Component::ComponentState<ContractState>,
            to: ContractAddress,
            token_id: u256,
            auth: ContractAddress,
        ) {
            // No additional logic needed
        }
    }
}

