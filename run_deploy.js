const { spawn } = require('child_process');
const path = require('path');

console.log('🚀 Iniciando deployment de contratos Cairo...');

// Cambiar al directorio correcto
process.chdir('/home/user/oldsdk-demo-nft/packages/snfoundry');

// Ejecutar el deployment
const deployProcess = spawn('yarn', ['deploy', '--network', 'devnet'], {
  stdio: 'inherit',
  shell: true,
  env: { ...process.env }
});

deployProcess.on('close', (code) => {
  if (code === 0) {
    console.log('✅ Deployment completado exitosamente!');
  } else {
    console.log(`❌ Deployment falló con código: ${code}`);
  }
});

deployProcess.on('error', (error) => {
  console.error('❌ Error ejecutando deployment:', error.message);
});

