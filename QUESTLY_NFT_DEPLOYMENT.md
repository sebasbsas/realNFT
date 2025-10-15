# 🎉 QuestlyNFT - Despliegue Exitoso en Mainnet

**Fecha de Despliegue:** 15 de Octubre, 2025  
**Network:** Starknet Mainnet  
**Estado:** ✅ Desplegado y Verificado

---

## 📄 Información del Contrato

### Direcciones y Hashes

**Contract Address:**
```
0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080
```

**Transaction Hash:**
```
0x25b67b65a5e72334de26c503d31be9d471d145c5bb857de39b5d80dc7361d93
```

**Class Hash:**
```
0x60451ffd99746dc0995dc6a32cb451e79d0cb7be2dec5336378f26e13c8f9de
```

### Explorer Links

- 🔍 **Contrato:** https://starkscan.co/contract/0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080
- 📜 **Transacción:** https://starkscan.co/tx/0x25b67b65a5e72334de26c503d31be9d471d145c5bb857de39b5d80dc7361d93

### Metadata del NFT

- **Name:** Questly Platinums
- **Symbol:** QEST
- **Base URI:** (vacío - cada token tiene su propio URI)

---

## 💰 Información de Costos

**Deployer Address:**
```
0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565
```

**Balance Post-Deployment:** 21.551105452665300533 STRK

**Gas Usado (Declare):** 
- L1 Data Gas: 192
- L2 Gas: 262353555
- Fee: 0xaec33814a040513 FRI

---

## 🔥 Características del Contrato

### ✅ Funcionalidades Implementadas

1. **Minting con IPFS URI**
   - Función: `mint_item(recipient: ContractAddress, uri: ByteArray) -> u256`
   - Cualquier wallet puede mintear
   - El owner es el deployer
   - Cada token puede tener su propia metadata URI

2. **Lectura de Metadata**
   - Función: `token_uri(token_id: u256) -> ByteArray`
   - Retorna el URI IPFS del token

3. **Funciones ERC721 Estándar**
   - `owner_of(token_id: u256) -> ContractAddress`
   - `balance_of(owner: ContractAddress) -> u256`
   - `name() -> ByteArray` → "Questly Platinums"
   - `symbol() -> ByteArray` → "QEST"
   - `total_supply() -> u256`

4. **Gestión de Propiedad**
   - `get_owner() -> ContractAddress`
   - Basado en OpenZeppelin OwnableComponent

### 🎨 Componentes OpenZeppelin Utilizados

- ✅ **ERC721Component** - Funcionalidad NFT base
- ✅ **OwnableComponent** - Gestión de propiedad
- ✅ **SRC5Component** - Introspección de interfaces
- ✅ **CounterComponent** - Contador de token IDs

### 📦 Optimizaciones vs YourCollectible

**Eliminado para reducir tamaño:**
- ❌ ERC721EnumerableComponent (enumeración completa)

**Conservado:**
- ✅ URI Storage individual por token
- ✅ Soporte completo IPFS
- ✅ Funcionalidad de minting con metadata

---

## 🚀 Integración con React Native

### Documentación Completa

Ver archivo: **`REACT_NATIVE_QUESTLY_NFT.md`**

### Ejemplo Rápido de Uso

```typescript
import { Contract } from 'starknet';

const NFT_ADDRESS = '0x2cf4e33cd8f9844fc928ed43c72c7bdabc1773ae9c3f26ac1c2b232ca7b0080';

// Mintear NFT con IPFS URI
const contract = new Contract(ABI, NFT_ADDRESS, account);
const tx = await contract.mint_item(
  recipientAddress,
  'ipfs://QmZdULHpCfuZAzoFo6YrS7mCLr8g9eBVPx2YNt3NRTXF9F/nft-01-balance-orb-basic.json'
);

// Obtener metadata
const uri = await contract.token_uri(tokenId);
```

---

## 📋 ABI del Contrato

