# 📱 Mintear NFT con IPFS desde React Native - QuestlyNFTStandard

## 🎯 Contrato Desplegado en Mainnet (ERC721 Estándar)

**Address:** `0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa`  
**Network:** Starknet Mainnet  
**Name:** Questly Platinums  
**Symbol:** QEST  
**Standard:** ERC721 completo con OpenZeppelin  
**Explorer:** https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa  
**Voyager:** https://voyager.online/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa

> **🔄 ACTUALIZACIÓN:** El contrato ha sido actualizado a estándar ERC721 completo para mejor compatibilidad con exploradores y wallets.

---

## ✅ **Respuesta a tu pregunta:**

### ❌ **¿Necesito la wallet del deployer?**
**NO.** Cualquier wallet puede mintear NFTs. El contrato no tiene restricciones de `onlyOwner`.

---

## 📦 Instalación

```bash
npm install starknet get-starknet-core
# o
yarn add starknet get-starknet-core
```

---

## 🔧 ABI del Contrato

```typescript
// questlyNFTAbi.ts
export const QUESTLY_NFT_ABI = [
  {
    type: "function",
    name: "mint_item",
    inputs: [
      { 
        name: "recipient", 
        type: "core::starknet::contract_address::ContractAddress" 
      },
      {
        name: "uri",
        type: "core::byte_array::ByteArray"
      }
    ],
    outputs: [{ type: "core::integer::u256" }],
    state_mutability: "external",
  },
  {
    type: "function",
    name: "token_uri",
    inputs: [{ name: "token_id", type: "core::integer::u256" }],
    outputs: [{ type: "core::byte_array::ByteArray" }],
    state_mutability: "view",
  },
  {
    type: "function",
    name: "owner_of",
    inputs: [{ name: "token_id", type: "core::integer::u256" }],
    outputs: [{ type: "core::starknet::contract_address::ContractAddress" }],
    state_mutability: "view",
  },
  {
    type: "function",
    name: "balance_of",
    inputs: [{ 
      name: "owner", 
      type: "core::starknet::contract_address::ContractAddress" 
    }],
    outputs: [{ type: "core::integer::u256" }],
    state_mutability: "view",
  },
  {
    type: "function",
    name: "name",
    inputs: [],
    outputs: [{ type: "core::byte_array::ByteArray" }],
    state_mutability: "view",
  },
  {
    type: "function",
    name: "symbol",
    inputs: [],
    outputs: [{ type: "core::byte_array::ByteArray" }],
    state_mutability: "view",
  },
  {
    type: "function",
    name: "total_supply",
    inputs: [],
    outputs: [{ type: "core::integer::u256" }],
    state_mutability: "view",
  },
] as const;

export const NFT_CONTRACT_ADDRESS = '0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa';
export const RPC_URL = 'https://starknet-mainnet.blastapi.io/64168c77-3fa5-4e1e-9fe4-41675d212522/rpc/v0_9';
```

---

## 🎨 Componente React Native

