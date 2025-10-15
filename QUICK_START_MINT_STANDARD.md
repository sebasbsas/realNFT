# ⚡ Quick Start - Mintear NFT Estándar en QuestlyNFTStandard Mainnet

## 🎯 Contrato QuestlyNFTStandard

```
Nombre: QuestlyNFTStandard (ERC721 Estándar)
Dirección: 0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
Red: Starknet Mainnet
Explorer: https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
```

---

## 🚀 Inicio Rápido (3 comandos)

```bash
# 1. Ve al directorio del frontend
cd /home/user/testing/realNFT/packages/nextjs

# 2. Inicia el servidor de desarrollo
yarn dev

# 3. Abre en tu navegador
# http://localhost:3000/mint-standard
```

---

## 📝 Mintear en 3 pasos (¡Más simple!)

### 1️⃣ Conectar Braavos
- Clic en "Connect Wallet" (arriba a la derecha)
- Seleccionar **Braavos**
- ⚠️ Verificar que estás en **Mainnet**

### 2️⃣ Dirección Destino
```
Formato: 0x...
Ejemplo: 0x034aA3F359A9D614239015126635CE7732c18fDF3
```

### 3️⃣ Confirmar
- Clic en "✨ Mintear NFT Estándar"
- Confirmar en Braavos
- ¡Listo! 🎉

---

## 📁 Archivos Creados

| Archivo | Descripción |
|---------|-------------|
| `packages/nextjs/app/mint-standard/page.tsx` | 🎨 Página de minteo estándar |
| `packages/nextjs/components/Header.tsx` | 📍 Menú actualizado |
| `QUESTLY_NFT_STANDARD_INSTRUCTIONS.md` | 📖 Guía completa |
| `QUICK_START_MINT_STANDARD.md` | ⚡ Este archivo (resumen rápido) |

---

## ✅ Checklist Pre-Minteo

- [ ] Servidor corriendo en http://localhost:3000
- [ ] Braavos instalado y conectado
- [ ] Red configurada en **Mainnet** (no Sepolia)
- [ ] Fondos suficientes (STRK o ETH) para gas
- [ ] Dirección del destinatario lista

---

## 🔄 Diferencias con QuestlyNFT

| Característica | QuestlyNFT | QuestlyNFTStandard |
|----------------|------------|-------------------|
| **Metadata** | ✅ IPFS personalizada | ❌ Sin metadata |
| **URI** | ✅ Individual por token | ❌ Estándar/base |
| **Campos** | 2 (destinatario + URI) | 1 (solo destinatario) |
| **Gas** | Más alto | Más bajo |
| **Simplicidad** | Complejo | Simple |

---

## 🔍 Verificar NFT Minteado

**En Exploradores:**
- Starkscan: https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
- Voyager: https://voyager.online/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa

**En Braavos:**
- Sección NFTs → Buscar "QuestlyNFTStandard"

---

## 📚 Documentación Completa

Para instrucciones detalladas y solución de problemas:

👉 **Ver:** `QUESTLY_NFT_STANDARD_INSTRUCTIONS.md`

---

## 🎉 ¡Ya está todo listo!

Accede a: **http://localhost:3000/mint-standard**

**¡Más simple que nunca!** 🚀
