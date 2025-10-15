# 🚨 Checklist de Valores Hardcodeados para Mainnet

## ⚠️ VALORES CRÍTICOS QUE DEBES CAMBIAR ANTES DE MAINNET

---

## 1️⃣ Script de Despliegue - **CRÍTICO** 🔴

**Archivo:** `packages/snfoundry/scripts-ts/deploy.ts`

### ❌ PROBLEMA: Dirección de Owner Hardcodeada

**Líneas 50-53:**
```typescript
const deployScript = async (): Promise<void> => {
  await deployContract({
    contract: "YourCollectible",
    constructorArgs: {
      owner: "0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691", // ⚠️ DEVNET ADDRESS
    },
  });
};
```

**Esta es la dirección de la cuenta predeployada de devnet #1** - Si deployeas con esto en mainnet, ¡no tendrás control del contrato!

### ✅ SOLUCIÓN 1: Usar la dirección del deployer automáticamente

```typescript
const deployScript = async (): Promise<void> => {
  await deployContract({
    contract: "YourCollectible",
    constructorArgs: {
      owner: deployer.address, // ✅ Usa automáticamente la dirección configurada en .env
    },
  });
};
```

### ✅ SOLUCIÓN 2: Especificar tu dirección de mainnet

```typescript
const deployScript = async (): Promise<void> => {
  await deployContract({
    contract: "YourCollectible",
    constructorArgs: {
      owner: "0xTU_DIRECCION_DE_MAINNET_AQUI", // ✅ Tu dirección real de mainnet
    },
  });
};
```

### 🎯 RECOMENDACIÓN

**Usa la SOLUCIÓN 1** (`deployer.address`) porque:
- Es más seguro
- Funciona automáticamente en todas las redes
- Toma la dirección del archivo `.env` según la red
- No necesitas modificar el código cada vez

---

## 2️⃣ Configuración del Frontend - **CRÍTICO** 🔴

**Archivo:** `packages/nextjs/scaffold.config.ts`

### ❌ PROBLEMA: Configurado para Devnet

**Línea 13:**
```typescript
const scaffoldConfig = {
  targetNetworks: [chains.devnet], // ⚠️ DEVNET - Red de desarrollo local
  onlyLocalBurnerWallet: false,
  pollingInterval: 30_000,
  autoConnectTTL: 60000,
  walletAutoConnect: true,
} as const satisfies ScaffoldConfig;
```

### ✅ SOLUCIÓN: Cambiar a Mainnet

```typescript
const scaffoldConfig = {
  targetNetworks: [chains.mainnet], // ✅ MAINNET - Red de producción
  onlyLocalBurnerWallet: false, // ✅ Desactivado para mainnet (importante!)
  pollingInterval: 30_000,
  autoConnectTTL: 60000,
  walletAutoConnect: true,
} as const satisfies ScaffoldConfig;
```

### 📋 Opciones de Red

```typescript
// Desarrollo local
targetNetworks: [chains.devnet]

// Testnet (para pruebas)
targetNetworks: [chains.sepolia]

// Producción
targetNetworks: [chains.mainnet]

// Múltiples redes (permite al usuario elegir)
targetNetworks: [chains.mainnet, chains.sepolia]
```

---

## 3️⃣ Metadata del NFT - **IMPORTANTE** 🟡

**Archivo:** `packages/snfoundry/contracts/src/your_collectible.cairo`

### 🤔 REVISAR: Nombre y Símbolo del NFT

**Líneas 76-78:**
```cairo
fn constructor(ref self: ContractState, owner: ContractAddress) {
    let name: ByteArray = "Questly Platinums"; // 🤔 ¿Es este el nombre correcto?
    let symbol: ByteArray = "QEST";            // 🤔 ¿Es este el símbolo correcto?
    let base_uri: ByteArray = "";              // 🤔 ¿Necesitas un base URI?
```

### ✅ ACCIÓN REQUERIDA

Decide si estos valores son los correctos para tu proyecto en mainnet:

```cairo
fn constructor(ref self: ContractState, owner: ContractAddress) {
    // ✅ Personaliza estos valores para tu proyecto
    let name: ByteArray = "Tu Colección NFT";  // Nombre visible del NFT
    let symbol: ByteArray = "TUNFT";           // Símbolo corto (2-5 caracteres)
    let base_uri: ByteArray = "https://ipfs.io/ipfs/"; // URI base para metadata
```

### 📝 Ejemplos de Proyectos Reales

```cairo
// Ejemplo 1: Colección de arte
let name: ByteArray = "Starknet Pixels";
let symbol: ByteArray = "SPIX";

// Ejemplo 2: Membership NFTs
let name: ByteArray = "Premium Members";
let symbol: ByteArray = "PMEM";

// Ejemplo 3: Gaming NFTs
let name: ByteArray = "Warrior Cards";
let symbol: ByteArray = "WCAR";
```

### ⚠️ IMPORTANTE

- El **nombre** es lo que aparecerá en wallets y marketplaces
- El **símbolo** es la abreviatura (como ETH, BTC)
- El **base_uri** es opcional pero recomendado para IPFS/metadata
- **NO PUEDES CAMBIAR ESTOS VALORES DESPUÉS DE DESPLEGAR**