```typescript
// MintQuestlyNFT.tsx
import React, { useState } from 'react';
import { View, Button, Text, Alert, StyleSheet, TextInput } from 'react-native';
import { connect } from 'get-starknet-core';
import { Contract } from 'starknet';
import { QUESTLY_NFT_ABI, NFT_CONTRACT_ADDRESS } from './questlyNFTAbi';

export default function MintQuestlyNFT() {
  const [account, setAccount] = useState<any>(null);
  const [loading, setLoading] = useState(false);
  const [ipfsUri, setIpfsUri] = useState(
    'ipfs://QmZdULHpCfuZAzoFo6YrS7mCLr8g9eBVPx2YNt3NRTXF9F/nft-01-balance-orb-basic.json'
  );
  const [lastTokenId, setLastTokenId] = useState<string | null>(null);

  // 1. Conectar Wallet
  const connectWallet = async () => {
    try {
      const starknet = await connect({ 
        modalMode: 'alwaysAsk',
        modalTheme: 'dark'
      });

      if (!starknet) {
        Alert.alert('❌ Error', 'No se pudo conectar la wallet');
        return;
      }

      await starknet.enable();
      
      if (starknet.isConnected && starknet.account) {
        setAccount(starknet.account);
        Alert.alert(
          '✅ Conectado', 
          `Address: ${starknet.account.address.slice(0, 10)}...${starknet.account.address.slice(-6)}`
        );
      }
    } catch (error) {
      console.error('Error connecting wallet:', error);
      Alert.alert('❌ Error', 'No se pudo conectar la wallet');
    }
  };

  // 2. 🔥 MINTEAR CON IPFS URI
  const mintNFT = async () => {
    if (!account) {
      Alert.alert('⚠️ Error', 'Primero conecta tu wallet');
      return;
    }

    if (!ipfsUri.startsWith('ipfs://')) {
      Alert.alert('⚠️ Error', 'El URI debe comenzar con ipfs://');
      return;
    }

    setLoading(true);

    try {
      // Crear instancia del contrato
      const contract = new Contract(
        QUESTLY_NFT_ABI,
        NFT_CONTRACT_ADDRESS,
        account
      );

      console.log('🎨 Minteando NFT con metadata IPFS...');
      console.log('📍 Contract:', NFT_CONTRACT_ADDRESS);
      console.log('👤 Destinatario:', account.address);
      console.log('📄 URI:', ipfsUri);

      // 🔥 Llamar mint_item con recipient y URI
      const call = await contract.mint_item(
        account.address,
        ipfsUri
      );
      
      console.log('⏳ Tx Hash:', call.transaction_hash);
      console.log('⏳ Esperando confirmación...');
      
      const receipt = await account.waitForTransaction(call.transaction_hash);
      
      console.log('✅ NFT Minteado con metadata!');
      
      // Extraer token_id del evento Mint
      // El evento Mint emite: (to, token_id, uri)
      const tokenId = receipt.events?.find((e: any) => 
        e.keys?.[0]?.includes('Mint')
      )?.data?.[1] || 'Unknown';

      setLastTokenId(tokenId);

      Alert.alert(
        '🎉 NFT Minteado!',
        `✅ Token ID: ${tokenId}\n\n📄 Metadata: ${ipfsUri.slice(0, 50)}...\n\n🔗 Tx: ${call.transaction_hash.slice(0, 20)}...`,
        [
          {
            text: '🔍 Ver en Explorer',
            onPress: () => {
              console.log(`https://starkscan.co/tx/${call.transaction_hash}`);
            }
          },
          {
            text: '📄 Ver Metadata',
            onPress: () => viewMetadata(tokenId)
          },
          { text: 'OK' }
        ]
      );
    } catch (error: any) {
      console.error('Error minting NFT:', error);
      Alert.alert(
        '❌ Error', 
        error.message || 'No se pudo mintear el NFT'
      );
    } finally {
      setLoading(false);
    }
  };

  // 3. Ver metadata de un token
  const viewMetadata = async (tokenId: string) => {
    if (!account) return;

    try {
      const { Provider } = await import('starknet');
      const provider = new Provider({ 
        nodeUrl: 'https://starknet-mainnet.blastapi.io/64168c77-3fa5-4e1e-9fe4-41675d212522/rpc/v0_9'
      });
      
      const contract = new Contract(
        QUESTLY_NFT_ABI,
        NFT_CONTRACT_ADDRESS,
        provider
      );

      console.log('🔍 Obteniendo URI del token:', tokenId);
      const uri = await contract.token_uri(tokenId);
      
      console.log('📄 URI:', uri);
      Alert.alert('📄 Token URI', `Token #${tokenId}\n\n${uri}`);
      
      // Opcional: Cargar el JSON de IPFS
      if (uri.toString().startsWith('ipfs://')) {
        const ipfsHash = uri.toString().replace('ipfs://', '');
        const httpUrl = `https://ipfs.io/ipfs/${ipfsHash}`;
        
        console.log('🌐 Cargando metadata de:', httpUrl);
        
        const response = await fetch(httpUrl);
        const metadata = await response.json();
        
        console.log('🎨 Metadata JSON:', metadata);
        
        Alert.alert(
          '🎨 NFT Metadata',
          `Name: ${metadata.name}\n\nDescription: ${metadata.description}\n\nImage: ${metadata.image?.slice(0, 50)}...`
        );
      }
    } catch (error: any) {
      console.error('Error viewing metadata:', error);
      Alert.alert('❌ Error', 'No se pudo obtener la metadata');
    }
  };

  // 4. Ver tu balance
  const checkBalance = async () => {
    if (!account) {
      Alert.alert('⚠️ Error', 'Primero conecta tu wallet');
      return;
    }

    try {
      const { Provider } = await import('starknet');
      const provider = new Provider({ 
        nodeUrl: 'https://starknet-mainnet.blastapi.io/64168c77-3fa5-4e1e-9fe4-41675d212522/rpc/v0_9'
      });
      
      const contract = new Contract(
        QUESTLY_NFT_ABI,
        NFT_CONTRACT_ADDRESS,
        provider
      );

      const balance = await contract.balance_of(account.address);
      
      Alert.alert(
        '💰 Tu Balance',
        `Tienes ${balance.toString()} NFTs\n\nde Questly Platinums (QEST)`
      );
    } catch (error: any) {
      console.error('Error checking balance:', error);
      Alert.alert('❌ Error', 'No se pudo obtener el balance');
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>🎨 Questly Platinums NFT</Text>
      <Text style={styles.subtitle}>Mintea con metadata IPFS</Text>

      {!account ? (
        <Button title="🔗 Conectar Wallet" onPress={connectWallet} />
      ) : (
        <>
          <Text style={styles.address}>
            ✅ Conectado: {account.address.slice(0, 6)}...{account.address.slice(-4)}
          </Text>
          
          <Text style={styles.label}>📄 IPFS URI:</Text>
          <TextInput
            style={styles.input}
            value={ipfsUri}
            onChangeText={setIpfsUri}
            placeholder="ipfs://QmXxXxXx.../metadata.json"
            multiline
            numberOfLines={3}
          />
          
          <View style={styles.buttonContainer}>
            <Button 
              title={loading ? "⏳ Minteando..." : "🎨 Mintear NFT"} 
              onPress={mintNFT}
              disabled={loading}
              color="#4CAF50"
            />
          </View>

          <View style={styles.buttonContainer}>
            <Button 
              title="💰 Ver mi Balance" 
              onPress={checkBalance}
              color="#2196F3"
            />
          </View>

          {lastTokenId && (
            <>
              <Text style={styles.successText}>
                ✅ Último Token ID minteado: {lastTokenId}
              </Text>
              <View style={styles.buttonContainer}>
                <Button 
                  title="📄 Ver Metadata" 
                  onPress={() => viewMetadata(lastTokenId)}
                  color="#FF9800"
                />
              </View>
            </>
          )}

          <View style={styles.infoBox}>
            <Text style={styles.infoTitle}>ℹ️ Información</Text>
            <Text style={styles.infoText}>
              • Cualquier wallet puede mintear{'\n'}
              • El URI se guarda en la blockchain{'\n'}
              • Gas: ~0.01-0.02 STRK{'\n'}
              • Los NFTs son permanentes
            </Text>
          </View>
        </>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    marginBottom: 5,
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    marginBottom: 20,
    textAlign: 'center',
  },
  address: {
    marginBottom: 15,
    padding: 10,
    backgroundColor: '#e8f5e9',
    borderRadius: 8,
    color: '#2e7d32',
    fontWeight: 'bold',
  },
  label: {
    marginTop: 10,
    marginBottom: 5,
    fontWeight: 'bold',
    fontSize: 16,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 8,
    padding: 12,
    marginBottom: 15,
    backgroundColor: '#fff',
    fontSize: 14,
  },
  buttonContainer: {
    marginBottom: 10,
  },
  successText: {
    marginTop: 15,
    padding: 10,
    backgroundColor: '#e8f5e9',
    borderRadius: 8,
    color: '#2e7d32',
    fontWeight: 'bold',
    textAlign: 'center',
  },
  infoBox: {
    marginTop: 20,
    padding: 15,
    backgroundColor: '#e3f2fd',
    borderRadius: 8,
  },
  infoTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 8,
    color: '#1976d2',
  },
  infoText: {
    fontSize: 14,
    color: '#424242',
    lineHeight: 20,
  },
});
```

---

## 🚀 **Ejemplo Simplificado (Sin UI):**

```typescript
import { Contract, Account, RpcProvider } from 'starknet';
import { QUESTLY_NFT_ABI, NFT_CONTRACT_ADDRESS } from './questlyNFTAbi';

