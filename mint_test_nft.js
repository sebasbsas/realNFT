#!/usr/bin/env node

/**
 * Script para mintear un NFT de prueba con el nuevo contrato estándar
 * y verificar que aparezca correctamente en exploradores
 */

const { RpcProvider, Contract, Account } = require("./packages/nextjs/node_modules/starknet");

// Configuración
const NEW_CONTRACT_ADDRESS = "0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa";
const RPC_URL = "https://starknet-mainnet.public.blastapi.io/rpc/v0_9";

// URI de prueba (usando la misma del NFT anterior)
const TEST_URI = "https://ipfs.io/ipfs/QmZdULHpCfuZAzoFo6YrS7mCLr8g9eBVPx2YNt3NRTXF9F/nft-01-balance-orb-basic.json";

// ABI del contrato (simplificado para mint_item)
const CONTRACT_ABI = [
  {
    "type": "function",
    "name": "mint_item",
    "inputs": [
      {
        "name": "recipient",
        "type": "ContractAddress"
      },
      {
        "name": "uri",
        "type": "ByteArray"
      }
    ],
    "outputs": [
      {
        "name": "token_id",
        "type": "u256"
      }
    ],
    "stateMutability": "external"
  },
  {
    "type": "function",
    "name": "token_uri",
    "inputs": [
      {
        "name": "token_id",
        "type": "u256"
      }
    ],
    "outputs": [
      {
        "name": "uri",
        "type": "ByteArray"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "total_supply",
    "inputs": [],
    "outputs": [
      {
        "name": "supply",
        "type": "u256"
      }
    ],
    "stateMutability": "view"
  }
];

async function mintTestNFT() {
  try {
    console.log("🎨 Minteando NFT de prueba con el nuevo contrato estándar...");
    console.log(`📋 Contrato: ${NEW_CONTRACT_ADDRESS}`);
    console.log(`🔗 URI: ${TEST_URI}`);
    console.log("");

    // Inicializar provider
    const provider = new RpcProvider({ nodeUrl: RPC_URL });
    
    // Crear instancia del contrato
    const contract = new Contract(CONTRACT_ABI, NEW_CONTRACT_ADDRESS, provider);

    // Verificar total supply antes del minteo
    console.log("📊 Estado antes del minteo:");
    try {
      const totalSupplyBefore = await contract.call("total_supply");
      console.log(`   ✅ Total Supply: ${totalSupplyBefore.supply}`);
    } catch (e) {
      console.log(`   ❌ Error obteniendo total supply: ${e.message}`);
    }

    console.log("");
    console.log("⚠️  NOTA: Este script solo muestra cómo sería el proceso.");
    console.log("   Para mintear realmente necesitas:");
    console.log("   1. Una wallet conectada con fondos STRK");
    console.log("   2. Usar el frontend en http://localhost:3000/mint");
    console.log("   3. Conectar tu wallet Braavos");
    console.log("   4. Ingresar una dirección de destinatario");
    console.log("   5. Ingresar una URI de IPFS");
    console.log("   6. Hacer clic en 'Mintear NFT'");
    console.log("");

    console.log("🎯 URLs importantes:");
    console.log(`   🖥️  Frontend: http://localhost:3000/mint`);
    console.log(`   🔍 Contrato: https://starkscan.co/contract/${NEW_CONTRACT_ADDRESS}`);
    console.log(`   📄 Metadata: ${TEST_URI}`);
    console.log("");

    console.log("✅ El nuevo contrato está listo para minteo!");
    console.log("📝 Ahora debería aparecer correctamente en exploradores como un contrato NFT estándar.");

  } catch (error) {
    console.error("❌ Error:", error.message);
  }
}

mintTestNFT();
