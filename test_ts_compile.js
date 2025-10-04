const { execSync } = require('child_process');
const path = require('path');

console.log('Testing TypeScript compilation...');

try {
  // Change to the snfoundry directory
  process.chdir('/home/user/oldsdk-demo-nft/packages/snfoundry');
  
  console.log('Compiling TypeScript...');
  
  const result = execSync('npx tsc --noEmit scripts-ts/deploy-contract.ts', {
    stdio: 'pipe',
    encoding: 'utf8',
    timeout: 30000
  });
  
  console.log('✅ TypeScript compilation successful!');
  console.log('Output:', result);
  
} catch (error) {
  console.error('❌ TypeScript compilation failed:');
  console.error('Error:', error.message);
  if (error.stdout) {
    console.log('STDOUT:', error.stdout);
  }
  if (error.stderr) {
    console.log('STDERR:', error.stderr);
  }
}