async function mintWithIPFS(
  accountAddress: string,
  accountPrivateKey: string,
  ipfsUri: string
) {
  // Setup
  const provider = new RpcProvider({
    nodeUrl: 'https://starknet-mainnet.blastapi.io/64168c77-3fa5-4e1e-9fe4-41675d212522/rpc/v0_9'
  });

  const account = new Account(provider, accountAddress, accountPrivateKey);
  
  const contract = new Contract(
    QUESTLY_NFT_ABI,
    NFT_CONTRACT_ADDRESS,
    account
  );

  // 🔥 Mintear con URI
  console.log('🎨 Minteando NFT...');
  const tx = await contract.mint_item(
    accountAddress,
    ipfsUri
  );
  
  console.log('⏳ Tx:', tx.transaction_hash);
  const receipt = await provider.waitForTransaction(tx.transaction_hash);
  
  const tokenId = receipt.events[0].data[1];
  console.log('✅ Token ID:', tokenId);
  
  return { tokenId, txHash: tx.transaction_hash };
}

// 🎯 USO CON TU IPFS:
const result = await mintWithIPFS(
  '0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565', // Tu wallet
  'tu_private_key',
  'ipfs://QmZdULHpCfuZAzoFo6YrS7mCLr8g9eBVPx2YNt3NRTXF9F/nft-01-balance-orb-basic.json'
);

