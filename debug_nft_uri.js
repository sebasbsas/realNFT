#!/usr/bin/env node

/**
 * Script para verificar el token URI de un NFT minteado en Starknet
 * Uso: node debug_nft_uri.js <token_id>
 */

const { RpcProvider, Contract } = require("./packages/nextjs/node_modules/starknet");

// Configuración del contrato QuestlyNFT en mainnet
const CONTRACT_ADDRESS = "0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080";
const RPC_URL = "https://starknet-mainnet.public.blastapi.io/rpc/v0_9";

// ABI simplificado para las funciones que necesitamos
const CONTRACT_ABI = [
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
    "name": "owner_of",
    "inputs": [
      {
        "name": "token_id",
        "type": "u256"
      }
    ],
    "outputs": [
      {
        "name": "owner",
        "type": "ContractAddress"
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
  },
  {
    "type": "function",
    "name": "name",
    "inputs": [],
    "outputs": [
      {
        "name": "name",
        "type": "ByteArray"
      }
    ],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "symbol",
    "inputs": [],
    "outputs": [
      {
        "name": "symbol",
        "type": "ByteArray"
      }
    ],
    "stateMutability": "view"
  }
];

async function debugNFT(tokenId) {
  try {
    console.log("🔍 Debugging NFT Token URI...");
    console.log(`📋 Contract: ${CONTRACT_ADDRESS}`);
    console.log(`🆔 Token ID: ${tokenId}`);
    console.log(`🌐 RPC: ${RPC_URL}`);
    console.log("");

    // Inicializar provider
    const provider = new RpcProvider({ nodeUrl: RPC_URL });
    
    // Crear instancia del contrato
    const contract = new Contract(CONTRACT_ABI, CONTRACT_ADDRESS, provider);

    // Verificar información básica del contrato
    console.log("📊 Información del contrato:");
    try {
      const name = await contract.call("name");
      console.log(`   Nombre: ${name.name}`);
    } catch (e) {
      console.log(`   ❌ Error obteniendo nombre: ${e.message}`);
    }

    try {
      const symbol = await contract.call("symbol");
      console.log(`   Símbolo: ${symbol.symbol}`);
    } catch (e) {
      console.log(`   ❌ Error obteniendo símbolo: ${e.message}`);
    }

    try {
      const totalSupply = await contract.call("total_supply");
      console.log(`   Total Supply: ${totalSupply.supply}`);
    } catch (e) {
      console.log(`   ❌ Error obteniendo total supply: ${e.message}`);
    }

    console.log("");

    // Verificar si el token existe
    console.log("🔍 Verificando token:");
    try {
      const owner = await contract.call("owner_of", [tokenId]);
      console.log(`   ✅ Token existe`);
      console.log(`   👤 Owner: ${owner.owner}`);
    } catch (e) {
      console.log(`   ❌ Token no existe o error: ${e.message}`);
      return;
    }

    console.log("");

    // Obtener token URI
    console.log("🔗 Token URI:");
    try {
      const tokenUri = await contract.call("token_uri", [tokenId]);
      console.log(`   📝 URI: ${tokenUri.uri}`);
      
      if (!tokenUri.uri || tokenUri.uri === "") {
        console.log("   ⚠️  URI está vacía!");
      } else {
        console.log("   ✅ URI encontrada");
        
        // Intentar acceder al contenido de la URI
        console.log("");
        console.log("🌐 Verificando contenido de la URI:");
        try {
          let uri = tokenUri.uri;
          
          // Convertir ipfs:// a https://ipfs.io/ipfs/
          if (uri.startsWith("ipfs://")) {
            uri = uri.replace("ipfs://", "https://ipfs.io/ipfs/");
          }
          
          console.log(`   🔗 URI procesada: ${uri}`);
          
          const response = await fetch(uri);
          if (response.ok) {
            const metadata = await response.json();
            console.log("   ✅ Metadata obtenida:");
            console.log(JSON.stringify(metadata, null, 2));
          } else {
            console.log(`   ❌ Error HTTP ${response.status}: ${response.statusText}`);
          }
        } catch (e) {
          console.log(`   ❌ Error accediendo a la URI: ${e.message}`);
        }
      }
    } catch (e) {
      console.log(`   ❌ Error obteniendo token URI: ${e.message}`);
    }

  } catch (error) {
    console.error("❌ Error general:", error.message);
  }
}

// Obtener token ID del argumento de línea de comandos
const tokenId = process.argv[2];

if (!tokenId) {
  console.log("❌ Uso: node debug_nft_uri.js <token_id>");
  console.log("📋 Ejemplo: node debug_nft_uri.js 1");
  process.exit(1);
}

debugNFT(tokenId);
