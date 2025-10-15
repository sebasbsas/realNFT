# 📱 Mintear NFT desde React Native - MinimalNFT (⚠️ SIN SOPORTE IPFS)

## ⚠️ **IMPORTANTE: Este contrato NO soporta metadata IPFS**

Si necesitas **guardar URIs IPFS** para cada NFT, usa **`QuestlyNFT`** en su lugar.  
📄 Ver: `REACT_NATIVE_QUESTLY_NFT.md`

---

## 🎯 Contrato Desplegado

**Address:** `0x755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88`  
**Network:** Starknet Mainnet  
**Chain ID:** `0x534e5f4d41494e`  
**Name:** Questly Platinums  
**Symbol:** QEST  
**IPFS Support:** ❌ **NO** - No guarda URIs individuales

**Explorer:** https://starkscan.co/contract/0x755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88

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
// minimalNFTAbi.ts
export const MINIMAL_NFT_ABI = [
  {
    type: "function",
    name: "mint",
    inputs: [
      { 
        name: "to", 
        type: "core::starknet::contract_address::ContractAddress" 
      }
    ],
    outputs: [{ type: "core::integer::u256" }],
    state_mutability: "external",
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

export const MINIMAL_NFT_ADDRESS = '0x755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88';
export const RPC_URL = 'https://starknet-mainnet.blastapi.io/64168c77-3fa5-4e1e-9fe4-41675d212522/rpc/v0_9';
```

---

## 🎨 Componente React Native

```typescript
// MintMinimalNFT.tsx
import React, { useState } from 'react';
import { View, Button, Text, Alert, StyleSheet } from 'react-native';
import { connect } from 'get-starknet-core';
import { Contract } from 'starknet';
import { MINIMAL_NFT_ABI, MINIMAL_NFT_ADDRESS } from './minimalNFTAbi';

export default function MintMinimalNFT() {
  const [account, setAccount] = useState<any>(null);
  const [loading, setLoading] = useState(false);
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

  // 2. 🔥 MINTEAR (SIN URI - básico)
  const mintNFT = async () => {
    if (!account) {
      Alert.alert('⚠️ Error', 'Primero conecta tu wallet');
      return;
    }

    setLoading(true);

    try {
      // Crear instancia del contrato
      const contract = new Contract(
        MINIMAL_NFT_ABI,
        MINIMAL_NFT_ADDRESS,
        account
      );

      console.log('🎨 Minteando NFT básico (sin metadata)...');
      console.log('📍 Contract:', MINIMAL_NFT_ADDRESS);
      console.log('👤 Destinatario:', account.address);

      // 🔥 Llamar mint solo con destinatario (NO tiene URI)
      const call = await contract.mint(account.address);
      
      console.log('⏳ Tx Hash:', call.transaction_hash);
      console.log('⏳ Esperando confirmación...');
      
      const receipt = await account.waitForTransaction(call.transaction_hash);
      
      console.log('✅ NFT Minteado!');
      
      // Extraer token_id del evento Mint
      const tokenId = receipt.events?.find((e: any) => 
        e.keys?.[0]?.includes('Mint')
      )?.data?.[1] || 'Unknown';

      setLastTokenId(tokenId);

      Alert.alert(
        '🎉 NFT Minteado!',
        `✅ Token ID: ${tokenId}\n\n⚠️ Este NFT NO tiene metadata IPFS\n\n🔗 Tx: ${call.transaction_hash.slice(0, 20)}...`,
        [
          {
            text: '🔍 Ver en Explorer',
            onPress: () => {
              console.log(`https://starkscan.co/tx/${call.transaction_hash}`);
            }
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

  // 3. Ver tu balance
  const checkBalance = async () => {
    if (!account) {
      Alert.alert('⚠️ Error', 'Primero conecta tu wallet');
      return;
    }

    try {
      const { Provider } = await import('starknet');
      const provider = new Provider({ 
        nodeUrl: RPC_URL
      });
      
      const contract = new Contract(
        MINIMAL_NFT_ABI,
        MINIMAL_NFT_ADDRESS,
        provider
      );

      const balance = await contract.balance_of(account.address);
      
      Alert.alert(
        '💰 Tu Balance',
        `Tienes ${balance.toString()} NFTs\n\nde Questly Platinums (QEST)\n\n⚠️ Sin metadata IPFS`
      );
    } catch (error: any) {
      console.error('Error checking balance:', error);
      Alert.alert('❌ Error', 'No se pudo obtener el balance');
    }
  };

  // 4. Ver dueño de un token
  const checkOwner = async (tokenId: string) => {
    if (!tokenId) return;

    try {
      const { Provider } = await import('starknet');
      const provider = new Provider({ 
        nodeUrl: RPC_URL
      });
      
      const contract = new Contract(
        MINIMAL_NFT_ABI,
        MINIMAL_NFT_ADDRESS,
        provider
      );

      const owner = await contract.owner_of(tokenId);
      
      Alert.alert(
        '👤 Dueño del Token',
        `Token #${tokenId}\n\nOwner: ${owner.toString()}`
      );
    } catch (error: any) {
      console.error('Error checking owner:', error);
      Alert.alert('❌ Error', 'No se pudo obtener el dueño');
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>🎨 Minimal NFT</Text>
      <Text style={styles.subtitle}>⚠️ SIN soporte metadata IPFS</Text>
      
      <View style={styles.warningBox}>
        <Text style={styles.warningTitle}>⚠️ Limitaciones</Text>
        <Text style={styles.warningText}>
          Este contrato NO guarda URIs IPFS.{'\n'}
          Si necesitas metadata, usa QuestlyNFT.
        </Text>
      </View>

      {!account ? (
        <Button title="🔗 Conectar Wallet" onPress={connectWallet} />
      ) : (
        <>
          <Text style={styles.address}>
            ✅ Conectado: {account.address.slice(0, 6)}...{account.address.slice(-4)}
          </Text>
          
          <View style={styles.buttonContainer}>
            <Button 
              title={loading ? "⏳ Minteando..." : "🎨 Mintear NFT Básico"} 
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
                  title="👤 Ver Dueño" 
                  onPress={() => checkOwner(lastTokenId)}
                  color="#FF9800"
                />
              </View>
            </>
          )}

          <View style={styles.infoBox}>
            <Text style={styles.infoTitle}>ℹ️ Información</Text>
            <Text style={styles.infoText}>
              • Cualquier wallet puede mintear{'\n'}
              • Gas: ~0.01 STRK{'\n'}
              • Los NFTs son permanentes{'\n'}
              • ⚠️ NO guarda metadata IPFS{'\n'}
              • Para IPFS usa QuestlyNFT
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
    color: '#e65100',
    marginBottom: 20,
    textAlign: 'center',
    fontWeight: 'bold',
  },
  address: {
    marginBottom: 15,
    padding: 10,
    backgroundColor: '#e8f5e9',
    borderRadius: 8,
    color: '#2e7d32',
    fontWeight: 'bold',
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
  warningBox: {
    marginBottom: 20,
    padding: 15,
    backgroundColor: '#fff3e0',
    borderRadius: 8,
    borderWidth: 2,
    borderColor: '#ff9800',
  },
  warningTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 8,
    color: '#e65100',
  },
  warningText: {
    fontSize: 14,
    color: '#e65100',
    lineHeight: 20,
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
import { MINIMAL_NFT_ABI, MINIMAL_NFT_ADDRESS } from './minimalNFTAbi';

async function mintBasicNFT(
  accountAddress: string,
  accountPrivateKey: string
) {
  // Setup
  const provider = new RpcProvider({
    nodeUrl: 'https://starknet-mainnet.blastapi.io/64168c77-3fa5-4e1e-9fe4-41675d212522/rpc/v0_9'
  });

  const account = new Account(provider, accountAddress, accountPrivateKey);
  
  const contract = new Contract(
    MINIMAL_NFT_ABI,
    MINIMAL_NFT_ADDRESS,
    account
  );

  // 🔥 Mintear (solo destinatario, NO hay URI)
  console.log('🎨 Minteando NFT básico...');
  const tx = await contract.mint(accountAddress);
  
  console.log('⏳ Tx:', tx.transaction_hash);
  const receipt = await provider.waitForTransaction(tx.transaction_hash);
  
  const tokenId = receipt.events[0].data[1];
  console.log('✅ Token ID:', tokenId);
  
  return { tokenId, txHash: tx.transaction_hash };
}

// 🎯 USO:
const result = await mintBasicNFT(
  '0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565',
  'tu_private_key'
);

console.log('🎉 NFT Minteado! Token ID:', result.tokenId);
```

---

## 📊 **Funciones Disponibles:**

| Función | Parámetros | Retorna | Descripción |
|---------|-----------|---------|-------------|
| `mint` | `to` | `u256` | Mintea NFT básico (sin URI) |
| `owner_of` | `token_id` | `address` | Dueño del token |
| `balance_of` | `owner` | `u256` | Balance de NFTs |
| `name` | - | `"Questly Platinums"` | Nombre |
| `symbol` | - | `"QEST"` | Símbolo |
| `total_supply` | - | `u256` | Total minteados |

---

## ⚠️ **Comparación: Minimal vs Questly**

| Característica | MinimalNFT (Este) | QuestlyNFT |
|----------------|-------------------|------------|
| **IPFS Support** | ❌ NO | ✅ SÍ |
| **Mint Function** | `mint(to)` | `mint_item(to, uri)` |
| **Token URI** | ❌ No almacena | ✅ Almacena por token |
| **Gas Cost** | ~0.01 STRK | ~0.01-0.02 STRK |
| **Use Case** | NFTs simples sin metadata | NFTs con metadata IPFS |
| **Address** | `0x7556402...` | `0x2cf4e33...` |

---

## 💡 **¿Cuándo usar MinimalNFT?**

✅ **Usar MinimalNFT si:**
- Solo necesitas propiedad/transferencia básica
- No necesitas metadata individual
- Quieres el gas más bajo posible
- Es solo para pruebas/demo

❌ **NO usar MinimalNFT si:**
- Necesitas guardar metadata IPFS
- Quieres imagen/descripción por NFT
- Construyes una colección real

👉 **Para metadata IPFS, usa:** `QuestlyNFT`  
📄 Ver: `REACT_NATIVE_QUESTLY_NFT.md`

---

## 🔗 **Links útiles:**

- 📄 **Contrato:** https://starkscan.co/contract/0x755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88
- 🎨 **QuestlyNFT (CON IPFS):** Ver `REACT_NATIVE_QUESTLY_NFT.md`
- 📖 **Starknet.js Docs:** https://www.starknetjs.com/
- 💼 **Get Starknet:** https://github.com/starknet-io/get-starknet

---

## ✅ **Resumen:**

- ✅ Contrato desplegado en mainnet
- ❌ **NO soporta URIs IPFS**
- ✅ Funcionalidad básica de minting
- ✅ Cualquier wallet puede mintear
- ✅ Gas eficiente (~0.01 STRK)
- ⚠️ Solo para casos de uso simples

**Para IPFS metadata → Usa `QuestlyNFT`** 🚀

