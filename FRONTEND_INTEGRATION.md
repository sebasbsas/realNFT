# 🎨 Frontend Integration - YourCollectible NFT

> Guía completa para interactuar con el contrato YourCollectible desde el frontend

---

## 📦 Sobre el Contrato

**Nombre:** `YourCollectible`  
**Type:** ERC721 NFT (usando OpenZeppelin components)  
**Address:** `0x1ddbf6eb3a5217e1b42cc2fd90ef6e50bd35bd333b49764b0207b5de298a31a`

### 🎯 Características del Contrato:

- ✅ **ERC721** - NFTs estándar
- ✅ **Enumerable** - Listar todos los NFTs
- ✅ **Ownable** - Solo el owner puede mintear
- ✅ **URI Storage** - Cada NFT tiene su metadata URI
- ✅ **Counter** - Token IDs auto-incrementales

---

## 📝 Funciones Disponibles

### 🎨 Funciones de Escritura (requieren firma)

#### 1. `mint_item` - Mintear un nuevo NFT

```cairo
fn mint_item(ref self: T, recipient: ContractAddress, uri: ByteArray) -> u256;
```

**Parámetros:**
- `recipient`: Dirección que recibirá el NFT
- `uri`: URI del metadata del NFT (ej: "QmHash.../metadata.json")

**Retorna:** El ID del token minteado

---

#### 2. `transfer_from` - Transferir un NFT

```cairo
fn transfer_from(from: ContractAddress, to: ContractAddress, token_id: u256);
```

**Parámetros:**
- `from`: Dirección actual del owner
- `to`: Dirección del nuevo owner
- `token_id`: ID del token a transferir

---

#### 3. `approve` - Aprobar a otra dirección para usar tu NFT

```cairo
fn approve(to: ContractAddress, token_id: u256);
```

---

### 👀 Funciones de Lectura (solo consulta)

#### 1. `balance_of` - Ver cuántos NFTs tiene una dirección

```cairo
fn balance_of(account: ContractAddress) -> u256;
```

#### 2. `owner_of` - Ver quién es dueño de un NFT

```cairo
fn owner_of(token_id: u256) -> ContractAddress;
```

#### 3. `token_uri` - Obtener la URI de metadata de un NFT

```cairo
fn token_uri(token_id: u256) -> ByteArray;
```

#### 4. `total_supply` - Ver cuántos NFTs existen

```cairo
fn total_supply() -> u256;
```

#### 5. `token_by_index` - Obtener token ID por índice

```cairo
fn token_by_index(index: u256) -> u256;
```

#### 6. `name` - Nombre de la colección

```cairo
fn name() -> ByteArray;  // Retorna: "YourCollectible"
```

#### 7. `symbol` - Símbolo de la colección

```cairo
fn symbol() -> ByteArray;  // Retorna: "YCB"
```

---

## 🚀 Ejemplos de Uso en el Frontend

### 📖 1. Leer NFTs de una dirección

```tsx
// components/MyNFTs.tsx
import { useAccount } from "@starknet-react/core";
import { useScaffoldReadContract } from "~~/hooks/scaffold-stark";

export const MyNFTs = () => {
  const { address } = useAccount();
  
  // Obtener el balance (cantidad de NFTs)
  const { data: balance, isLoading } = useScaffoldReadContract({
    contractName: "YourCollectible",
    functionName: "balance_of",
    args: [address],
  });

  // Obtener el total supply
  const { data: totalSupply } = useScaffoldReadContract({
    contractName: "YourCollectible",
    functionName: "total_supply",
  });

  return (
    <div className="card bg-base-100 shadow-xl">
      <div className="card-body">
        <h2 className="card-title">Mis NFTs</h2>
        {isLoading ? (
          <span className="loading loading-spinner"></span>
        ) : (
          <div>
            <p>Balance: {balance?.toString() || "0"} NFTs</p>
            <p>Total Supply: {totalSupply?.toString() || "0"} NFTs</p>
          </div>
        )}
      </div>
    </div>
  );
};
```

---

### 🎨 2. Mintear un NFT