---

## 4️⃣ Configuración de Snfoundry - **REVISAR** 🟡

**Archivo:** `packages/snfoundry/snfoundry.toml`

### 🤔 VERIFICAR: Configuración de Cuenta

```toml
[[accounts.default]]
kind = "keystore"
path = "~/.starknet_accounts/starknet_open_zeppelin_accounts.json"
address = "0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691"
```

Esta configuración es para **devnet local**. No afecta directamente el despliegue a mainnet porque el script `deploy.ts` usa las variables de entorno del archivo `.env`, pero es bueno saberlo.

### ✅ SOLUCIÓN

No necesitas cambiar este archivo si usas `.env` correctamente. El comando `yarn deploy --network mainnet` usará automáticamente las credenciales de mainnet del archivo `.env`.

---

## 5️⃣ Constante STRK Token - **OK** ✅

**Archivo:** `packages/snfoundry/contracts/src/your_contract.cairo`

### ✅ CORRECTO: No Requiere Cambios

**Líneas 26-27:**
```cairo
pub const FELT_STRK_CONTRACT: felt252 =
    0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d;
```

**Esta dirección es la misma en todas las redes (devnet, sepolia, mainnet).**

❌ NO cambies este valor
✅ Ya está correcto para mainnet

---

## 6️⃣ Helpers de Red - **OK** ✅

**Archivo:** `packages/snfoundry/scripts-ts/helpers/networks.ts`

### ✅ CORRECTO: Configuración Multi-Red

**Líneas 8-14:**
```typescript
// devnet
const PRIVATE_KEY_DEVNET = process.env.PRIVATE_KEY_DEVNET || "0x71d7bb07b9a64f6f78ac4c816aff4da9";
const RPC_URL_DEVNET = process.env.RPC_URL_DEVNET || "http://127.0.0.1:5050";
const ACCOUNT_ADDRESS_DEVNET =
  process.env.ACCOUNT_ADDRESS_DEVNET ||
  "0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691";
```

Estos son **valores por defecto** que se usan solo si no hay variables de entorno configuradas. Son seguros porque:

1. Solo se usan para devnet
2. Las redes reales (sepolia/mainnet) **requieren** las variables de entorno
3. No tienen valores por defecto para mainnet (seguridad)

✅ No necesitas cambiar este archivo

---

## 📋 Checklist Completo Pre-Mainnet

### ✅ Cambios OBLIGATORIOS

- [ ] **1. Cambiar owner en `deploy.ts`** 
  - De: `"0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691"`
  - A: `deployer.address` o tu dirección de mainnet

- [ ] **2. Cambiar red en `scaffold.config.ts`**
  - De: `targetNetworks: [chains.devnet]`
  - A: `targetNetworks: [chains.mainnet]`

### 🤔 Cambios RECOMENDADOS

- [ ] **3. Revisar nombre del NFT en `your_collectible.cairo`**
  - Verificar: `"Questly Platinums"` es el nombre correcto
  
- [ ] **4. Revisar símbolo del NFT en `your_collectible.cairo`**
  - Verificar: `"QEST"` es el símbolo correcto
  
- [ ] **5. Configurar base_uri si usas IPFS/metadata**
  - Actual: `""` (vacío)
  - Considerar: `"https://ipfs.io/ipfs/"` o tu servidor

### ✅ Archivos de Configuración

- [ ] **6. Crear `.env` en `packages/snfoundry/`**
  - Con `ACCOUNT_ADDRESS_MAINNET`
  - Con `PRIVATE_KEY_MAINNET`
  - Con `RPC_URL_MAINNET`

- [ ] **7. Crear `.env` en `packages/nextjs/`**
  - Con `NEXT_PUBLIC_MAINNET_PROVIDER_URL`

### 🔒 Seguridad

- [ ] **8. Verificar que `.env` está en `.gitignore`**
- [ ] **9. NUNCA commitear claves privadas**
- [ ] **10. Usar diferentes cuentas para dev y prod**

---

## 🔍 Cómo Verificar que Todo Está Correcto

### 1. Verificar el Script de Despliegue

```bash
cd packages/snfoundry
cat scripts-ts/deploy.ts | grep -A 5 "constructorArgs"
```

Deberías ver:
```typescript
constructorArgs: {
  owner: deployer.address, // ✅ Correcto
}
```

### 2. Verificar la Configuración del Frontend

```bash
cd packages/nextjs
cat scaffold.config.ts | grep "targetNetworks"
```

Deberías ver:
```typescript
targetNetworks: [chains.mainnet], // ✅ Correcto para producción
```

### 3. Verificar las Variables de Entorno

```bash
cd packages/snfoundry
cat .env | grep MAINNET
```

Deberías ver:
```bash
ACCOUNT_ADDRESS_MAINNET=0x[tu_direccion]
PRIVATE_KEY_MAINNET=0x[tu_clave]
RPC_URL_MAINNET=https://...
```

### 4. Compilar y Verificar

```bash
cd packages/snfoundry
scarb build
```

