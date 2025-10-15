# 🚀 Guía de Uso - Frontend de Minteo QuestlyNFT en Mainnet

## 📋 Resumen

Este frontend te permite mintear NFTs del contrato **QuestlyNFT** desplegado en **Starknet Mainnet** usando tu wallet **Braavos**.

**Dirección del Contrato:** `0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080`

**Explorador:** [Ver en Starkscan](https://starkscan.co/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080)

---

## 🛠️ Instalación y Configuración

### 1. Instalar dependencias

```bash
cd packages/nextjs
yarn install
```

### 2. Configurar variables de entorno

El archivo `.env.local` ya está configurado con el RPC de mainnet:

```env
NEXT_PUBLIC_MAINNET_PROVIDER_URL=https://starknet-mainnet.public.blastapi.io/rpc/v0_7
```

### 3. Iniciar el servidor de desarrollo

```bash
yarn dev
```

El frontend estará disponible en: **http://localhost:3000**

---

## 💎 Cómo Mintear un NFT

### Paso 1: Conectar tu Wallet Braavos

1. Ve a **http://localhost:3000/mint**
2. Haz clic en el botón **"Connect Wallet"** en la esquina superior derecha
3. Selecciona **Braavos** de la lista de wallets
4. Autoriza la conexión en tu extensión de Braavos

⚠️ **Importante:** Asegúrate de que tu wallet Braavos esté configurada en **Starknet Mainnet**

### Paso 2: Completar el Formulario

En la página de minteo encontrarás dos campos:

1. **Dirección del destinatario**
   - Ingresa la dirección de la wallet que recibirá el NFT
   - Formato: `0x...` (debe comenzar con 0x)
   - Puedes usar el componente `AddressInput` que valida automáticamente

2. **URI de IPFS**
   - Pega la URI completa del metadata del NFT
   - Formato aceptado:
     - `ipfs://QmXxx...` (formato canónico)
     - `https://ipfs.io/ipfs/QmXxx...` (gateway HTTP)

**Ejemplo de URI:**
```
ipfs://QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG
```

### Paso 3: Mintear el NFT

1. Haz clic en el botón **"✨ Mintear NFT"**
2. Revisa los detalles de la transacción en Braavos
3. Confirma la transacción
4. Espera a que se confirme (aparecerá una notificación de éxito)

### Paso 4: Verificar el NFT

Una vez minteado, puedes verificar el NFT en:

- **Starkscan:** https://starkscan.co/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080
- **Tu Wallet:** Abre Braavos y verifica la sección de NFTs
- **Voyager:** https://voyager.online/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080

---

## 🎨 Características del Frontend

### Componentes Utilizados

- **`AddressInput`**: Componente de Scaffold-Stark que valida direcciones de Starknet
- **`useScaffoldWriteContract`**: Hook personalizado para interactuar con contratos
- **`CustomConnectButton`**: Botón de conexión de wallet integrado

### Validaciones Implementadas

✅ Verifica que la wallet esté conectada  
✅ Valida que la dirección del destinatario sea válida (formato 0x...)  
✅ Valida que la URI de IPFS no esté vacía  
✅ Muestra notificaciones de éxito/error  
✅ Limpia los campos automáticamente después de un minteo exitoso  
✅ Deshabilita el botón durante el proceso de minteo  

### Estados de la Aplicación

| Estado | Descripción |
|--------|-------------|
| **No conectado** | Muestra alerta pidiendo conectar wallet |
| **Conectado** | Muestra formulario completo |
| **Minteando** | Botón deshabilitado con spinner de carga |
| **Éxito** | Notificación verde y limpieza de campos |
| **Error** | Notificación roja con mensaje de error |

---

## 🔍 Detalles Técnicos

### Configuración de Red

**Archivo:** `packages/nextjs/scaffold.config.ts`

```typescript
const scaffoldConfig = {
  targetNetworks: [chains.mainnet], // Configurado para mainnet
  pollingInterval: 30_000,
  onlyLocalBurnerWallet: false,
  walletAutoConnect: true,
};
```

### Contrato Externo

**Archivo:** `packages/nextjs/contracts/externalContracts.ts`

El contrato QuestlyNFT está configurado como contrato externo con:
- Dirección en mainnet
- ABI completo del contrato
- Interfaces ERC721, Ownable, y custom `IYourCollectible`

### Función de Minteo

El frontend llama a la función `mint_item` del contrato:

```cairo
fn mint_item(ref self: T, recipient: ContractAddress, uri: ByteArray) -> u256;
```

**Parámetros:**
- `recipient`: Dirección de la wallet que recibirá el NFT
- `uri`: URI completa del metadata en IPFS

**Retorna:**
- `u256`: El token ID del NFT minteado

---

## 📱 Navegación

El frontend incluye un menú de navegación con las siguientes páginas:

- **🎨 Mint NFT** (`/mint`) - Página principal de minteo
- **🖼️ My NFTs** (`/myNFTs`) - Ver tus NFTs
- **🔄 Transfers** (`/transfers`) - Historial de transferencias
- **⬆️ IPFS Upload** (`/ipfsUpload`) - Subir archivos a IPFS
- **⬇️ IPFS Download** (`/ipfsDownload`) - Descargar archivos de IPFS
- **🐛 Debug Contracts** (`/debug`) - Herramientas de debug

---

## ⚠️ Consideraciones Importantes

### Costos de Gas

- Cada minteo requiere pagar gas en STRK o ETH
- Asegúrate de tener fondos suficientes en tu wallet Braavos
- El costo aproximado varía según la congestión de la red

### Metadata de IPFS

El contrato almacena la URI tal como la proporcionas. Asegúrate de que:

1. **El archivo esté subido a IPFS** antes de mintear
2. **La URI sea accesible** (verifica que puedas acceder vía gateway)
3. **El formato del metadata sea válido** (JSON con campos name, description, image, etc.)

**Ejemplo de metadata válido:**

```json
{
  "name": "Questly Platinum #1",
  "description": "NFT exclusivo de Questly",
  "image": "ipfs://QmXxx.../image.png",
  "attributes": [
    {
      "trait_type": "Rarity",
      "value": "Platinum"
    }
  ]
}
```

### Seguridad

- ✅ El frontend **solo interactúa con el contrato en mainnet**
- ✅ Todas las transacciones **requieren confirmación** en tu wallet
- ✅ El contrato es **verificado** en Starkscan
- ⚠️ **Revisa siempre** los detalles de la transacción antes de confirmar

---

## 🆘 Solución de Problemas

### Error: "Por favor conecta tu wallet Braavos primero"

**Causa:** La wallet no está conectada

**Solución:**
1. Haz clic en "Connect Wallet" en la esquina superior derecha
2. Selecciona Braavos y autoriza la conexión
3. Verifica que estés en Starknet Mainnet

### Error: "Dirección de wallet inválida"

**Causa:** La dirección del destinatario no tiene el formato correcto

**Solución:**
- Verifica que la dirección comience con `0x`
- Asegúrate de copiar la dirección completa
- No uses nombres ENS, solo direcciones hexadecimales

### Error: "La URI de IPFS no puede estar vacía"

**Causa:** El campo de URI está vacío o solo contiene espacios

**Solución:**
- Pega la URI completa del metadata
- Asegúrate de que no haya espacios al inicio o final

### Error durante la transacción

**Posibles causas:**
- Fondos insuficientes para el gas
- Red congestionada
- Problema con el RPC

**Solución:**
1. Verifica tu balance de STRK/ETH
2. Espera unos minutos e intenta nuevamente
3. Si persiste, revisa el estado de Starknet en https://status.starknet.io

### La transacción no aparece en mi wallet

**Solución:**
- Espera unos minutos (las transacciones pueden tardar)
- Verifica en Starkscan usando tu dirección
- Refresca la página de tu wallet

---

## 📚 Recursos Adicionales

- **Documentación de Scaffold-Stark 2:** https://www.scaffoldstark.com
- **Starknet Docs:** https://docs.starknet.io
- **IPFS Docs:** https://docs.ipfs.tech
- **Braavos Wallet:** https://braavos.app
- **Starkscan:** https://starkscan.co

---

## 🎉 ¡Listo para Mintear!

Ya tienes todo configurado para empezar a mintear NFTs en Starknet Mainnet. 

**Accede a:** http://localhost:3000/mint

¡Disfruta creando tus NFTs! 🚀✨

