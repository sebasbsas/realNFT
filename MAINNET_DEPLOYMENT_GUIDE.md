# Guía de Configuración para Despliegue en Mainnet

## 📋 Tabla de Contenidos

1. [Constantes Hardcodeadas](#constantes-hardcodeadas)
2. [Configuración de Variables de Entorno](#configuración-de-variables-de-entorno)
3. [Configuración del Frontend](#configuración-del-frontend)
4. [Direcciones de Contratos según la Red](#direcciones-de-contratos-según-la-red)
5. [Proceso de Despliegue a Mainnet](#proceso-de-despliegue-a-mainnet)
6. [Checklist de Verificación](#checklist-de-verificación)
7. [Problemas Comunes](#problemas-comunes)

---

## 🔐 Constantes Hardcodeadas

### FELT_STRK_CONTRACT

**Ubicación:** `packages/snfoundry/contracts/src/your_contract.cairo`

```cairo
pub const FELT_STRK_CONTRACT: felt252 =
    0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d;
```

#### ¿Qué es esta constante?

Esta constante representa **la dirección del contrato del token STRK** (Starknet Token) en la blockchain de Starknet. Es el token nativo de Starknet utilizado para:

- Pagar gas fees (tarifas de transacción)
- Staking y gobernanza
- Interacciones económicas dentro del ecosistema

#### ¿Por qué está hardcodeada?

Está hardcodeada porque **la dirección del token STRK es la misma en todas las redes de Starknet**:
- ✅ **Mainnet:** `0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d`
- ✅ **Sepolia:** `0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d`
- ✅ **Devnet:** `0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d`

#### ¿Dónde se usa en el código?

La constante se utiliza en dos funciones principales:

1. **`set_greeting()`** - Para transferir tokens STRK como "premium":
```cairo
let strk_contract_address: ContractAddress = FELT_STRK_CONTRACT.try_into().unwrap();
let strk_dispatcher = IERC20Dispatcher { contract_address: strk_contract_address };
strk_dispatcher.transfer_from(get_caller_address(), get_contract_address(), amount_strk);
```

2. **`withdraw()`** - Para retirar los tokens STRK acumulados:
```cairo
let strk_contract_address = FELT_STRK_CONTRACT.try_into().unwrap();
let strk_dispatcher = IERC20Dispatcher { contract_address: strk_contract_address };
let balance = strk_dispatcher.balance_of(get_contract_address());
strk_dispatcher.transfer(self.ownable.owner(), balance);
```

#### 🚨 ¿Necesito cambiar esta constante para mainnet?

**NO**, esta dirección es la misma para todas las redes. No necesitas modificarla.

---

## 🔧 Configuración de Variables de Entorno

### 1. Variables de Entorno para Despliegue (Backend)

**Archivo:** `packages/snfoundry/.env`

Necesitas crear este archivo con el siguiente contenido:

```bash
# ============================================
# DEVNET CONFIGURATION
# ============================================
ACCOUNT_ADDRESS_DEVNET=0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691
PRIVATE_KEY_DEVNET=0x71d7bb07b9a64f6f78ac4c816aff4da9
RPC_URL_DEVNET=http://127.0.0.1:5050

# ============================================
# SEPOLIA TESTNET CONFIGURATION
# ============================================
ACCOUNT_ADDRESS_SEPOLIA=0xTU_DIRECCION_SEPOLIA_AQUI
PRIVATE_KEY_SEPOLIA=0xTU_CLAVE_PRIVADA_SEPOLIA_AQUI
RPC_URL_SEPOLIA=https://starknet-sepolia.public.blastapi.io/rpc/v0_9

# ============================================
# MAINNET CONFIGURATION
# ============================================
ACCOUNT_ADDRESS_MAINNET=0xTU_DIRECCION_MAINNET_AQUI
PRIVATE_KEY_MAINNET=0xTU_CLAVE_PRIVADA_MAINNET_AQUI
RPC_URL_MAINNET=https://starknet-mainnet.public.blastapi.io/rpc/v0_9
```

#### 🔑 Cómo obtener tu dirección y clave privada:

##### Opción 1: Argent X Wallet
1. Abre tu extensión de Argent X
2. Selecciona tu cuenta
3. Click en "Settings" → "Account Details"
4. Copia la dirección (Address)
5. Click en "Export Private Key" (necesitarás tu contraseña)
6. ⚠️ **NUNCA COMPARTAS TU CLAVE PRIVADA**

##### Opción 2: Braavos Wallet
1. Abre tu extensión de Braavos
2. Click en tu cuenta
3. "Settings" → "Privacy & Security"
4. "Export Private Key"
5. Copia tu dirección y clave privada

##### Opción 3: CLI con Starkli
```bash
# Crear una nueva cuenta
starkli account oz init /path/to/account.json

# Ver la dirección
starkli account fetch /path/to/account.json

# La clave privada estará en el archivo keystore
```

### 2. Variables de Entorno para Frontend

**Archivo:** `packages/nextjs/.env`

```bash
# ============================================
# RPC PROVIDER URLS FOR FRONTEND
# ============================================

# Devnet - Red local de desarrollo
NEXT_PUBLIC_DEVNET_PROVIDER_URL=http://127.0.0.1:5050

# Sepolia Testnet - Red de pruebas
NEXT_PUBLIC_SEPOLIA_PROVIDER_URL=https://starknet-sepolia.public.blastapi.io/rpc/v0_9

# Mainnet - Red principal de producción
NEXT_PUBLIC_MAINNET_PROVIDER_URL=https://starknet-mainnet.public.blastapi.io/rpc/v0_9

# ============================================
# OPTIONAL: Custom RPC Providers
# ============================================
# Para producción, es recomendable usar tu propio RPC provider
# Opciones populares:
# - Blast API: https://blastapi.io/
# - Alchemy: https://www.alchemy.com/starknet
# - Infura: https://www.infura.io/networks/ethereum/starknet

# Ejemplo con Alchemy:
# NEXT_PUBLIC_MAINNET_PROVIDER_URL=https://starknet-mainnet.g.alchemy.com/v2/TU_API_KEY

# Ejemplo con Blast API:
# NEXT_PUBLIC_MAINNET_PROVIDER_URL=https://starknet-mainnet.blastapi.io/TU_API_KEY/rpc/v0_9
```

#### 🌐 Proveedores RPC Recomendados

Para aplicaciones en producción, usa servicios RPC profesionales:

| Proveedor | Tier Gratuito | URL | Notas |
|-----------|--------------|-----|-------|
| **Blast API** | ✅ Sí | [blastapi.io](https://blastapi.io/) | Gratuito hasta 40 req/s |
| **Alchemy** | ✅ Sí | [alchemy.com](https://www.alchemy.com/starknet) | 300M unidades/mes gratis |
| **Infura** | ✅ Sí | [infura.io](https://www.infura.io/) | 100K req/día gratis |
| **RPC Público** | ✅ Sí | `public.blastapi.io` | Rate-limited, no para producción |

---

## 🎨 Configuración del Frontend

### 1. Configurar la Red Objetivo

**Archivo:** `packages/nextjs/scaffold.config.ts`

#### Para Devnet (desarrollo local):
```typescript
const scaffoldConfig = {
  targetNetworks: [chains.devnet],
  onlyLocalBurnerWallet: true,
  pollingInterval: 30_000,
  autoConnectTTL: 60000,
  walletAutoConnect: true,
} as const satisfies ScaffoldConfig;
```

#### Para Sepolia (testnet):
```typescript
const scaffoldConfig = {
  targetNetworks: [chains.sepolia],
  onlyLocalBurnerWallet: false, // Desactivar burner wallet en testnet
  pollingInterval: 30_000,
  autoConnectTTL: 60000,
  walletAutoConnect: true,
} as const satisfies ScaffoldConfig;
```

#### Para Mainnet (producción):
```typescript
const scaffoldConfig = {
  targetNetworks: [chains.mainnet],
  onlyLocalBurnerWallet: false, // Desactivar burner wallet en mainnet
  pollingInterval: 30_000,
  autoConnectTTL: 60000,
  walletAutoConnect: true,
} as const satisfies ScaffoldConfig;
```

#### Configuración Multi-Red:
```typescript
const scaffoldConfig = {
  targetNetworks: [chains.mainnet, chains.sepolia], // Permitir ambas redes
  onlyLocalBurnerWallet: false,
  pollingInterval: 30_000,
  autoConnectTTL: 60000,
  walletAutoConnect: true,
} as const satisfies ScaffoldConfig;
```

### 2. Verificar Configuración de Redes

**Archivo:** `packages/nextjs/supportedChains.ts`

Este archivo define las cadenas soportadas. Verifica que las URLs de RPC estén correctamente configuradas:

```typescript
import * as chains from "@starknet-react/chains";

const rpcUrlDevnet = process.env.NEXT_PUBLIC_DEVNET_PROVIDER_URL || "http://127.0.0.1:5050";
const rpcUrlSepolia = process.env.NEXT_PUBLIC_SEPOLIA_PROVIDER_URL;
const rpcUrlMainnet = process.env.NEXT_PUBLIC_MAINNET_PROVIDER_URL;

// Las cadenas de @starknet-react/chains ya están configuradas
// Solo necesitas asegurarte de que las variables de entorno estén definidas
export const supportedChains = { ...chains };
```

---

## 📍 Direcciones de Contratos según la Red

### Token STRK (Starknet Token)

| Red | Dirección | Uso |
|-----|-----------|-----|
| **Mainnet** | `0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d` | Token STRK real |
| **Sepolia** | `0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d` | Token STRK de testnet |
| **Devnet** | `0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d` | Token STRK de devnet |

### Token ETH (Ethereum en Starknet)

| Red | Dirección |
|-----|-----------|
| **Mainnet** | `0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7` |
| **Sepolia** | `0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7` |
| **Devnet** | `0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7` |

### Ubicación en el Código

**Backend:** `packages/snfoundry/scripts-ts/helpers/networks.ts`

```typescript
const STRK_TOKEN_ADDRESS_DEVNET = "0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d";
const STRK_TOKEN_ADDRESS = "0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d";

const feeTokenOptions = {
  devnet: [{ name: "strk", address: STRK_TOKEN_ADDRESS_DEVNET }],
  mainnet: [{ name: "strk", address: STRK_TOKEN_ADDRESS }],
  sepolia: [{ name: "strk", address: STRK_TOKEN_ADDRESS }],
};
```

---

## 🚀 Proceso de Despliegue a Mainnet

### Paso 1: Preparar tu Billetera

1. **Asegúrate de tener fondos suficientes en Mainnet:**
   - Necesitarás STRK para gas fees
   - Aproximadamente 0.1-0.5 STRK para el despliegue
   - Puedes comprar STRK en exchanges o bridges

2. **Verifica que tu billetera esté en Mainnet:**
   - Argent X: Cambia a "Mainnet" en la parte superior
   - Braavos: Selecciona "Starknet Mainnet"

### Paso 2: Configurar Variables de Entorno

1. **Crear `.env` en `packages/snfoundry/`:**
```bash
cd packages/snfoundry
nano .env  # o usa tu editor favorito
```

2. **Agregar tus credenciales de mainnet:**
```bash
ACCOUNT_ADDRESS_MAINNET=0xTU_DIRECCION
PRIVATE_KEY_MAINNET=0xTU_CLAVE_PRIVADA
RPC_URL_MAINNET=https://starknet-mainnet.public.blastapi.io/rpc/v0_9
```

3. **Crear `.env` en `packages/nextjs/`:**
```bash
cd packages/nextjs
nano .env
```

4. **Agregar URLs de RPC:**
```bash
NEXT_PUBLIC_MAINNET_PROVIDER_URL=https://starknet-mainnet.public.blastapi.io/rpc/v0_9
```

### Paso 3: Modificar el Script de Despliegue

**Archivo:** `packages/snfoundry/scripts-ts/deploy.ts`

⚠️ **IMPORTANTE:** Cambia la dirección del owner hardcodeada:

```typescript
const deployScript = async (): Promise<void> => {
  await deployContract({
    contract: "YourCollectible",
    constructorArgs: {
      owner: "0xTU_DIRECCION_DE_MAINNET_AQUI", // ⚠️ CAMBIAR ESTO
    },
  });
};
```

O mejor aún, usa la dirección del deployer automáticamente:

```typescript
const deployScript = async (): Promise<void> => {
  await deployContract({
    contract: "YourCollectible",
    constructorArgs: {
      owner: deployer.address, // Usa la dirección del deployer automáticamente
    },
  });
};
```

### Paso 4: Compilar los Contratos

```bash
cd packages/snfoundry
scarb build
```

Verifica que la compilación sea exitosa sin errores.

### Paso 5: Desplegar a Mainnet

```bash
yarn deploy --network mainnet
```

#### Salida Esperada:

```
✅ Network is active and reachable
✅ Deployer account is signable
📦 Deploying YourCollectible...
✅ YourCollectible deployed at: 0x[dirección_del_contrato]
📝 Deployment details saved to deployments/mainnet.json
🎉 All Setup Done!
```

### Paso 6: Verificar el Contrato (Opcional pero Recomendado)

```bash
yarn verify --network mainnet
```

Esto publicará el código fuente en block explorers como:
- Voyager: https://voyager.online
- Starkscan: https://starkscan.co
- StarkCompass: https://starkcompass.com

### Paso 7: Actualizar el Frontend

1. **Cambiar la red en `scaffold.config.ts`:**
```typescript
targetNetworks: [chains.mainnet],
```

2. **Verificar que `deployedContracts.ts` se actualizó:**

El archivo `packages/nextjs/contracts/deployedContracts.ts` debe contener las direcciones de mainnet:

```typescript
const deployedContracts = {
  "0x534e5f4d41494e": { // Mainnet chain ID
    YourCollectible: {
      address: "0x[tu_direccion_del_contrato]",
      abi: [...],
    },
  },
} as const;
```

3. **Iniciar el frontend:**
```bash
cd packages/nextjs
yarn start
```

4. **Conectar tu wallet en mainnet y probar la aplicación**

---

## ✅ Checklist de Verificación

### Antes del Despliegue

- [ ] ✅ Tengo fondos suficientes en Mainnet (mínimo 0.1 STRK)
- [ ] ✅ He creado el archivo `.env` en `packages/snfoundry/`
- [ ] ✅ He agregado `ACCOUNT_ADDRESS_MAINNET` correctamente
- [ ] ✅ He agregado `PRIVATE_KEY_MAINNET` correctamente
- [ ] ✅ He agregado `RPC_URL_MAINNET` correctamente
- [ ] ✅ He creado el archivo `.env` en `packages/nextjs/`
- [ ] ✅ He agregado `NEXT_PUBLIC_MAINNET_PROVIDER_URL`
- [ ] ✅ He cambiado la dirección del owner en `deploy.ts`
- [ ] ✅ La compilación con `scarb build` es exitosa
- [ ] ✅ No he compartido mi clave privada con nadie

### Durante el Despliegue

- [ ] ✅ El comando `yarn deploy --network mainnet` ejecuta sin errores
- [ ] ✅ Recibí una dirección del contrato desplegado
- [ ] ✅ El archivo `deployments/mainnet.json` fue creado
- [ ] ✅ Puedo ver la transacción en un block explorer

### Después del Despliegue

- [ ] ✅ He actualizado `scaffold.config.ts` con `chains.mainnet`
- [ ] ✅ El archivo `deployedContracts.ts` tiene la dirección correcta
- [ ] ✅ El frontend se conecta correctamente a mainnet
- [ ] ✅ Puedo interactuar con el contrato desde el frontend
- [ ] ✅ He verificado el contrato (opcional)
- [ ] ✅ He probado todas las funciones principales

---

## ⚠️ Problemas Comunes

### Error: "Account not found"

**Causa:** La dirección de la cuenta no existe en mainnet o no está desplegada.

**Solución:**
1. Verifica que copiaste la dirección correcta de tu wallet
2. Asegúrate de que tu cuenta esté desplegada en mainnet
3. Verifica que tienes fondos en la cuenta

### Error: "Insufficient balance for transaction"

**Causa:** No tienes suficiente STRK para pagar el gas.

**Solución:**
1. Transfiere STRK a tu cuenta de mainnet
2. Puedes comprar STRK en exchanges como:
   - Binance
   - Coinbase
   - OKX
3. O usa bridges como:
   - Orbiter Finance
   - Layerswap

### Error: "RPC provider not responding"

**Causa:** El RPC URL no es válido o el servicio está caído.

**Solución:**
1. Verifica que `RPC_URL_MAINNET` esté correctamente escrito
2. Prueba con otro proveedor RPC
3. Usa un servicio RPC premium (Alchemy, Blast API)

### Error: "Private key format invalid"

**Causa:** La clave privada no tiene el formato correcto.

**Solución:**
1. Asegúrate de que la clave empiece con `0x`
2. Debe ser un string hexadecimal válido
3. No incluyas espacios ni caracteres especiales

### Error: "Contract deployment failed"

**Causa:** Múltiples razones posibles.

**Solución:**
1. Verifica que el contrato compile sin errores: `scarb build`
2. Revisa los logs de error para más detalles
3. Verifica que los argumentos del constructor sean correctos
4. Asegúrate de que no haya conflictos con contratos previamente desplegados

### El frontend no muestra el contrato desplegado

**Causa:** `deployedContracts.ts` no se actualizó correctamente.

**Solución:**
1. Verifica que el archivo `deployments/mainnet_latest.json` existe
2. Reinicia el servidor de desarrollo: `yarn start`
3. Limpia la caché: `yarn clean` y vuelve a compilar
4. Verifica que `scaffold.config.ts` tenga la red correcta

---

## 🔒 Seguridad

### ⚠️ NUNCA COMPARTAS:

- ❌ Tu clave privada (`PRIVATE_KEY_MAINNET`)
- ❌ Tu archivo `.env`
- ❌ Tu seed phrase / frase de recuperación

### ✅ Mejores Prácticas:

1. **Agrega `.env` al `.gitignore`:**
```bash
echo ".env" >> .gitignore
```

2. **Usa variables de entorno en producción:**
   - En Vercel: Settings → Environment Variables
   - En Netlify: Site settings → Environment variables

3. **Usa cuentas diferentes para desarrollo y producción**

4. **Audita tu código antes de desplegar a mainnet:**
   - Revisa todas las funciones públicas
   - Verifica permisos y roles
   - Considera una auditoría profesional para contratos con fondos

5. **Usa hardware wallets para grandes cantidades:**
   - Ledger compatible con Starknet
   - Mayor seguridad para activos valiosos

---

## 📚 Referencias

### Documentación Oficial

- [Starknet Documentation](https://docs.starknet.io/)
- [Cairo Book](https://book.cairo-lang.org/)
- [Starknet.js Documentation](https://www.starknetjs.com/)
- [Scaffold-Stark Documentation](https://docs.scaffoldstark.com/)

### Block Explorers

- [Voyager](https://voyager.online/) - Block explorer principal
- [Starkscan](https://starkscan.co/) - Información detallada de contratos
- [StarkCompass](https://starkcompass.com/) - Explorador alternativo

### RPC Providers

- [Blast API](https://blastapi.io/)
- [Alchemy](https://www.alchemy.com/starknet)
- [Infura](https://www.infura.io/networks/ethereum/starknet)

### Wallets Compatibles

- [Argent X](https://www.argent.xyz/argent-x/)
- [Braavos](https://braavos.app/)

---

## 🆘 Soporte

Si tienes problemas durante el despliegue:

1. Revisa los logs completos del error
2. Busca en la [documentación oficial](https://docs.starknet.io/)
3. Pregunta en [Discord de Starknet](https://discord.gg/starknet)
4. Revisa [GitHub Issues de Scaffold-Stark](https://github.com/Scaffold-Stark/scaffold-stark-2/issues)

---

**Última actualización:** Octubre 2025
**Versión:** 1.0.0