Si hay errores de compilación, resuélvelos antes de desplegar.

---

## ⚡ Script de Verificación Rápida

Crea un archivo `check-mainnet-ready.sh` en la raíz del proyecto:

```bash
#!/bin/bash

echo "🔍 Verificando configuración para Mainnet..."
echo ""

# Check 1: deploy.ts
echo "1️⃣ Verificando deploy.ts..."
if grep -q "0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691" packages/snfoundry/scripts-ts/deploy.ts; then
    echo "❌ ADVERTENCIA: deploy.ts tiene dirección hardcodeada de devnet"
else
    echo "✅ deploy.ts está configurado correctamente"
fi

# Check 2: scaffold.config.ts
echo ""
echo "2️⃣ Verificando scaffold.config.ts..."
if grep -q "chains.devnet" packages/nextjs/scaffold.config.ts; then
    echo "❌ ADVERTENCIA: scaffold.config.ts está configurado para devnet"
else
    echo "✅ scaffold.config.ts está configurado para producción"
fi

# Check 3: .env files
echo ""
echo "3️⃣ Verificando archivos .env..."
if [ ! -f "packages/snfoundry/.env" ]; then
    echo "❌ FALTA: packages/snfoundry/.env no existe"
else
    if grep -q "ACCOUNT_ADDRESS_MAINNET" packages/snfoundry/.env; then
        echo "✅ .env de snfoundry configurado"
    else
        echo "⚠️  ADVERTENCIA: .env no tiene configuración de mainnet"
    fi
fi

if [ ! -f "packages/nextjs/.env" ]; then
    echo "❌ FALTA: packages/nextjs/.env no existe"
else
    if grep -q "NEXT_PUBLIC_MAINNET_PROVIDER_URL" packages/nextjs/.env; then
        echo "✅ .env de nextjs configurado"
    else
        echo "⚠️  ADVERTENCIA: .env de nextjs no tiene RPC de mainnet"
    fi
fi

# Check 4: Compilation
echo ""
echo "4️⃣ Verificando compilación..."
cd packages/snfoundry
if scarb build &> /dev/null; then
    echo "✅ Contratos compilan correctamente"
else
    echo "❌ ERROR: Los contratos no compilan"
fi
cd ../..

echo ""
echo "✅ Verificación completa. Revisa los warnings antes de desplegar."
```

**Uso:**
```bash
chmod +x check-mainnet-ready.sh
./check-mainnet-ready.sh
```

---

## 🚀 Proceso de Despliegue Seguro

### Paso 1: Hacer los Cambios Obligatorios
1. Modificar `deploy.ts` → usar `deployer.address`
2. Modificar `scaffold.config.ts` → usar `chains.mainnet`
3. Revisar metadata del NFT en `your_collectible.cairo`

### Paso 2: Configurar Variables de Entorno
1. Crear `.env` en `packages/snfoundry/`
2. Crear `.env` en `packages/nextjs/`
3. Agregar credenciales de mainnet

### Paso 3: Verificar Todo
1. Ejecutar `./check-mainnet-ready.sh`
2. Ejecutar `scarb build` para compilar
3. Revisar el checklist completo

### Paso 4: Desplegar
```bash
cd packages/snfoundry
yarn deploy --network mainnet
```

### Paso 5: Verificar el Despliegue
1. Buscar tu contrato en block explorer
2. Verificar que tú eres el owner
3. Probar funciones básicas desde el frontend

---

## 🆘 FAQ - Preguntas Frecuentes

### ¿Qué pasa si olvido cambiar la dirección en deploy.ts?

🚨 **Grave:** El contrato se desplegará con el owner siendo la dirección de devnet. No tendrás control del contrato y no podrás:
- Hacer withdraw de fondos
- Modificar configuraciones
- Usar funciones de owner

**Solución:** SIEMPRE verifica antes de desplegar.

### ¿Puedo usar la misma cuenta para dev y mainnet?

❌ **No recomendado**. Es mejor práctica usar:
- Una cuenta para desarrollo (devnet/sepolia)
- Una cuenta diferente para producción (mainnet)

Esto reduce riesgos de seguridad y confusión.

### ¿Puedo cambiar el nombre del NFT después de desplegar?

❌ **No**. Los valores del constructor (nombre, símbolo, base_uri) se establecen en el despliegue y no se pueden cambiar después.

**Solución:** Verifica dos veces antes de desplegar.

### ¿Qué pasa si despliego con chains.devnet en scaffold.config.ts?

El contrato se desplegará correctamente en mainnet, pero:
- El frontend intentará conectarse a devnet
- Los usuarios no verán el contrato
- Las transacciones no funcionarán

**Solución:** Cambia a `chains.mainnet` antes de desplegar.

---

## 📚 Referencias

- [Guía Completa de Mainnet](./MAINNET_DEPLOYMENT_GUIDE.md)
- [Documentación Oficial de Starknet](https://docs.starknet.io/)
- [Scaffold-Stark Docs](https://docs.scaffoldstark.com/)

---

**Última actualización:** Octubre 2025
**Versión:** 1.0.0

