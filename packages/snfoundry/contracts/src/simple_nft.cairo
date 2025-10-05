use starknet::ContractAddress;

#[starknet::interface]
pub trait ISimpleNFT<T> {
    fn mint_item(ref self: T, recipient: ContractAddress, uri: ByteArray) -> u256;
}

#[starknet::contract]
pub mod SimpleNFT {
    use openzeppelin_access::ownable::OwnableComponent;
    use openzeppelin_introspection::src5::SRC5Component;
    use openzeppelin_token::erc721::ERC721Component;
    use starknet::storage::*;
    use super::{ContractAddress, ISimpleNFT};

    component!(path: ERC721Component, storage: erc721, event: ERC721Event);
    component!(path: SRC5Component, storage: src5, event: SRC5Event);
    component!(path: OwnableComponent, storage: ownable, event: OwnableEvent);

    // Expose entrypoints
    #[abi(embed_v0)]
    impl OwnableImpl = OwnableComponent::OwnableImpl<ContractState>;
    #[abi(embed_v0)]
    impl ERC721Impl = ERC721Component::ERC721Impl<ContractState>;
    #[abi(embed_v0)]
    impl SRC5Impl = SRC5Component::SRC5Impl<ContractState>;

    // Use internal implementations but do not expose them
    impl ERC721InternalImpl = ERC721Component::InternalImpl<ContractState>;
    impl OwnableInternalImpl = OwnableComponent::InternalImpl<ContractState>;
    
    // Implement ERC721HooksTrait
    impl ERC721HooksImpl of ERC721Component::ERC721HooksTrait<ContractState> {
        fn before_update(
            ref self: ERC721Component::ComponentState<ContractState>,
            to: ContractAddress,
            token_id: u256,
            auth: ContractAddress,
        ) {
            // Empty implementation - no hooks needed
        }
    }

    #[storage]
    pub struct Storage {
        #[substorage(v0)]
        pub erc721: ERC721Component::Storage,
        #[substorage(v0)]
        src5: SRC5Component::Storage,
        #[substorage(v0)]
        ownable: OwnableComponent::Storage,
        // Simple counter for token IDs
        next_token_id: u256,
        // Mapping for token URIs
        token_uris: Map<u256, ByteArray>,
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
        TokenMinted: TokenMinted,
    }

    #[derive(Drop, starknet::Event)]
    pub struct TokenMinted {
        pub recipient: ContractAddress,
        pub token_id: u256,
        pub uri: ByteArray,
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        let name: ByteArray = "SimpleNFT";
        let symbol: ByteArray = "SNFT";
        let base_uri: ByteArray = "https://ipfs.io/ipfs/";

        // Initialize components in the correct order
        self.ownable.initializer(owner);
        self.erc721.initializer(name, symbol, base_uri);
        self.next_token_id.write(1);
    }

    #[abi(embed_v0)]
    pub impl SimpleNFTImpl of ISimpleNFT<ContractState> {
        fn mint_item(ref self: ContractState, recipient: ContractAddress, uri: ByteArray) -> u256 {
            self.ownable.assert_only_owner();
            
            let token_id = self.next_token_id.read();
            self.erc721.mint(recipient, token_id);
            self.token_uris.write(token_id, uri.clone());
            
            self.next_token_id.write(token_id + 1);
            
            self.emit(TokenMinted { recipient, token_id, uri });
            token_id
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn token_uri(self: @ContractState, token_id: u256) -> ByteArray {
            assert(self.erc721.exists(token_id), ERC721Component::Errors::INVALID_TOKEN_ID);
            let base_uri = self.erc721._base_uri();
            let uri = self.token_uris.read(token_id);
            format!("{}{}", base_uri, uri)
        }
    }
}
