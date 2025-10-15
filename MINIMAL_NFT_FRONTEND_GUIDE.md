# 🎯 MinimalNFT Frontend - Guía Completa

## 📋 Resumen

Frontend para mintear **MinimalNFT** en Starknet Mainnet. Este contrato **NO soporta IPFS metadata** - es un NFT básico para casos de uso simples.

---

## 🎯 Características del MinimalNFT

### ✅ **Funcionalidades:**
- **ERC721 básico** con funcionalidad estándar
- **Minting simple** - solo requiere dirección del destinatario
- **Gas más bajo** - más económico que NFTs con metadata
- **Funciones básicas:** `mint()`, `owner_of()`, `balance_of()`, `name()`, `symbol()`, `total_supply()`

### ❌ **Limitaciones:**
- **NO soporta IPFS** - no puede almacenar URIs de metadata
- **NO tiene token_uri()** - no puede devolver metadata individual
- **Casos de uso limitados** - ideal para pruebas o tokens simples

---

## 🚀 Acceso al Frontend

### **URL:** `http://localhost:3000/mint-minimal`

### **Navegación:**
1. Abrir navegador en `http://localhost:3000`
2. Hacer clic en **"Mint Minimal"** en el menú superior
3. O ir directamente a `/mint-minimal`

---

## 💻 Funcionalidad del Frontend

### **Formulario de Minting:**
- **Campo requerido:** Dirección del destinatario
- **Sin campo IPFS:** No se requiere URI de metadata
- **Validación:** Verifica que la wallet esté conectada y la dirección sea válida

### **Proceso de Minting:**
1. **Conectar wallet** (Braavos recomendado)
2. **Ingresar dirección** del destinatario
3. **Hacer clic** en "🎯 Mint Minimal NFT"
4. **Confirmar transacción** en la wallet
5. **Esperar confirmación** en la blockchain

---

## 🔧 Configuración Técnica

### **Contrato Configurado:**
```typescript
// En externalContracts.ts
MinimalNFT: {
  address: "0x755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88",
  abi: [
    // ABI con funciones básicas de ERC721
    // SIN funciones de metadata IPFS
  ]
}
```

### **Hook Utilizado:**
```typescript
const { sendAsync: mintMinimalNFT } = useScaffoldWriteContract({
  contractName: "MinimalNFT",
  functionName: "mint",
  args: [recipientAddress], // Solo dirección, sin URI
});
```

---

## 📊 Comparación de Contratos

| Característica | QuestlyNFT | QuestlyNFTStandard | MinimalNFT |
|----------------|------------|-------------------|------------|
| **IPFS Support** | ✅ Sí | ✅ Sí | ❌ No |
| **Token URI** | ✅ Sí | ✅ Sí | ❌ No |
| **Función Mint** | `mint_item(to, uri)` | `mint_item(to, uri)` | `mint(to)` |
| **Gas Cost** | ~0.02 STRK | ~0.02 STRK | ~0.01 STRK |
| **Use Case** | Producción completa | Producción completa | Pruebas/Simple |

---

## 🎯 Casos de Uso Recomendados

### ✅ **Ideal para:**
- **Pruebas y desarrollo** - testing rápido
- **Tokens simples** - sin necesidad de metadata
- **Gas económico** - cuando el costo es crítico
- **Prototipos** - desarrollo inicial

### ❌ **NO recomendado para:**
- **Colecciones NFT reales** - falta metadata
- **Arte digital** - sin imágenes/metadata
- **Proyectos de producción** - funcionalidad limitada
- **Marketplaces** - no compatible con estándares de metadata

---

## 🔗 Información del Contrato

### **Dirección:** `0x755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88`
### **Network:** Starknet Mainnet
### **Explorer:** https://starkscan.co/contract/0x755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88
### **Tipo:** ERC721 básico (sin metadata)

---

## 🚀 Inicio Rápido

```bash
# 1. Ve al directorio del frontend
cd /home/user/testing/realNFT/packages/nextjs

# 2. Inicia el servidor de desarrollo
yarn dev

# 3. Abre en tu navegador
# http://localhost:3000/mint-minimal
```

---

## 📝 Notas Importantes

1. **Sin IPFS:** Este contrato NO puede almacenar URIs de metadata
2. **Gas bajo:** Más económico que NFTs completos
3. **Funcionalidad básica:** Solo operaciones ERC721 estándar
4. **Ideal para pruebas:** Perfecto para desarrollo y testing

---

**Última actualización:** Enero 2025  
**Estado:** ✅ Funcional - Contrato confirmado en mainnet
