const { execSync } = require('child_process');
const path = require('path');

console.log('Testing deployment fix...');

try {
  // Change to the snfoundry directory
  process.chdir('/home/user/oldsdk-demo-nft/packages/snfoundry');
  
  console.log('Running deployment...');
  
  const result = execSync('yarn deploy --network devnet', {
    stdio: 'inherit',
    encoding: 'utf8',
    timeout: 60000
  });
  
  console.log('Deployment completed successfully!');
  
} catch (error) {
  console.error('Deployment failed:', error.message);
  if (error.stdout) {
    console.log('STDOUT:', error.stdout);
  }
  if (error.stderr) {
    console.log('STDERR:', error.stderr);
  }
}

