const fs = require('fs');
const path = require('path');

// Test if the deployment files exist
const contractPath = '/home/user/oldsdk-demo-nft/packages/snfoundry/contracts/target/dev';
const contractFiles = [
  'contracts_YourCollectible.compiled_contract_class.json',
  'contracts_YourCollectible.contract_class.json'
];

console.log('Checking contract compilation files...');

contractFiles.forEach(file => {
  const fullPath = path.join(contractPath, file);
  if (fs.existsSync(fullPath)) {
    console.log(`✓ ${file} exists`);
  } else {
    console.log(`✗ ${file} missing`);
  }
});

// Check if .env file exists
const envPath = '/home/user/oldsdk-demo-nft/packages/snfoundry/.env';
if (fs.existsSync(envPath)) {
  console.log('✓ .env file exists');
} else {
  console.log('✗ .env file missing');
}

console.log('Deployment readiness check completed');