console.log('🎉 NFT Minteado! Token ID:', result.tokenId);
```

---

## 📊 **Funciones Disponibles:**

| Función | Parámetros | Retorna | Descripción |
|---------|-----------|---------|-------------|
| `mint_item` | `recipient, uri` | `u256` | Mintea NFT con metadata IPFS |
| `token_uri` | `token_id` | `ByteArray` | Obtiene URI del token |
| `owner_of` | `token_id` | `address` | Dueño del token |
| `balance_of` | `owner` | `u256` | Balance de NFTs |
| `name` | - | `"Questly Platinums"` | Nombre |
| `symbol` | - | `"QEST"` | Símbolo |
| `total_supply` | - | `u256` | Total minteados |

---

## 🎯 **Tu IPFS URI:**

```
ipfs://QmZdULHpCfuZAzoFo6YrS7mCLr8g9eBVPx2YNt3NRTXF9F/nft-01-balance-orb-basic.json
```

**Para acceder vía HTTP:**
```
https://ipfs.io/ipfs/QmZdULHpCfuZAzoFo6YrS7mCLr8g9eBVPx2YNt3NRTXF9F/nft-01-balance-orb-basic.json
```

---

## 💡 **Tips Importantes:**

1. ✅ **No necesitas la wallet del deployer**
2. 💰 **Verifica que tengas STRK** (~0.01-0.02 por mint)
3. 🔐 **Nunca compartas tu private key**
4. 📱 **Usa Braavos Mobile o Argent Mobile**
5. 🎨 **El URI se guarda permanentemente en blockchain**
6. 🔍 **Puedes verificar en:** https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa

---

## 🔗 **Links útiles:**

- 📄 **Contrato:** https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
- 📄 **Voyager:** https://voyager.online/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
- 📖 **Starknet.js Docs:** https://www.starknetjs.com/
- 💼 **Get Starknet:** https://github.com/starknet-io/get-starknet

---

## ✅ **Resumen:**

- ✅ Contrato desplegado en mainnet
- ✅ Soporta URIs IPFS individuales por token
- ✅ Cualquier wallet puede mintear
- ✅ Metadata permanente en blockchain
- ✅ Compatible con React Native
- ✅ Gas eficiente (~0.01 STRK)

¡Listo para mintear! 🚀

