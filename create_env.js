const fs = require('fs');
const path = require('path');

const envContent = `# Devnet Configuration
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
`;

const envPath = path.join(__dirname, 'packages/snfoundry/.env');

try {
  fs.writeFileSync(envPath, envContent);
  console.log('✅ .env file created successfully at:', envPath);
} catch (error) {
  console.error('❌ Error creating .env file:', error.message);
}

