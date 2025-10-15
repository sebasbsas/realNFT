# 🎨 Instrucciones de Minteo - QuestlyNFTStandard en Starknet Mainnet

## 📌 Información del Contrato

**Nombre del Contrato:** QuestlyNFTStandard  
**Tipo:** ERC721 Estándar (OpenZeppelin)  
**Red:** Starknet Mainnet  
**Dirección del Contrato:** `0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa`  
**Verificado:** ✅ Sí  
**Starkscan:** [Ver contrato](https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa)  
**Voyager:** [Ver contrato](https://voyager.online/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa)

---

## 🎯 Propósito del Frontend

Este frontend permite mintear NFTs del contrato **QuestlyNFTStandard** (ERC721 estándar) desplegado en **Starknet Mainnet** de forma simple, utilizando tu wallet **Braavos**.

### Características del Contrato:
- ✅ Implementación completa del estándar ERC721
- ✅ Basado en OpenZeppelin Cairo
- ✅ Compatible con todos los wallets y exploradores
- ✅ **NO requiere metadata personalizada**
- ✅ Minteo simple con solo dirección del destinatario
- ✅ Componentes: ERC721 + Ownable + Counter + SRC5 + Enumerable
- ✅ Función principal: `mint_item(recipient)`

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
- **Página de minteo estándar:** http://localhost:3000/mint-standard

---

## 📝 Cómo Mintear un NFT Estándar

### Paso 1: Conectar Wallet Braavos

1. Abre http://localhost:3000/mint-standard
2. Haz clic en **"Connect Wallet"** (esquina superior derecha)
3. Selecciona **Braavos** de la lista de wallets
4. Autoriza la conexión en tu extensión de Braavos
5. ⚠️ **IMPORTANTE:** Verifica que estés en **Starknet Mainnet** (no Sepolia)

### Paso 2: Completar el Formulario de Minteo

El formulario tiene **1 campo obligatorio** (más simple que QuestlyNFT):

#### 🎯 Campo: Dirección del Destinatario
- **Descripción:** La wallet que recibirá el NFT estándar
- **Formato requerido:** `0x...` (dirección hexadecimal de Starknet)
- **Validación:** El campo valida automáticamente la dirección
- **Ejemplo:** `0x034aA3F359A9D614239015126635CE7732c18fDF3`

**⚠️ NO SE REQUIERE:**
- ❌ URI de IPFS (el contrato no la necesita)
- ❌ Metadata personalizada
- ❌ Configuración adicional

### Paso 3: Mintear

1. Haz clic en el botón **"✨ Mintear NFT Estándar"**
2. Se abrirá una ventana de Braavos con los detalles de la transacción
3. **Revisa los detalles:**
   - Contrato: `0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa`
   - Función: `mint_item`
   - Destinatario: La dirección que ingresaste
4. Confirma la transacción en Braavos
5. Espera la confirmación (aparecerá una notificación de éxito)
6. El campo se limpiará automáticamente después del minteo exitoso

### Paso 4: Verificar el NFT

Una vez minteado, puedes verificar:

**En Exploradores:**
- [Starkscan](https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa) - Ver transacciones del contrato
- [Voyager](https://voyager.online/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa) - Ver detalles del contrato

**En tu Wallet:**
- Abre Braavos
- Ve a la sección de **NFTs** o **Collectibles**
- Busca "QuestlyNFTStandard" o el símbolo del contrato

---

## 🔄 Diferencias entre QuestlyNFT y QuestlyNFTStandard

### QuestlyNFT (Personalizado)
```
✅ Metadata IPFS personalizada
✅ URI individual por token
✅ Más flexible para proyectos complejos
⚠️ Requiere subir metadata a IPFS
⚠️ Configuración adicional necesaria
```

### QuestlyNFTStandard (Estándar)
```
✅ ERC721 estándar completo
✅ Sin configuración adicional
✅ Compatible con todos los wallets
✅ Minteo más simple y rápido
✅ Menos gas por transacción
❌ Sin metadata personalizada
❌ Sin URIs individuales
```

---

## 🛡️ Validaciones y Seguridad

### Validaciones Automáticas

El frontend incluye las siguientes validaciones:

✅ **Wallet conectada:** Verifica que tengas Braavos conectado  
✅ **Dirección válida:** Valida que la dirección comience con `0x` y tenga longitud correcta  
✅ **Campo no vacío:** Verifica que hayas ingresado una dirección  
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

- **Función:** `mint_item(recipient)`
- **Costo aproximado:** Menor que QuestlyNFT (sin metadata)
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
| `packages/nextjs/app/mint-standard/page.tsx` | Página de minteo estándar |
| `packages/nextjs/contracts/deployedContracts.ts` | Configuración del contrato QuestlyNFTStandard |
| `packages/nextjs/components/Header.tsx` | Menú con enlace "Mint Standard" |

### Hooks Utilizados

```typescript
// Hook de conexión de wallet
const { address: connectedAddress, isConnected } = useAccount();

// Hook para escribir al contrato (solo recipient)
const { sendAsync: mintNFT } = useScaffoldWriteContract({
  contractName: "QuestlyNFTStandard",
  functionName: "mint_item",
  args: [recipientAddress], // Solo recipient, sin URI
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
│        Mintear NFT Estándar                  │
│        QuestlyNFTStandard 🚀                │
├─────────────────────────────────────────────┤
│                                              │
│  ℹ️  Contrato QuestlyNFTStandard            │
│     0x434c8fef...4ef4aa                     │
│     ERC721 estándar - Sin metadata           │
│                                              │
│  📍 Dirección del destinatario              │
│  [___0x..._____________________________]    │
│     La wallet que recibirá el NFT estándar   │
│                                              │
│  [        ✨ Mintear NFT Estándar    ]        │
│                                              │
│  Conectado con: 0x034a...fDF3               │
└─────────────────────────────────────────────┘
```

### Estados Visuales

| Estado | Apariencia | Acción |
|--------|-----------|---------|
| **Sin conectar** | Alerta amarilla | Muestra mensaje para conectar wallet |
| **Conectado** | Formulario activo | Permite ingresar dirección |
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

### Problema 3: "Por favor ingresa la dirección del destinatario"

**Causa:** El campo de dirección está vacío

**Solución:**
- ✅ Ingresa una dirección válida de Starknet
- ✅ Verifica que no haya espacios al inicio o final

---

### Problema 4: Error durante la transacción

**Posibles causas:**
- Fondos insuficientes para el gas
- Red congestionada
- Problema con el RPC

**Solución:**
1. Verifica tu balance de STRK/ETH
2. Espera unos minutos e intenta nuevamente
3. Si persiste, revisa el estado de Starknet en https://status.starknet.io

---

## 📊 Funciones del Contrato QuestlyNFTStandard

### Función Principal: `mint_item`

```cairo
fn mint_item(ref self: T, recipient: ContractAddress) -> u256;
```

**Parámetros:**
- `recipient`: Dirección de la wallet destino (ContractAddress)

**Retorna:**
- `u256`: ID del token minteado

**Ejemplo de llamada:**
```typescript
await mintNFT({
  args: [
    "0x034aA3F359A9D614239015126635CE7732c18fDF3" // recipient
  ]
});
```

### Otras Funciones Disponibles

| Función | Descripción | Tipo |
|---------|-------------|------|
| `name()` | Retorna el nombre del contrato | View |
| `symbol()` | Retorna el símbolo del contrato | View |
| `token_uri(token_id)` | Retorna URI estándar (vacía o base) | View |
| `owner_of(token_id)` | Obtiene el dueño de un token | View |
| `balance_of(account)` | Obtiene cantidad de NFTs de una dirección | View |
| `total_supply()` | Obtiene el total de NFTs minteados | View |
| `owner()` | Obtiene el dueño del contrato | View |

---

## 🔗 Enlaces Útiles

### Exploradores
- **Starkscan:** https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
- **Voyager:** https://voyager.online/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa

### Documentación
- **Scaffold-Stark 2:** https://www.scaffoldstark.com
- **Starknet Docs:** https://docs.starknet.io
- **OpenZeppelin Cairo:** https://docs.openzeppelin.com/contracts-cairo
- **ERC721 Standard:** https://eips.ethereum.org/EIPS/eip-721

### Herramientas
- **Braavos Wallet:** https://braavos.app
- **Starknet Status:** https://status.starknet.io

---

## 📄 Archivos de Referencia

Para más información técnica, consulta:

- **`QUESTLY_NFT_MAINNET_MINT_INSTRUCTIONS.md`** - Guía para QuestlyNFT (personalizado)
- **`QUICK_START_MINT.md`** - Guía rápida para QuestlyNFT
- **`TROUBLESHOOTING_FRONTEND.md`** - Solución de problemas generales
- **`packages/nextjs/contracts/deployedContracts.ts`** - Configuración del contrato

---

## 🎉 ¡Listo para Mintear!

Ya tienes toda la información necesaria para mintear NFTs en el contrato **QuestlyNFTStandard** desplegado en **Starknet Mainnet**.

### Pasos rápidos:
1. ✅ Inicia el servidor: `yarn dev`
2. ✅ Abre: http://localhost:3000/mint-standard
3. ✅ Conecta Braavos (Mainnet)
4. ✅ Ingresa dirección del destinatario
5. ✅ Mintea tu NFT estándar

**¡Disfruta creando tus NFTs estándar! 🚀✨**

---

## 📝 Notas Finales

- Este frontend está configurado **específicamente para el contrato QuestlyNFTStandard en Mainnet**
- La dirección del contrato está hardcodeada en `deployedContracts.ts`
- No se requiere desplegar contratos localmente
- Solo necesitas tener Braavos conectado a Mainnet
- Todas las transacciones son reales y tienen costo de gas
- **Más simple que QuestlyNFT:** Solo requiere dirección del destinatario

**Fecha de creación:** Enero 2025  
**Versión:** 1.0  
**Última actualización:** Enero 2025
