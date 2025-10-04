#!/bin/bash
cd /home/user/oldsdk-demo-nft/packages/snfoundry

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cat > .env << EOF
# Devnet Configuration
PRIVATE_KEY_DEVNET=0x71d7bb07b9a64f6f78ac4c816aff4da9
RPC_URL_DEVNET=http://127.0.0.1:5050
ACCOUNT_ADDRESS_DEVNET=0x64b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691

# Sepolia Configuration (uncomment and fill when needed)
# PRIVATE_KEY_SEPOLIA=your_sepolia_private_key
# RPC_URL_SEPOLIA=your_sepolia_rpc_url
# ACCOUNT_ADDRESS_SEPOLIA=your_sepolia_account_address

# Mainnet Configuration (uncomment and fill when needed)
# PRIVATE_KEY_MAINNET=your_mainnet_private_key
# RPC_URL_MAINNET=your_mainnet_rpc_url
# ACCOUNT_ADDRESS_MAINNET=your_mainnet_account_address
EOF
    echo ".env file created successfully"
else
    echo ".env file already exists"
fi

echo "Environment setup completed"

