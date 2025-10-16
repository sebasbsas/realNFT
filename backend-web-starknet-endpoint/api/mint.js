// API para mintear NFTs en Starknet Mainnet
// Desplegado en Vercel como serverless function

const { Account, Contract, RpcProvider, constants, CallData } = require('starknet');

// ABI del contrato QuestlyNFT (método mint simple)
const MINIMAL_NFT_ABI = [
  {
    "type": "function",
    "name": "mint",
    "inputs": [
      {
        "name": "to",
        "type": "core::starknet::contract_address::ContractAddress"
      }
    ],
    "outputs": [
      {
        "type": "core::integer::u256"
      }
    ],
    "state_mutability": "external"
  }
];

// Configuración del contrato MinimalNFT
const CONTRACT_ADDRESS = '0x0755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88';
const RPC_URL = 'https://starknet-mainnet.public.blastapi.io/rpc/v0_8';

// Handler principal para Vercel
module.exports = async (req, res) => {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  // Handle OPTIONS request
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  // Solo aceptar POST
  if (req.method !== 'POST') {
    return res.status(405).json({ 
      success: false, 
      error: 'Method not allowed. Use POST.' 
    });
  }

  try {
    const { userAddress, nftData } = req.body;

    // Validar datos
    if (!userAddress) {
      return res.status(400).json({
        success: false,
        error: 'userAddress es requerido'
      });
    }

    // Validar formato de dirección
    if (!userAddress.match(/^0x[0-9a-f]{1,64}$/i)) {
      return res.status(400).json({
        success: false,
        error: 'Formato de dirección inválido'
      });
    }

    console.log('🎨 Iniciando mint para:', userAddress);

    // Obtener credenciales del backend desde variables de entorno
    const BACKEND_WALLET_ADDRESS = process.env.BACKEND_WALLET_ADDRESS;
    const BACKEND_PRIVATE_KEY = process.env.BACKEND_PRIVATE_KEY;

    if (!BACKEND_WALLET_ADDRESS || !BACKEND_PRIVATE_KEY) {
      console.error('❌ Variables de entorno no configuradas');
      return res.status(500).json({
        success: false,
        error: 'Backend no configurado correctamente'
      });
    }

    // Crear provider
    const provider = new RpcProvider({
      nodeUrl: RPC_URL
    });

    // Crear cuenta del backend
    console.log('💳 Conectando wallet del backend...');
    const backendAccount = new Account(
      provider,
      BACKEND_WALLET_ADDRESS,
      BACKEND_PRIVATE_KEY,
      undefined,
      constants.TRANSACTION_VERSION.V3
    );

    // Crear instancia del contrato
    console.log('📜 Conectando al contrato...');
    const contract = new Contract(
      MINIMAL_NFT_ABI,
      CONTRACT_ADDRESS,
      backendAccount
    );

    // Mintear NFT usando mint (método simple)
    console.log('⏳ Minteando NFT...');
    
    console.log('📋 Parámetros:', { userAddress });
    
    // Usar método mint simple (solo necesita la dirección del destinatario)
    const mintCall = await contract.mint(userAddress);

    console.log('📝 Transaction hash:', mintCall.transaction_hash);

    // Esperar confirmación (opcional, puede tomar tiempo)
    console.log('⏳ Esperando confirmación...');
    const receipt = await provider.waitForTransaction(mintCall.transaction_hash);

    console.log('✅ NFT minteado exitosamente!');

    // Extraer token ID del evento (si está disponible)
    let tokenId = null;
    if (receipt.events && receipt.events.length > 0) {
      // El evento Mint emite (to, token_id)
      tokenId = receipt.events[0].data[1];
    }

    // Retornar resultado exitoso
    return res.status(200).json({
      success: true,
      transactionHash: mintCall.transaction_hash,
      tokenId: tokenId,
      explorerUrl: `https://voyager.online/tx/${mintCall.transaction_hash}`,
      message: 'NFT minteado exitosamente en Starknet Mainnet'
    });

  } catch (error) {
    console.error('❌ Error minteando NFT:', error);

    // Retornar error detallado
    return res.status(500).json({
      success: false,
      error: error.message || 'Error desconocido al mintear NFT',
      details: process.env.NODE_ENV === 'development' ? error.stack : undefined
    });
  }
};

