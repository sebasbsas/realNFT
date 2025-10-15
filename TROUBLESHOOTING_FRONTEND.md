# 🔧 Solución de Problemas - Frontend QuestlyNFTStandard

## ⚠️ Errores Comunes y Soluciones

> **🔄 ACTUALIZACIÓN:** Este documento ha sido actualizado para el contrato QuestlyNFTStandard (ERC721 estándar).  
> **Nueva dirección:** `0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa`

---

## 1. Error: "Could not find a production build in the '.next' directory"

### 🚨 Problema:
```
Error: Could not find a production build in the '.next' directory. 
Try building your app with 'next build' before starting the production server.
```

### ✅ Solución:
**Usa el comando correcto para desarrollo:**

```bash
# ❌ INCORRECTO (para producción)
yarn start

# ✅ CORRECTO (para desarrollo)
yarn dev
```

**Explicación:** `yarn start` es para servidor de producción que requiere un build previo. Para desarrollo, usa `yarn dev`.

---

## 2. Error: "ENOENT: no such file or directory, open '.next/server/vendor-chunks/next.js'"

### 🚨 Problema:
```
Error: ENOENT: no such file or directory, open '/home/user/testing/realNFT/packages/nextjs/.next/server/vendor-chunks/next.js'
```

### ✅ Solución:
**Limpia el directorio .next corrupto:**

```bash
# 1. Detener el servidor
pkill -f "next dev" || true

# 2. Eliminar directorio .next
cd /home/user/testing/realNFT/packages/nextjs
rm -rf .next

# 3. Limpiar cache y reinstalar
yarn cache clean
yarn install

# 4. Iniciar en modo desarrollo
yarn dev
```

---

## 3. Error: "Module not found" o errores de dependencias

### 🚨 Problema:
```
Module not found: Can't resolve '...'
Error: Cannot find module '...'
```

### ✅ Solución:
**Reinstalar dependencias:**

```bash
cd /home/user/testing/realNFT/packages/nextjs

# Limpiar todo
rm -rf node_modules
rm -rf .next
rm yarn.lock

# Reinstalar
yarn install

# Iniciar
yarn dev
```

---

## 4. Error: "Failed to fetch" o problemas de red

### 🚨 Problema:
```
Failed to fetch
Network error
RPC connection issues
```

### ✅ Solución:
**Verificar configuración de red:**

1. **Revisar variables de entorno:**
```bash
# Verificar que .env.local existe
cat packages/nextjs/.env.local
```

2. **Verificar RPC URL:**
```env
NEXT_PUBLIC_MAINNET_PROVIDER_URL=https://starknet-mainnet.public.blastapi.io/rpc/v0_7
```

3. **Probar con otro RPC:**
```env
# Alternativa 1
NEXT_PUBLIC_MAINNET_PROVIDER_URL=https://starknet-mainnet.public.blastapi.io/rpc/v0_7

# Alternativa 2
NEXT_PUBLIC_MAINNET_PROVIDER_URL=https://starknet-mainnet.g.alchemy.com/starknet/version/rpc/v0_7
```

---

## 5. Error: "Contract not found" o "Contract address invalid"

### 🚨 Problema:
```
Contract not found
Invalid contract address
```

### ✅ Solución:
**Verificar configuración del contrato:**

1. **Revisar externalContracts.ts:**
```bash
cat packages/nextjs/contracts/externalContracts.ts | grep "0x2cf4e33c"
```

2. **Verificar que la dirección sea correcta:**
```
Contrato: 0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080
```

3. **Verificar en Starkscan:**
https://starkscan.co/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080

---

## 6. Error: "Wallet not connected" o problemas de Braavos

### 🚨 Problema:
```
Please connect your Braavos wallet first
Wallet connection failed
```

### ✅ Solución:
**Verificar conexión de wallet:**

1. **Instalar/actualizar Braavos:**
   - Descargar desde: https://braavos.app
   - Actualizar a la última versión

2. **Verificar red:**
   - Asegurarse de estar en **Starknet Mainnet**
   - NO en Sepolia o Devnet

3. **Limpiar cache del navegador:**
   - Ctrl+Shift+R (recarga forzada)
   - O abrir ventana privada/incógnito

4. **Reconectar wallet:**
   - Desconectar y volver a conectar Braavos
   - Refrescar la página

---

## 7. Error: "Transaction failed" o "Gas estimation failed"

### 🚨 Problema:
```
Transaction failed
Gas estimation failed
Insufficient funds
```

### ✅ Solución:
**Verificar fondos y red:**

1. **Verificar balance:**
   - Abrir Braavos
   - Verificar que tienes STRK o ETH para gas

2. **Verificar red:**
   - Asegurarse de estar en **Mainnet**
   - NO en testnets

3. **Probar con menos gas:**
   - El contrato debería manejar esto automáticamente

4. **Esperar y reintentar:**
   - La red puede estar congestionada
   - Esperar unos minutos e intentar nuevamente

---

## 8. Error: "URI invalid" o problemas con IPFS

### 🚨 Problema:
```
The URI of IPFS cannot be empty
Invalid IPFS URI
```

### ✅ Solución:
**Verificar URI de IPFS:**

1. **Formato correcto:**
```
✅ ipfs://QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG
✅ https://ipfs.io/ipfs/QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG
```

2. **Verificar que la URI sea accesible:**
   - Probar en el navegador
   - Debe mostrar el JSON del metadata

3. **Ejemplo de metadata válido:**
```json
{
  "name": "Questly Platinum #1",
  "description": "NFT exclusivo",
  "image": "ipfs://QmXxx.../imagen.png",
  "attributes": [
    {
      "trait_type": "Rarity",
      "value": "Platinum"
    }
  ]
}
```

