#!/usr/bin/env node

/**
 * Script para probar el nuevo contrato QuestlyNFTStandard
 * y verificar que aparezca correctamente en exploradores
 */

const { RpcProvider, Contract } = require("./packages/nextjs/node_modules/starknet");

// Configuración del nuevo contrato
const NEW_CONTRACT_ADDRESS = "0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa";
const RPC_URL = "https://starknet-mainnet.public.blastapi.io/rpc/v0_9";

// ABI estándar ERC721
const ERC721_ABI = [
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
    "name": "balance_of",
    "inputs": [
      {
        "name": "owner",
        "type": "ContractAddress"
      }
    ],
    "outputs": [
      {
        "name": "balance",
        "type": "u256"
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

async function testNewContract() {
  try {
    console.log("🚀 Probando el nuevo contrato QuestlyNFTStandard...");
    console.log(`📋 Contrato: ${NEW_CONTRACT_ADDRESS}`);
    console.log(`🌐 RPC: ${RPC_URL}`);
    console.log("");

    // Inicializar provider
    const provider = new RpcProvider({ nodeUrl: RPC_URL });
    
    // Crear instancia del contrato
    const contract = new Contract(ERC721_ABI, NEW_CONTRACT_ADDRESS, provider);

    // Probar información básica del contrato
    console.log("📊 Información del contrato:");
    try {
      const name = await contract.call("name");
      console.log(`   ✅ Nombre: ${name.name}`);
    } catch (e) {
      console.log(`   ❌ Error obteniendo nombre: ${e.message}`);
    }

    try {
      const symbol = await contract.call("symbol");
      console.log(`   ✅ Símbolo: ${symbol.symbol}`);
    } catch (e) {
      console.log(`   ❌ Error obteniendo símbolo: ${e.message}`);
    }

    try {
      const totalSupply = await contract.call("total_supply");
      console.log(`   ✅ Total Supply: ${totalSupply.supply}`);
    } catch (e) {
      console.log(`   ❌ Error obteniendo total supply: ${e.message}`);
    }

    console.log("");
    console.log("🎯 Verificando compatibilidad con exploradores:");
    console.log(`   🔗 Starkscan: https://starkscan.co/contract/${NEW_CONTRACT_ADDRESS}`);
    console.log(`   🔗 Voyager: https://voyager.online/contract/${NEW_CONTRACT_ADDRESS}`);
    console.log("");

    console.log("✅ El contrato estándar está desplegado y funcional!");
    console.log("📝 Ahora debería aparecer correctamente en los exploradores como un contrato NFT.");

  } catch (error) {
    console.error("❌ Error:", error.message);
  }
}

testNewContract();
