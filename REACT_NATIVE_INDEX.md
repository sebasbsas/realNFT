# 📱 Índice: Guías React Native para NFTs

## 🎯 ¿Qué contrato necesitas usar?

### ✅ **Si necesitas IPFS metadata:**
📄 **Usa:** `QuestlyNFT`  
📖 **Guía:** `REACT_NATIVE_QUESTLY_NFT.md`

**Características:**
- ✅ Soporte completo IPFS
- ✅ URI individual por token
- ✅ Función: `mint_item(recipient, uri)`
- ✅ Ideal para colecciones con metadata
- **Address:** `0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080`

**Ejemplo de uso:**
```typescript
await contract.mint_item(
  userAddress,
  'ipfs://QmZdULHpCfuZAzoFo6YrS7mCLr8g9eBVPx2YNt3NRTXF9F/nft-01.json'
);
```

---

### ⚠️ **Si NO necesitas IPFS metadata:**
📄 **Usa:** `MinimalNFT`  
📖 **Guía:** `REACT_NATIVE_MINIMAL_NFT_NO_IPFS.md`

**Características:**
- ❌ Sin soporte IPFS
- ✅ Minting básico y rápido
- ✅ Función: `mint(to)`
- ✅ Gas más bajo
- ⚠️ Solo para casos simples/pruebas
- **Address:** `0x755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88`

**Ejemplo de uso:**
```typescript
await contract.mint(userAddress);
```

---

## 📚 Archivos Disponibles

| Archivo | Contrato | IPFS | Descripción |
|---------|----------|------|-------------|
| `REACT_NATIVE_QUESTLY_NFT.md` | QuestlyNFT | ✅ SÍ | **Recomendado** - Con metadata IPFS |
| `REACT_NATIVE_MINIMAL_NFT_NO_IPFS.md` | MinimalNFT | ❌ NO | Básico - Sin metadata |
| `QUESTLY_NFT_DEPLOYMENT.md` | QuestlyNFT | ✅ SÍ | Info del despliegue en mainnet |

---

## 🔄 Comparación Rápida

### MinimalNFT vs QuestlyNFT

| Feature | MinimalNFT | QuestlyNFT |
|---------|------------|------------|
| **IPFS URIs** | ❌ | ✅ |
| **Metadata por token** | ❌ | ✅ |
| **Función mint** | `mint(to)` | `mint_item(to, uri)` |
| **Gas cost** | ~0.01 STRK | ~0.01-0.02 STRK |
| **OpenZeppelin** | ❌ | ✅ ERC721 + Ownable |
| **Use case** | Pruebas/simple | Producción/colecciones |

---

## 🚀 ¿Cuál elegir?

### 🎨 **Elige QuestlyNFT si:**
- ✅ Necesitas imágenes/metadata
- ✅ Construyes una colección NFT real
- ✅ Usas IPFS para almacenar metadata
- ✅ Quieres URIs únicos por token
- ✅ Es un proyecto de producción

### 🔧 **Elige MinimalNFT si:**
- ✅ Solo pruebas/demos
- ✅ No necesitas metadata
- ✅ Quieres el mínimo gas posible
- ✅ Solo necesitas propiedad básica
- ❌ NO es para producción seria

---

## 📖 Guías Adicionales

- 📄 **Despliegue Mainnet:** `MAINNET_DEPLOYMENT_GUIDE.md`
- 📄 **Info QuestlyNFT:** `QUESTLY_NFT_DEPLOYMENT.md`
- 📄 **Checklist Hardcoded:** `HARDCODED_VALUES_CHECKLIST.md`

---

## 💡 Recomendación

**Para tu caso de uso con IPFS:**
```
ipfs://QmZdULHpCfuZAzoFo6YrS7mCLr8g9eBVPx2YNt3NRTXF9F/nft-01-balance-orb-basic.json
```

👉 **Usa `QuestlyNFT`**  
📖 **Guía:** `REACT_NATIVE_QUESTLY_NFT.md`

---

**Última actualización:** 15 de Octubre, 2025