```tsx
// components/MintNFT.tsx
import { useState } from "react";
import { useAccount } from "@starknet-react/core";
import { useScaffoldWriteContract } from "~~/hooks/scaffold-stark";
import { notification } from "~~/utils/scaffold-stark";

export const MintNFT = () => {
  const { address } = useAccount();
  const [ipfsHash, setIpfsHash] = useState("");

  const { sendAsync: mintNFT, isPending } = useScaffoldWriteContract({
    contractName: "YourCollectible",
    functionName: "mint_item",
    args: [address, ipfsHash], // recipient, uri
  });

  const handleMint = async () => {
    if (!ipfsHash) {
      notification.error("Por favor ingresa un IPFS hash");
      return;
    }

    try {
      await mintNFT();
      notification.success("NFT minteado exitosamente!");
      setIpfsHash("");
    } catch (error) {
      console.error("Error minteando NFT:", error);
    }
  };

  return (
    <div className="card bg-base-100 shadow-xl">
      <div className="card-body">
        <h2 className="card-title">Mintear NFT</h2>
        
        <input
          type="text"
          placeholder="IPFS Hash (ej: QmXXX...)"
          className="input input-bordered w-full"
          value={ipfsHash}
          onChange={(e) => setIpfsHash(e.target.value)}
        />

        <button
          className="btn btn-primary"
          onClick={handleMint}
          disabled={isPending}
        >
          {isPending ? (
            <span className="loading loading-spinner loading-sm"></span>
          ) : (
            "Mintear NFT"
          )}
        </button>
      </div>
    </div>
  );
};
```

---

### 🖼️ 3. Mostrar un NFT específico

```tsx
// components/NFTCard.tsx
import { useScaffoldReadContract } from "~~/hooks/scaffold-stark";
import { BlockieAvatar } from "~~/components/scaffold-stark";

interface NFTCardProps {
  tokenId: bigint;
}

export const NFTCard = ({ tokenId }: NFTCardProps) => {
  // Obtener owner del NFT
  const { data: owner } = useScaffoldReadContract({
    contractName: "YourCollectible",
    functionName: "owner_of",
    args: [tokenId],
  });

  // Obtener URI del metadata
  const { data: tokenUri } = useScaffoldReadContract({
    contractName: "YourCollectible",
    functionName: "token_uri",
    args: [tokenId],
  });

  return (
    <div className="card bg-base-100 shadow-xl">
      <figure className="px-10 pt-10">
        <div className="avatar">
          <div className="w-24 rounded">
            <BlockieAvatar address={owner} size={96} />
          </div>
        </div>
      </figure>
      
      <div className="card-body">
        <h2 className="card-title">NFT #{tokenId.toString()}</h2>
        <p className="text-sm">Owner: {owner}</p>
        <p className="text-xs break-all">URI: {tokenUri}</p>
      </div>
    </div>
  );
};
```

---

### 📋 4. Listar TODOS los NFTs (usando Enumerable)

```tsx
// components/AllNFTs.tsx
import { useScaffoldReadContract } from "~~/hooks/scaffold-stark";
import { NFTCard } from "./NFTCard";

export const AllNFTs = () => {
  // Obtener el total supply
  const { data: totalSupply, isLoading } = useScaffoldReadContract({
    contractName: "YourCollectible",
    functionName: "total_supply",
  });

  const supply = totalSupply ? Number(totalSupply) : 0;

  return (
    <div className="container mx-auto">
      <h1 className="text-4xl font-bold mb-8">Todos los NFTs</h1>
      
      {isLoading ? (
        <div className="flex justify-center">
          <span className="loading loading-spinner loading-lg"></span>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {Array.from({ length: supply }, (_, i) => (
            <NFTCard key={i} tokenId={BigInt(i + 1)} />
          ))}
        </div>
      )}
    </div>
  );
};
```

---

### 🔄 5. Transferir un NFT

```tsx
// components/TransferNFT.tsx
import { useState } from "react";
import { useAccount } from "@starknet-react/core";
import { useScaffoldWriteContract } from "~~/hooks/scaffold-stark";
import { AddressInput } from "~~/components/scaffold-stark";

interface TransferNFTProps {
  tokenId: bigint;
}

export const TransferNFT = ({ tokenId }: TransferNFTProps) => {
  const { address: myAddress } = useAccount();
  const [recipientAddress, setRecipientAddress] = useState("");

  const { sendAsync: transferNFT, isPending } = useScaffoldWriteContract({
    contractName: "YourCollectible",
    functionName: "transfer_from",
    args: [myAddress, recipientAddress, tokenId],
  });

  const handleTransfer = async () => {
    try {
      await transferNFT();
      notification.success("NFT transferido exitosamente!");
    } catch (error) {
      console.error("Error transfiriendo NFT:", error);
    }
  };

  return (
    <div className="card bg-base-100 shadow-xl">
      <div className="card-body">
        <h2 className="card-title">Transferir NFT #{tokenId.toString()}</h2>
        
        <AddressInput
          value={recipientAddress}
          onChange={setRecipientAddress}
          placeholder="Dirección del destinatario"
        />

        <button
          className="btn btn-primary"
          onClick={handleTransfer}
          disabled={isPending || !recipientAddress}
        >
          {isPending ? (
            <span className="loading loading-spinner loading-sm"></span>
          ) : (
            "Transferir"
          )}
        </button>
      </div>
    </div>
  );
};
```

---

### 👀 6. Ver NFTs de cualquier dirección