---

## 9. Error: "Page not found" o 404

### 🚨 Problema:
```
404 - This page could not be found
```

### ✅ Solución:
**Verificar URLs:**

1. **URL correcta:**
```
✅ http://localhost:3000/mint
❌ http://localhost:3000/mint/
❌ http://localhost:3000/mintNFT
```

2. **Verificar que el servidor esté corriendo:**
```bash
# Debería mostrar:
# ▲ Next.js 15.2.4
# - Local:        http://localhost:3000
# - Network:      http://10.0.2.15:3000
```

---

## 10. Error: "useScaffoldWriteContract is not a function"

### 🚨 Problema:
```
Error: _hooks_scaffold_stark__WEBPACK_IMPORTED_MODULE_4__.useScaffoldWriteContract is not a function
Attempted import error: 'useScaffoldWriteContract' is not exported from '~~/hooks/scaffold-stark'
```

### ✅ Solución:
**Agregar los exports faltantes en el archivo index.ts:**

```bash
# Editar el archivo de exports
cd /home/user/testing/realNFT/packages/nextjs
nano hooks/scaffold-stark/index.ts
```

**Agregar estas líneas al archivo:**
```typescript
export * from "./useScaffoldContract";
export * from "./useScaffoldReadContract";
export * from "./useScaffoldWriteContract";
export * from "./useScaffoldMultiWriteContract";
export * from "./useScaffoldEventHistory";
export * from "./useScaffoldWatchContractEvent";
```

**O usar este comando para agregar automáticamente:**
```bash
cd /home/user/testing/realNFT/packages/nextjs
cat >> hooks/scaffold-stark/index.ts << 'EOF'

export * from "./useScaffoldContract";
export * from "./useScaffoldReadContract";
export * from "./useScaffoldWriteContract";
export * from "./useScaffoldMultiWriteContract";
export * from "./useScaffoldEventHistory";
export * from "./useScaffoldWatchContractEvent";
EOF
```

**Después de editar, el servidor se reiniciará automáticamente.**

---

## 11. Error: "Build failed" o errores de compilación

### 🚨 Problema:
```
Build failed
Compilation error
TypeScript errors
```

### ✅ Solución:
**Verificar código y dependencias:**

1. **Verificar errores de TypeScript:**
```bash
cd /home/user/testing/realNFT/packages/nextjs
npx tsc --noEmit
```

2. **Verificar linter:**
```bash
yarn lint
```

3. **Verificar archivos creados:**
```bash
# Verificar que estos archivos existen:
ls -la packages/nextjs/app/mint/page.tsx
ls -la packages/nextjs/contracts/externalContracts.ts
ls -la packages/nextjs/components/Header.tsx
```

---

## 🔍 Comandos de Diagnóstico

### Verificar estado del servidor:
```bash
# Verificar procesos de Node.js
ps aux | grep next

# Verificar puerto 3000
lsof -i :3000

# Verificar logs del servidor
cd /home/user/testing/realNFT/packages/nextjs
yarn dev
```

### Verificar configuración:
```bash
# Verificar variables de entorno
cat packages/nextjs/.env.local

# Verificar configuración de red
cat packages/nextjs/scaffold.config.ts | grep targetNetworks

# Verificar contrato externo
cat packages/nextjs/contracts/externalContracts.ts | grep "0x2cf4e33c"
```

### Verificar archivos:
```bash
# Verificar que todos los archivos existen
ls -la packages/nextjs/app/mint/
ls -la packages/nextjs/contracts/
ls -la packages/nextjs/components/Header.tsx

# Verificar contenido de archivos clave
head -10 packages/nextjs/app/mint/page.tsx
head -10 packages/nextjs/contracts/externalContracts.ts
```

---

## 📞 Obtener Ayuda

### Si el problema persiste:

1. **Verificar logs completos:**
```bash
cd /home/user/testing/realNFT/packages/nextjs
yarn dev 2>&1 | tee debug.log
```

2. **Verificar versión de Node.js:**
```bash
node --version  # Debe ser >= 18
yarn --version  # Debe ser >= 1.22
```

3. **Verificar espacio en disco:**
```bash
df -h
```

4. **Limpiar sistema completamente:**
```bash
# ⚠️ CUIDADO: Esto elimina todo el cache
cd /home/user/testing/realNFT
rm -rf packages/nextjs/node_modules
rm -rf packages/nextjs/.next
rm -rf packages/nextjs/yarn.lock
rm -rf ~/.yarn/cache
cd packages/nextjs
yarn install
yarn dev
```

---

## ✅ Checklist de Verificación

Antes de reportar un problema, verifica:

- [ ] Node.js >= 18 instalado
- [ ] Yarn instalado
- [ ] Braavos instalado y actualizado
- [ ] Estás en Starknet Mainnet (no Sepolia)
- [ ] Tienes fondos para gas (STRK o ETH)
- [ ] URI de IPFS es válida y accesible
- [ ] Usas `yarn dev` (no `yarn start`)
- [ ] El servidor muestra "Local: http://localhost:3000"
- [ ] Puedes acceder a http://localhost:3000/mint
- [ ] Braavos está conectado y muestra tu dirección

---

## 📝 Logs Útiles

### Para reportar problemas, incluye:

1. **Comando usado:**
```bash
yarn dev
```

2. **Mensaje de error completo**

3. **Versiones:**
```bash
node --version
yarn --version
```

4. **Estado del servidor:**
```bash
ps aux | grep next
```

5. **Configuración de red:**
```bash
cat packages/nextjs/.env.local
```

---

¡Con esta guía deberías poder resolver la mayoría de problemas! 🚀

**Fecha de actualización:** Octubre 2025  
**Versión:** 1.1
