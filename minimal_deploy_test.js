// Minimal deployment test
const { execSync } = require('child_process');
const path = require('path');

console.log('Starting minimal deployment test...');

try {
  // Change to the snfoundry directory
  process.chdir('/home/user/oldsdk-demo-nft/packages/snfoundry');
  
  // Try to run the deployment with explicit paths
  console.log('Attempting to run deployment...');
  
  const result = execSync('npx ts-node scripts-ts/deploy.ts --network devnet', {
    stdio: 'pipe',
    encoding: 'utf8',
    timeout: 30000
  });
  
  console.log('Deployment result:', result);
  
} catch (error) {
  console.error('Deployment failed:', error.message);
  console.error('Error details:', error.stderr || error.stdout);
}