```json
[
  {
    "type": "function",
    "name": "mint_item",
    "inputs": [
      { "name": "recipient", "type": "core::starknet::contract_address::ContractAddress" },
      { "name": "uri", "type": "core::byte_array::ByteArray" }
    ],
    "outputs": [{ "type": "core::integer::u256" }],
    "state_mutability": "external"
  },
  {
    "type": "function",
    "name": "token_uri",
    "inputs": [{ "name": "token_id", "type": "core::integer::u256" }],
    "outputs": [{ "type": "core::byte_array::ByteArray" }],
    "state_mutability": "view"
  },
  {
    "type": "function",
    "name": "owner_of",
    "inputs": [{ "name": "token_id", "type": "core::integer::u256" }],
    "outputs": [{ "type": "core::starknet::contract_address::ContractAddress" }],
    "state_mutability": "view"
  },
  {
    "type": "function",
    "name": "balance_of",
    "inputs": [{ "name": "owner", "type": "core::starknet::contract_address::ContractAddress" }],
    "outputs": [{ "type": "core::integer::u256" }],
    "state_mutability": "view"
  },
  {
    "type": "function",
    "name": "name",
    "inputs": [],
    "outputs": [{ "type": "core::byte_array::ByteArray" }],
    "state_mutability": "view"
  },
  {
    "type": "function",
    "name": "symbol",
    "inputs": [],
    "outputs": [{ "type": "core::byte_array::ByteArray" }],
    "state_mutability": "view"
  },
  {
    "type": "function",
    "name": "total_supply",
    "inputs": [],
    "outputs": [{ "type": "core::integer::u256" }],
    "state_mutability": "view"
  },
  {
    "type": "function",
    "name": "get_owner",
    "inputs": [],
    "outputs": [{ "type": "core::starknet::contract_address::ContractAddress" }],
    "state_mutability": "view"
  }
]
```

---

## 🔧 Configuración de Red

### RPC Endpoints Utilizados

**Mainnet:**
```
https://starknet-mainnet.blastapi.io/64168c77-3fa5-4e1e-9fe4-41675d212522/rpc/v0_9
```

### Variables de Entorno

**Backend (`packages/snfoundry/.env`):**
```bash
ACCOUNT_ADDRESS_MAINNET=0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565
PRIVATE_KEY_MAINNET=<tu_private_key>
RPC_URL_MAINNET=https://starknet-mainnet.blastapi.io/64168c77-3fa5-4e1e-9fe4-41675d212522/rpc/v0_9
```

**Frontend (`packages/nextjs/.env`):**
```bash
NEXT_PUBLIC_MAINNET_PROVIDER_URL=https://starknet-mainnet.blastapi.io/64168c77-3fa5-4e1e-9fe4-41675d212522/rpc/v0_9
```

---

## 📝 Historial de Despliegues

### Intentos Anteriores

| Contrato | Estado | Razón |
|----------|--------|-------|
| YourCollectible | ❌ Failed | Contrato demasiado grande (incluía ERC721Enumerable) |
| YourCollectibleSimple | ❌ Failed | Aún demasiado grande |
| YourCollectibleOptimized | ❌ Failed | Optimización insuficiente |
| MinimalNFT | ✅ Success | Sin URI storage (básico) |
| **QuestlyNFT** | ✅ **Success** | **Balance perfecto: URIs + tamaño optimizado** |

### Lecciones Aprendidas

1. **Tamaño del Contrato:** Los contratos con múltiples componentes OpenZeppelin pueden exceder el límite de mainnet
2. **ERC721Enumerable:** Es pesado, eliminar si no es crítico
3. **RPC Version:** Usar `v0_9` para compatibilidad con Starknet actual
4. **URI Storage:** Se puede mantener usando `Map<u256, ByteArray>` sin mucho overhead

---

## ✅ Validaciones Realizadas

- ✅ Cuenta de deployer desplegada en mainnet
- ✅ Fondos STRK suficientes
- ✅ RPC endpoint válido (v0_9)
- ✅ Contrato compilado sin errores
- ✅ Despliegue exitoso
- ✅ Verificación en Starkscan exitosa
- ✅ ABI exportado a frontend

