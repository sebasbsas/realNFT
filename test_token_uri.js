#!/usr/bin/env node

/**
 * Script para probar la función token_uri del contrato QuestlyNFT
 * usando el mismo setup que el frontend
 */

const { RpcProvider, Contract } = require("./packages/nextjs/node_modules/starknet");

// Configuración
const CONTRACT_ADDRESS = "0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080";
const RPC_URL = "https://starknet-mainnet.public.blastapi.io/rpc/v0_9";

// ABI simplificado del contrato QuestlyNFT
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
  }
];

async function testTokenURI() {
  try {
    console.log("🔍 Probando funciones del contrato QuestlyNFT...");
    console.log(`📋 Contract: ${CONTRACT_ADDRESS}`);
    console.log(`🌐 RPC: ${RPC_URL}`);
    console.log("");

    // Inicializar provider
    const provider = new RpcProvider({ nodeUrl: RPC_URL });
    
    // Crear instancia del contrato
    const contract = new Contract(CONTRACT_ABI, CONTRACT_ADDRESS, provider);

    // Probar total_supply primero
    console.log("📊 Probando total_supply...");
    try {
      const totalSupply = await contract.call("total_supply");
      console.log(`   ✅ Total Supply: ${totalSupply.supply}`);
    } catch (e) {
      console.log(`   ❌ Error en total_supply: ${e.message}`);
    }

    console.log("");

    // Probar owner_of para token 1
    console.log("👤 Probando owner_of para token 1...");
    try {
      const owner = await contract.call("owner_of", [1]);
      console.log(`   ✅ Owner del token 1: ${owner.owner}`);
    } catch (e) {
      console.log(`   ❌ Error en owner_of: ${e.message}`);
    }

    console.log("");

    // Probar token_uri para token 1
    console.log("🔗 Probando token_uri para token 1...");
    try {
      const tokenUri = await contract.call("token_uri", [1]);
      console.log(`   ✅ Token URI: ${tokenUri.uri}`);
      
      if (tokenUri.uri && tokenUri.uri !== "") {
        console.log("   🎉 ¡URI encontrada!");
        
        // Intentar acceder al contenido
        try {
          let uri = tokenUri.uri;
          if (uri.startsWith("ipfs://")) {
            uri = uri.replace("ipfs://", "https://ipfs.io/ipfs/");
          }
          
          console.log(`   🌐 Verificando: ${uri}`);
          const response = await fetch(uri);
          if (response.ok) {
            const metadata = await response.json();
            console.log("   ✅ Metadata accesible:");
            console.log(`   📝 Nombre: ${metadata.name}`);
            console.log(`   🖼️  Imagen: ${metadata.image}`);
          } else {
            console.log(`   ❌ Error HTTP: ${response.status}`);
          }
        } catch (e) {
          console.log(`   ❌ Error accediendo a URI: ${e.message}`);
        }
      } else {
        console.log("   ⚠️  URI vacía");
      }
    } catch (e) {
      console.log(`   ❌ Error en token_uri: ${e.message}`);
    }

  } catch (error) {
    console.error("❌ Error general:", error.message);
  }
}

testTokenURI();
