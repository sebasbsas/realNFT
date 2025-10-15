# 🚀 Quick Start - Todos los Frontends

> Guía rápida para usar los 3 frontends de NFT en Mainnet

**Última actualización:** Enero 2025  
**Estado:** ✅ Todos funcionales  
**Configuración:** ✅ Unificada en `deployedContracts.ts`  

---

## 🎯 **3 Frontends Disponibles:**

| Frontend | URL | Contrato | IPFS | Función |
|----------|-----|----------|------|---------|
| **QuestlyNFT** | `/mint` | QuestlyNFT | ✅ Requerido | `mint_item(recipient, uri)` |
| **QuestlyNFTStandard** | `/mint-standard` | QuestlyNFTStandard | ✅ Requerido | `mint_item(recipient, uri)` |
| **MinimalNFT** | `/mint-minimal` | MinimalNFT | ❌ No requerido | `mint(recipient)` |

---

## 🚀 **Inicio Rápido (3 comandos):**

```bash
# 1. Ve al directorio del frontend
cd /home/user/testing/realNFT/packages/nextjs

# 2. Inicia el servidor de desarrollo
yarn dev

# 3. Abre en tu navegador
# http://localhost:3000
```

---

## 📋 **Pasos para Usar Cada Frontend:**

### **1. Conectar Wallet Braavos:**
- Haz clic en "Connect" en la esquina superior derecha
- Selecciona tu wallet Braavos
- Confirma la conexión

### **2. Seleccionar Frontend:**

#### **🎨 QuestlyNFT (`/mint`):**
- **Para:** NFTs con metadata IPFS personalizada
- **Campos:** Dirección destinatario + URI de IPFS
- **Ejemplo URI:** `ipfs://QmYourHashHere`

#### **🏭 QuestlyNFTStandard (`/mint-standard`):**
- **Para:** NFTs estándar con metadata IPFS personalizada  
- **Campos:** Dirección destinatario + URI de IPFS
- **Ejemplo URI:** `ipfs://QmYourHashHere`

#### **⚡ MinimalNFT (`/mint-minimal`):**
- **Para:** NFTs básicos sin metadata
- **Campos:** Solo dirección destinatario
- **Sin IPFS:** No requiere URI de metadata

---

## 🔧 **Configuración Actual:**

### **Contratos en Mainnet:**
```typescript
// packages/nextjs/contracts/deployedContracts.ts
mainnet: {
  QuestlyNFT: {
    address: "0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080"
  },
  QuestlyNFTStandard: {
    address: "0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa"
  },
  MinimalNFT: {
    address: "0x755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88"
  }
}
```

### **Estado de la Configuración:**
- ✅ **Todos los contratos** en `deployedContracts.ts`
- ✅ **Configuración unificada** y consistente
- ✅ **Hooks Scaffold-Stark** funcionando correctamente
- ✅ **Sin errores** de "Target Contract is not deployed"

---

## 📝 **Ejemplos de Uso:**

### **Mintear NFT con IPFS (QuestlyNFT o QuestlyNFTStandard):**
1. Ve a `/mint` o `/mint-standard`
2. Ingresa dirección destinatario: `0x123...`
3. Ingresa URI de IPFS: `ipfs://QmYourHashHere`
4. Haz clic en "Mintear NFT"
5. Confirma transacción en Braavos

### **Mintear NFT Básico (MinimalNFT):**
1. Ve a `/mint-minimal`
2. Ingresa dirección destinatario: `0x123...`
3. Haz clic en "Mintear Minimal NFT"
4. Confirma transacción en Braavos

---

## 🛠️ **Troubleshooting:**

### **Error: "Target Contract is not deployed"**
- ✅ **Solucionado:** Todos los contratos están en `deployedContracts.ts`

### **Error: "useScaffoldWriteContract is not a function"**
- ✅ **Solucionado:** Exports agregados a `hooks/scaffold-stark/index.ts`

### **Frontend mint-standard no pide IPFS URI**
- ✅ **Solucionado:** Campo IPFS URI agregado y validaciones incluidas

### **Frontend mint-minimal no tiene input de destinatario**
- ✅ **Solucionado:** Input de dirección agregado

---

## 📊 **Estado Final:**

### ✅ **Completamente Funcional:**
- **3 frontends** operativos en Mainnet
- **Configuración unificada** y consistente
- **Todos los errores** resueltos
- **Documentación** actualizada

### 🎯 **Listo para Usar:**
```bash
# Iniciar servidor
cd /home/user/testing/realNFT/packages/nextjs
yarn dev

# Usar frontends
# http://localhost:3000/mint          - Con IPFS
# http://localhost:3000/mint-standard - Con IPFS  
# http://localhost:3000/mint-minimal  - Sin IPFS
```

---

## 📚 **Documentación Completa:**

Para más detalles, consulta:
- `CONTRACTS_CONFIGURATION_UNIFIED.md` - Configuración unificada
- `MINT_STANDARD_IPFS_FIX.md` - Fix del frontend mint-standard
- `MINIMAL_NFT_CONFIGURATION_FIX.md` - Fix de MinimalNFT
- `TROUBLESHOOTING_FRONTEND.md` - Solución de problemas

---

**¡Todo listo para usar!** 🚀