---

## 🎯 Casos de Uso

### Minteo desde React Native

**Escenario:** Aplicación móvil que permite a usuarios mintear NFTs con metadata IPFS

**Requisitos:**
- Wallet Starknet (Braavos/Argent Mobile)
- STRK para gas (~0.01-0.02 por mint)
- URI IPFS del metadata JSON

**Ejemplo URI:**
```
ipfs://QmZdULHpCfuZAzoFo6YrS7mCLr8g9eBVPx2YNt3NRTXF9F/nft-01-balance-orb-basic.json
```

**Código Mínimo:**
```typescript
const tx = await contract.mint_item(
  userAddress,
  'ipfs://QmXxXx.../metadata.json'
);
const receipt = await account.waitForTransaction(tx.transaction_hash);
const tokenId = receipt.events[0].data[1];
```

---

## 🔐 Seguridad

### Consideraciones

- ✅ **Ownable:** Solo el owner (deployer) tiene privilegios especiales
- ✅ **OpenZeppelin:** Componentes auditados y seguros
- ⚠️ **Mint Público:** Actualmente, el `mint_item` verifica `assert_only_owner()` - **solo el owner puede mintear**

### Modificar para Mint Público

Si quieres que **cualquiera pueda mintear**, edita `questly_nft.cairo`:

```cairo
fn mint_item(ref self: ContractState, recipient: ContractAddress, uri: ByteArray) -> u256 {
    // Remover esta línea:
    // self.ownable.assert_only_owner();
    
    self.token_id_counter.increment();
    let token_id = self.token_id_counter.current();
    self.erc721.mint(recipient, token_id);
    self.token_uris.write(token_id, uri);
    self.emit(Minted { to: recipient, token_id, uri });
    token_id
}
```

Luego redespliega el contrato.

---

## 📊 Métricas Estimadas

**Por Transacción de Mint:**
- Gas Estimado: ~0.01-0.02 STRK
- Tiempo de Confirmación: 10-30 segundos (L2)
- Finalidad: ~1-2 horas (L1)

**Capacidad:**
- Max Token ID: 2^256 - 1 (prácticamente ilimitado)
- URI Length: Sin límite práctico (ByteArray)

---

## 🛠️ Mantenimiento

### Archivos Clave

**Contrato:**
- `/packages/snfoundry/contracts/src/questly_nft.cairo`
- `/packages/snfoundry/contracts/src/lib.cairo`

**Script de Deploy:**
- `/packages/snfoundry/scripts-ts/deploy.ts`

**Frontend:**
- `/packages/nextjs/contracts/deployedContracts.ts` (auto-generado)

### Comandos Útiles

```bash
# Recompilar
cd packages/snfoundry/contracts && scarb build

# Verificar (ya hecho)
cd packages/snfoundry && yarn verify --network mainnet

# Leer estado del contrato
starkli call <contract_address> total_supply
```

---

## 📚 Documentación Adicional

- **Guía React Native:** `REACT_NATIVE_QUESTLY_NFT.md`
- **Guía Mainnet:** `MAINNET_DEPLOYMENT_GUIDE.md`
- **Checklist Hardcoded:** `HARDCODED_VALUES_CHECKLIST.md`

---

## 🎉 Conclusión

**QuestlyNFT** está desplegado exitosamente en Starknet Mainnet con:

- ✅ Soporte completo para metadata IPFS
- ✅ URIs individuales por token
- ✅ Funcionalidad ERC721 estándar
- ✅ Tamaño optimizado para mainnet
- ✅ Verificado en Starkscan
- ✅ Listo para integración React Native

**Próximos Pasos Sugeridos:**

1. Integrar en tu aplicación React Native
2. Crear metadata JSON en IPFS para tus NFTs
3. Implementar UI de minting
4. (Opcional) Modificar para mint público
5. Implementar visualización de NFTs minteados

---

**Desarrollado con Scaffold-Stark 2**  
**Network:** Starknet Mainnet  
**Última Actualización:** 15 de Octubre, 2025