```tsx
// components/NFTsByAddress.tsx
import { useState } from "react";
import { useScaffoldReadContract } from "~~/hooks/scaffold-stark";
import { AddressInput } from "~~/components/scaffold-stark";

export const NFTsByAddress = () => {
  const [address, setAddress] = useState("");

  const { data: balance } = useScaffoldReadContract({
    contractName: "YourCollectible",
    functionName: "balance_of",
    args: [address],
    // Solo hacer la query si hay una dirección válida
    enabled: !!address && address.length > 0,
  });

  return (
    <div className="card bg-base-100 shadow-xl">
      <div className="card-body">
        <h2 className="card-title">Ver NFTs por Dirección</h2>
        
        <AddressInput
          value={address}
          onChange={setAddress}
          placeholder="Ingresa una dirección"
        />

        {address && (
          <div className="mt-4">
            <p className="text-lg">
              Esta dirección tiene: <strong>{balance?.toString() || "0"}</strong> NFTs
            </p>
          </div>
        )}
      </div>
    </div>
  );
};
```

---

### 🎬 7. Escuchar eventos en tiempo real

```tsx
// components/NFTEvents.tsx
import { useState } from "react";
import { useScaffoldWatchContractEvent } from "~~/hooks/scaffold-stark";

export const NFTEvents = () => {
  const [recentMints, setRecentMints] = useState<string[]>([]);

  // Escuchar eventos de Transfer (incluye mints)
  useScaffoldWatchContractEvent({
    contractName: "YourCollectible",
    eventName: "Transfer", // Evento estándar ERC721
    onLogs: (logs) => {
      logs.forEach((log) => {
        const { from, to, tokenId } = log.args;
        
        // Si "from" es 0x0, es un mint
        if (from === "0x0") {
          setRecentMints((prev) => [
            `NFT #${tokenId} minteado para ${to}`,
            ...prev.slice(0, 9), // Mantener solo los últimos 10
          ]);
        }
      });
    },
  });

  return (
    <div className="card bg-base-100 shadow-xl">
      <div className="card-body">
        <h2 className="card-title">Eventos Recientes</h2>
        <div className="overflow-auto max-h-96">
          {recentMints.length === 0 ? (
            <p className="text-gray-500">No hay eventos recientes</p>
          ) : (
            <ul className="space-y-2">
              {recentMints.map((event, index) => (
                <li key={index} className="text-sm border-b pb-2">
                  {event}
                </li>
              ))}
            </ul>
          )}
        </div>
      </div>
    </div>
  );
};
```

---

## 🎨 Ejemplo Completo: Página de NFTs

```tsx
// app/myNFTs/page.tsx
"use client";

import { MintNFT } from "~~/components/MintNFT";
import { MyNFTs } from "~~/components/MyNFTs";
import { AllNFTs } from "~~/components/AllNFTs";
import { NFTEvents } from "~~/components/NFTEvents";

const MyNFTsPage = () => {
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold mb-8">YourCollectible NFTs</h1>
      
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
        <MintNFT />
        <MyNFTs />
      </div>

      <div className="mb-8">
        <NFTEvents />
      </div>

      <AllNFTs />
    </div>
  );
};

export default MyNFTsPage;
```

---

## 💡 Tips y Mejores Prácticas

### 1. Manejo de Errores

```tsx
const handleMint = async () => {
  try {
    await mintNFT();
    notification.success("¡Éxito!");
  } catch (error: any) {
    console.error("Error:", error);
    
    // Diferentes tipos de errores
    if (error.message.includes("User rejected")) {
      notification.error("Transacción rechazada");
    } else if (error.message.includes("insufficient")) {
      notification.error("Fondos insuficientes");
    } else {
      notification.error("Error desconocido");
    }
  }
};
```

### 2. Loading States

```tsx
{isPending ? (
  <span className="loading loading-spinner"></span>
) : (
  "Mintear"
)}
```

### 3. Validaciones

```tsx
const isValidAddress = address && address.startsWith("0x") && address.length === 66;

<button disabled={!isValidAddress || isPending}>
  Enviar
</button>
```

### 4. Refetch Data

```tsx
const { data, refetch } = useScaffoldReadContract({
  contractName: "YourCollectible",
  functionName: "balance_of",
  args: [address],
});

// Después de mintear:
await mintNFT();
await refetch(); // Actualizar el balance
```

---

## 📚 Recursos Adicionales

- **Scaffold-Stark Hooks:** [`packages/nextjs/hooks/scaffold-stark/`](../packages/nextjs/hooks/scaffold-stark/)
- **OpenZeppelin Cairo:** [docs.openzeppelin.com/contracts-cairo](https://docs.openzeppelin.com/contracts-cairo/)
- **Starknet.js Docs:** [starknetjs.com](https://www.starknetjs.com/)
- **Starknet-React:** [starknet-react.com](https://starknet-react.com/)

---

**¡Ya estás listo para construir tu aplicación de NFTs!** 🎨🚀

