# ⚡ Quick Start - Mintear NFT en QuestlyNFTStandard Mainnet

## 🎯 Contrato QuestlyNFTStandard (ERC721 Estándar)

```
Nombre: Questly Platinums (QEST)
Dirección: 0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
Red: Starknet Mainnet
Estándar: ERC721 completo con OpenZeppelin
Starkscan: https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
Voyager: https://voyager.online/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
```

> **🔄 ACTUALIZACIÓN:** Contrato actualizado a estándar ERC721 para mejor compatibilidad con exploradores.

---

## 🚀 Inicio Rápido (3 comandos)

```bash
# 1. Ve al directorio del frontend
cd /home/user/testing/realNFT/packages/nextjs

# 2. Inicia el servidor de desarrollo
yarn dev

# 3. Abre en tu navegador
# http://localhost:3000/mint
```

---

## 📝 Mintear en 4 pasos

### 1️⃣ Conectar Braavos
- Clic en "Connect Wallet" (arriba a la derecha)
- Seleccionar **Braavos**
- ⚠️ Verificar que estás en **Mainnet**

### 2️⃣ Dirección Destino
```
Formato: 0x...
Ejemplo: 0x034aA3F359A9D614239015126635CE7732c18fDF3
```

### 3️⃣ URI de IPFS
```
Formato: ipfs://QmXxx... o https://ipfs.io/ipfs/QmXxx...
Ejemplo: ipfs://QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG
```

### 4️⃣ Confirmar
- Clic en "✨ Mintear NFT"
- Confirmar en Braavos
- ¡Listo! 🎉

---

## 📁 Archivos Creados

| Archivo | Descripción |
|---------|-------------|
| `packages/nextjs/app/mint/page.tsx` | 🎨 Página de minteo |
| `packages/nextjs/contracts/externalContracts.ts` | ⚙️ Config del contrato |
| `packages/nextjs/components/Header.tsx` | 📍 Menú actualizado |
| `QUESTLY_NFT_MAINNET_MINT_INSTRUCTIONS.md` | 📖 Guía completa |
| `QUICK_START_MINT.md` | ⚡ Este archivo (resumen rápido) |

---

## ✅ Checklist Pre-Minteo

- [ ] Servidor corriendo en http://localhost:3000
- [ ] Braavos instalado y conectado
- [ ] Red configurada en **Mainnet** (no Sepolia)
- [ ] Fondos suficientes (STRK o ETH) para gas
- [ ] Metadata subido a IPFS
- [ ] URI de IPFS lista para copiar

---

## 🔍 Verificar NFT Minteado

**En Exploradores:**
- Starkscan: https://starkscan.co/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080
- Voyager: https://voyager.online/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080

**En Braavos:**
- Sección NFTs → Buscar "Questly Platinums" o "QEST"

---

## 📚 Documentación Completa

Para instrucciones detalladas, solución de problemas y referencias técnicas:

👉 **Ver:** `QUESTLY_NFT_MAINNET_MINT_INSTRUCTIONS.md`

---

## 🎉 ¡Ya está todo listo!

Accede a: **http://localhost:3000/mint**

