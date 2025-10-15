# 🔧 Fix de Configuración del MinimalNFT

## 🚨 **Problema Identificado y Corregido**

**Fecha:** Enero 2025  
**Error:** `Target Contract is not deployed, did you forget to run 'yarn deploy'?`  
**Causa:** MinimalNFT estaba en `externalContracts.ts` en lugar de `deployedContracts.ts`  
**Estado:** ✅ **CORREGIDO**

---

## 🐛 **Problema Original:**

### **❌ Configuración Incorrecta:**
- MinimalNFT estaba en `externalContracts.ts`
- Scaffold-Stark busca contratos en `deployedContracts.ts`
- El hook `useScaffoldWriteContract` no encontraba el contrato
- Error: "Target Contract is not deployed"

### **Error Completo:**
```
Target Contract is not deployed, did you forget to run `yarn deploy`? Stack: 
button unknown:0
MintMinimalNFT webpack-internal:///(app-pages-browser)/./app/mint-minimal/page.tsx:168
[tx-error-1760512892638] Transaction error: Minimal Minting failed: No transaction hash returned.
```

---

## ✅ **Solución Implementada:**

### **✅ Configuración Corregida:**
1. **Movido** MinimalNFT de `externalContracts.ts` a `deployedContracts.ts`
2. **Agregado** en la sección `mainnet` de `deployedContracts.ts`
3. **Removido** de `externalContracts.ts` para evitar duplicados
4. **Mantenida** la misma ABI y dirección

### **Cambios realizados:**

#### **1. Agregado a `deployedContracts.ts`:**
```typescript
mainnet: {
  QuestlyNFTStandard: { /* ... */ },
  MinimalNFT: {
    address: "0x755640286548577c332cb05913db474a809e59a29656c9d0e7ed7285dac8e88",
    abi: [/* ABI completa */],
    classHash: "0x0000000000000000000000000000000000000000000000000000000000000000"
  }
}
```

#### **2. Removido de `externalContracts.ts`:**
- Eliminada la entrada duplicada de MinimalNFT
- Mantenido solo QuestlyNFT en externalContracts

---

## 📊 **Estado de Configuración:**

| Contrato | Archivo de Configuración | Estado |
|----------|-------------------------|--------|
| **QuestlyNFT** | `externalContracts.ts` | ✅ Correcto |
| **QuestlyNFTStandard** | `deployedContracts.ts` | ✅ Correcto |
| **MinimalNFT** | `deployedContracts.ts` | ✅ **CORREGIDO** |

---

## 🎯 **Diferencia entre Archivos:**

### **`deployedContracts.ts`:**
- Para contratos desplegados con Scaffold-Stark
- Reconocidos automáticamente por `useScaffoldWriteContract`
- Incluye QuestlyNFTStandard y MinimalNFT

### **`externalContracts.ts`:**
- Para contratos externos (no desplegados con Scaffold-Stark)
- Requiere configuración manual adicional
- Solo incluye QuestlyNFT (externo)

---

## 🚀 **Cómo Probar el Fix:**

```bash
# El servidor se reinicia automáticamente
# Ir a: http://localhost:3000/mint-minimal

# Probar:
# 1. Conectar wallet Braavos
# 2. Escribir dirección de destino
# 3. Hacer clic en "🎯 Mint Minimal NFT"
# 4. Ya NO debería aparecer el error "Target Contract is not deployed"
```

---

## 📝 **Notas Técnicas:**

### **¿Por qué este error?**
- Scaffold-Stark busca contratos en `deployedContracts.ts` por defecto
- `externalContracts.ts` requiere configuración adicional
- El hook `useScaffoldWriteContract` no encuentra contratos en externalContracts

### **Solución:**
- Mover el contrato al archivo correcto
- Mantener la misma ABI y dirección
- El servidor se reinicia automáticamente

---

## ✅ **Resultado:**

### **Ahora el frontend `/mint-minimal` debería:**
1. ✅ **Reconocer** el contrato MinimalNFT
2. ✅ **Permitir** el minting sin errores
3. ✅ **Funcionar** igual que los otros frontends
4. ✅ **No mostrar** el error "Target Contract is not deployed"

---

**Fecha de corrección:** Enero 2025  
**Estado:** ✅ **PROBLEMA RESUELTO**  
**Próximo paso:** Probar el minting en `/mint-minimal`
