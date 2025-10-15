# 🎨 Instrucciones de Minteo - QuestlyNFTStandard en Starknet Mainnet

## 📌 Información del Contrato

**Nombre del Contrato:** QuestlyNFTStandard (Questly Platinums)  
**Símbolo:** QEST  
**Red:** Starknet Mainnet  
**Dirección del Contrato:** `0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa`  
**Verificado:** ✅ Sí  
**Estándar:** ERC721 completo con OpenZeppelin  
**Starkscan:** [Ver contrato](https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa)  
**Voyager:** [Ver contrato](https://voyager.online/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa)

---

## 🎯 Propósito del Frontend

Este frontend permite mintear NFTs del contrato **QuestlyNFTStandard** desplegado en **Starknet Mainnet** de forma sencilla, utilizando tu wallet **Braavos**.

### Características del Contrato:
- ✅ **Implementa ERC721 estándar completo** con OpenZeppelin
- ✅ **Compatible con todos los exploradores** (Starkscan, Voyager)
- ✅ **Detectado automáticamente** como contrato NFT
- ✅ Soporta metadata individuales por token mediante IPFS
- ✅ Cualquier wallet puede mintear NFTs
- ✅ **Componentes:** ERC721Component + SRC5Component + OwnableComponent + CounterComponent + ERC721EnumerableComponent
- ✅ **Funciones estándar:** tokenURI, ownerOf, balanceOf, totalSupply, etc.
- ✅ **Eventos estándar:** Transfer, Approval, ApprovalForAll
- ✅ Función principal: `mint_item(recipient, uri)`

---

## 🚀 Iniciar el Frontend

### 1. Instalar dependencias (solo la primera vez)
```bash
cd /home/user/testing/realNFT/packages/nextjs
yarn install
```

### 2. Iniciar el servidor de desarrollo
```bash
cd /home/user/testing/realNFT/packages/nextjs
yarn dev
```

### 3. Acceder al frontend
- **URL principal:** http://localhost:3000
- **Página de minteo directo:** http://localhost:3000/mint

---

## 📝 Cómo Mintear un NFT

### Paso 1: Conectar Wallet Braavos

1. Abre http://localhost:3000/mint
2. Haz clic en **"Connect Wallet"** (esquina superior derecha)
3. Selecciona **Braavos** de la lista de wallets
4. Autoriza la conexión en tu extensión de Braavos
5. ⚠️ **IMPORTANTE:** Verifica que estés en **Starknet Mainnet** (no Sepolia)

### Paso 2: Completar el Formulario de Minteo

El formulario tiene 2 campos obligatorios:

#### 🎯 Campo 1: Dirección del Destinatario
- **Descripción:** La wallet que recibirá el NFT
- **Formato requerido:** `0x...` (dirección hexadecimal de Starknet)
- **Validación:** El campo valida automáticamente la dirección
- **Ejemplo:** `0x034aA3F359A9D614239015126635CE7732c18fDF3`

#### 📦 Campo 2: URI de IPFS
- **Descripción:** URI completa del archivo de metadata del NFT
- **Formatos aceptados:**
  - `ipfs://QmXxx...` (formato canónico recomendado)
  - `https://ipfs.io/ipfs/QmXxx...` (gateway HTTP)
- **Ejemplo:** `ipfs://QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG`

**Estructura del metadata recomendada (JSON):**
```json
{
  "name": "Questly Platinum #1",
  "description": "NFT exclusivo de la colección Questly Platinums",
  "image": "ipfs://QmXxx.../imagen.png",
  "attributes": [
    {
      "trait_type": "Rarity",
      "value": "Platinum"
    },
    {
      "trait_type": "Level",
      "value": "1"
    }
  ]
}
```

### Paso 3: Mintear

1. Haz clic en el botón **"✨ Mintear NFT"**
2. Se abrirá una ventana de Braavos con los detalles de la transacción
3. **Revisa los detalles:**
   - Contrato: `0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080`
   - Función: `mint_item`
   - Destinatario: La dirección que ingresaste
   - URI: La URI que ingresaste
4. Confirma la transacción en Braavos
5. Espera la confirmación (aparecerá una notificación de éxito)
6. Los campos se limpiarán automáticamente después del minteo exitoso

### Paso 4: Verificar el NFT

Una vez minteado, puedes verificar:

**En Exploradores:**
- [Starkscan](https://starkscan.co/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080) - Ver transacciones del contrato
- [Voyager](https://voyager.online/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080) - Ver detalles del contrato

**En tu Wallet:**
- Abre Braavos
- Ve a la sección de **NFTs** o **Collectibles**
- Busca "Questly Platinums" o "QEST"

---

## 🛡️ Validaciones y Seguridad

### Validaciones Automáticas

El frontend incluye las siguientes validaciones:

✅ **Wallet conectada:** Verifica que tengas Braavos conectado  
✅ **Dirección válida:** Valida que la dirección comience con `0x` y tenga longitud correcta  
✅ **URI no vacía:** Verifica que hayas ingresado una URI  
✅ **Red correcta:** Solo permite transacciones en Mainnet  

### Seguridad

- 🔒 El contrato es **verificado** en Starkscan
- 🔒 Todas las transacciones requieren **confirmación en Braavos**
- 🔒 El frontend **no guarda** tus claves privadas
- 🔒 Solo interactúa con el contrato en **Mainnet**
- ⚠️ **Siempre revisa** los detalles de la transacción antes de confirmar

---

## 💰 Costos de Gas

### Estimaciones

- **Función:** `mint_item(recipient, uri)`
- **Costo aproximado:** Variable según congestión de la red
- **Token de pago:** STRK o ETH (según configuración de Braavos)

### Requisitos

⚠️ **Asegúrate de tener fondos suficientes en tu wallet Braavos:**
- STRK para gas (recomendado en Mainnet)
- O ETH para gas (alternativa)

---

## 🧩 Componentes Técnicos del Frontend

### Archivos Principales

| Archivo | Descripción |
|---------|-------------|
| `packages/nextjs/app/mint/page.tsx` | Página principal de minteo con formulario |
| `packages/nextjs/contracts/externalContracts.ts` | Configuración del contrato QuestlyNFT en mainnet |
| `packages/nextjs/components/Header.tsx` | Menú de navegación con enlace "Mint NFT" |
| `packages/nextjs/scaffold.config.ts` | Configuración de red (Mainnet) |

### Hooks Utilizados

```typescript
// Hook de conexión de wallet
const { address: connectedAddress, isConnected } = useAccount();

// Hook para escribir al contrato
const { sendAsync: mintNFT } = useScaffoldWriteContract({
  contractName: "QuestlyNFT",
  functionName: "mint_item",
  args: [recipientAddress, ipfsUri],
});
```

### Componentes de Scaffold-Stark 2

- **`AddressInput`**: Input especializado para direcciones de Starknet con validación
- **`useScaffoldWriteContract`**: Hook para escribir al contrato de forma simple
- **`CustomConnectButton`**: Botón de conexión de wallet
- **`notification`**: Sistema de notificaciones para feedback al usuario

---

## 🎨 Interfaz de Usuario

### Pantalla Principal

```
┌─────────────────────────────────────────────┐
│        Mintear Questly NFT                   │
│        en Starknet Mainnet 🚀                │
├─────────────────────────────────────────────┤
│                                              │
│  ℹ️  Contrato QuestlyNFT                    │
│     0x2cf4e33c...ca7b0080                   │
│                                              │
│  📍 Dirección del destinatario              │
│  [___0x..._____________________________]    │
│     La wallet que recibirá el NFT           │
│                                              │
│  📦 URI de IPFS                             │
│  [___ipfs://Qm...__________________]        │
│     La URI completa del metadata en IPFS    │
│                                              │
│  [        ✨ Mintear NFT        ]            │
│                                              │
│  Conectado con: 0x034a...fDF3               │
└─────────────────────────────────────────────┘
```

### Estados Visuales

| Estado | Apariencia | Acción |
|--------|-----------|---------|
| **Sin conectar** | Alerta amarilla | Muestra mensaje para conectar wallet |
| **Conectado** | Formulario activo | Permite ingresar datos |
| **Minteando** | Botón con spinner | Deshabilitado durante minteo |
| **Éxito** | Notificación verde | Muestra mensaje de éxito |
| **Error** | Notificación roja | Muestra mensaje de error |

---

## ⚠️ Solución de Problemas

### Problema 1: "Por favor conecta tu wallet Braavos primero"

**Causa:** La wallet no está conectada

**Solución:**
1. Haz clic en "Connect Wallet" en la esquina superior derecha
2. Selecciona Braavos de la lista
3. Autoriza la conexión en la extensión
4. Verifica que estés en Mainnet (no Sepolia)

---

### Problema 2: "Dirección de wallet inválida"

**Causa:** La dirección no tiene el formato correcto

**Solución:**
- ✅ Verifica que comience con `0x`
- ✅ Copia la dirección completa (sin espacios)
- ✅ No uses nombres ENS, solo direcciones hexadecimales
- ✅ Ejemplo válido: `0x034aA3F359A9D614239015126635CE7732c18fDF3`

---

### Problema 3: "La URI de IPFS no puede estar vacía"

**Causa:** El campo de URI está vacío

**Solución:**
- ✅ Pega la URI completa del metadata
- ✅ Verifica que no haya espacios al inicio o final
- ✅ Formato: `ipfs://QmXxx...` o `https://ipfs.io/ipfs/QmXxx...`

---

### Problema 4: Error "Insufficient funds" o fondos insuficientes

**Causa:** No tienes suficiente STRK/ETH para pagar el gas

**Solución:**
1. Verifica tu balance en Braavos
2. Transfiere STRK o ETH a tu wallet
3. Intenta mintear nuevamente

---

### Problema 5: La transacción tarda mucho

**Causa:** Red congestionada o RPC lento

**Solución:**
1. Espera pacientemente (puede tardar hasta 5-10 minutos)
2. Verifica el estado en Starkscan con tu dirección
3. No cierres la ventana del navegador
4. Si tarda más de 15 minutos, verifica el estado de Starknet: https://status.starknet.io

---

### Problema 6: El NFT no aparece en mi wallet

**Causa:** Puede tardar en indexarse

**Solución:**
1. Espera unos minutos y refresca tu wallet
2. Verifica en Starkscan que la transacción fue exitosa
3. Busca manualmente el contrato en Braavos:
   - Ve a "Add Token" o "Add NFT"
   - Pega la dirección: `0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080`

---

## 📊 Funciones del Contrato QuestlyNFT

### Función Principal: `mint_item`

```cairo
fn mint_item(ref self: T, recipient: ContractAddress, uri: ByteArray) -> u256;
```

**Parámetros:**
- `recipient`: Dirección de la wallet destino (ContractAddress)
- `uri`: URI del metadata en formato ByteArray

**Retorna:**
- `u256`: ID del token minteado

**Ejemplo de llamada:**
```typescript
await mintNFT({
  args: [
    "0x034aA3F359A9D614239015126635CE7732c18fDF3", // recipient
    "ipfs://QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG" // uri
  ]
});
```

### Otras Funciones Disponibles

| Función | Descripción | Tipo |
|---------|-------------|------|
| `name()` | Retorna "Questly Platinums" | View |
| `symbol()` | Retorna "QEST" | View |
| `token_uri(token_id)` | Obtiene la URI de un token | View |
| `owner_of(token_id)` | Obtiene el dueño de un token | View |
| `balance_of(account)` | Obtiene cantidad de NFTs de una dirección | View |
| `total_supply()` | Obtiene el total de NFTs minteados | View |
| `owner()` | Obtiene el dueño del contrato | View |

---

## 🔗 Enlaces Útiles

### Exploradores
- **Starkscan:** https://starkscan.co/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080
- **Voyager:** https://voyager.online/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080

### Documentación
- **Scaffold-Stark 2:** https://www.scaffoldstark.com
- **Starknet Docs:** https://docs.starknet.io
- **OpenZeppelin Cairo:** https://docs.openzeppelin.com/contracts-cairo
- **IPFS Docs:** https://docs.ipfs.tech

### Herramientas
- **Braavos Wallet:** https://braavos.app
- **IPFS Gateway:** https://ipfs.io
- **Starknet Status:** https://status.starknet.io

---

## 📄 Archivos de Referencia

Para más información técnica, consulta:

- **`REACT_NATIVE_QUESTLY_NFT.md`** - Integración completa de React Native con el contrato
- **`MINT_FRONTEND_GUIDE.md`** - Guía detallada del frontend
- **`packages/snfoundry/contracts/src/your_collectible.cairo`** - Código fuente del contrato

---

## 🎉 ¡Listo para Mintear!

Ya tienes toda la información necesaria para mintear NFTs en el contrato **QuestlyNFT** desplegado en **Starknet Mainnet**.

### Pasos rápidos:
1. ✅ Inicia el servidor: `yarn start`
2. ✅ Abre: http://localhost:3000/mint
3. ✅ Conecta Braavos (Mainnet)
4. ✅ Completa el formulario
5. ✅ Mintea tu NFT

**¡Disfruta creando tus Questly Platinums! 🚀✨**

---

## 📝 Notas Finales

- Este frontend está configurado **específicamente para el contrato QuestlyNFT en Mainnet**
- La dirección del contrato está hardcodeada en `externalContracts.ts`
- No se requiere desplegar contratos localmente
- Solo necesitas tener Braavos conectado a Mainnet
- Todas las transacciones son reales y tienen costo de gas

**Fecha de creación:** Octubre 2025  
**Versión:** 1.0  
**Última actualización:** Octubre 2025

