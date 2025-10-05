# 🚀 Scripts de Devnet para Debugging en Starknet

Esta documentación explica cómo usar los scripts personalizados para optimizar el debugging y desarrollo en Starknet Devnet.

## 📋 Scripts Disponibles

### 1. `start_devnet.sh` - Iniciar Devnet Inteligente
### 2. `clean_devnet.sh` - Limpiar Estado del Devnet
### 3. `create_env.js` - Configurar Variables de Entorno

---

## 🎯 Beneficios para Debugging

### **🔄 Persistencia de Estado**
- **Problema**: Cada vez que reinicias el devnet, pierdes todos los contratos desplegados
- **Solución**: Los scripts mantienen el estado guardado automáticamente
- **Beneficio**: No necesitas redesplegar contratos constantemente durante el debugging

### **🎲 Consistencia de Direcciones**
- **Problema**: Las direcciones de contratos cambian con cada reinicio
- **Solución**: Usa siempre el mismo seed (0) para generar direcciones consistentes
- **Beneficio**: Las direcciones de contratos y cuentas siempre son las mismas

### **⚡ Desarrollo Rápido**
- **Problema**: Configurar el entorno de desarrollo toma tiempo
- **Solución**: Scripts automatizados que configuran todo en segundos
- **Beneficio**: Más tiempo para escribir código, menos tiempo configurando

### **🧹 Limpieza Controlada**
- **Problema**: Archivos temporales y estados corruptos pueden causar errores
- **Solución**: Script de limpieza que elimina solo lo necesario
- **Beneficio**: Entorno limpio y predecible para cada sesión de desarrollo

---

## 🛠️ Cómo Usar los Scripts

### **Primera Vez (Configuración Inicial)**

```bash
# 1. Configurar variables de entorno
node create_env.js

# 2. Iniciar devnet limpio
./start_devnet.sh

# 3. En otra terminal, desplegar contratos
yarn deploy

# 4. El devnet guardará automáticamente el estado al cerrar
```

### **Sesiones de Desarrollo Posteriores**

```bash
# Simplemente iniciar el devnet (cargará estado automáticamente)
./start_devnet.sh
```

### **Cuando Necesites Limpiar Todo**

```bash
# Detener devnet actual (Ctrl+C)
# Luego limpiar
./clean_devnet.sh

# Iniciar devnet limpio
./start_devnet.sh
```

---

## 📖 Detalles Técnicos

### **`start_devnet.sh`**

**¿Qué hace?**
- Detecta si existe un estado guardado
- Si existe: carga el estado (mantiene contratos desplegados)
- Si no existe: inicia devnet limpio con seed 0

**Parámetros importantes:**
- `--seed 0`: Genera las mismas cuentas predefinidas siempre
- `--dump-path`: Archivo donde guardar el estado
- `--load-path`: Archivo desde donde cargar el estado
- `--dump-on exit`: Guarda automáticamente al cerrar

### **`clean_devnet.sh`**

**¿Qué elimina?**
- `devnet_state.json`: Estado guardado del devnet
- `deployments/*`: Archivos de deployment
- `contracts/target/*`: Compilaciones de Cairo

**¿Qué NO elimina?**
- Código fuente de contratos
- Archivos de configuración (.env, snfoundry.toml)
- Scripts de deployment

### **`create_env.js`**

**¿Qué configura?**
- Cuenta deployer con fondos predefinidos
- RPC URL del devnet local
- Configuración para redes (devnet, sepolia, mainnet)

---

## 🎮 Flujos de Trabajo Comunes

### **🔄 Debugging de Contratos**
```bash
# 1. Iniciar devnet con estado
./start_devnet.sh

# 2. Hacer cambios en contratos
# Editar archivos .cairo

# 3. Recompilar y redesplegar
yarn compile
yarn deploy

# 4. Probar cambios
# El estado se mantiene entre compilaciones
```

### **🧪 Testing Completo**
```bash
# 1. Limpiar todo para test limpio
./clean_devnet.sh

# 2. Iniciar devnet limpio
./start_devnet.sh

# 3. Ejecutar tests
yarn test
```

### **🚀 Demo/Presentación**
```bash
# 1. Preparar entorno con contratos desplegados
./start_devnet.sh
yarn deploy

# 2. Iniciar frontend
yarn start

# 3. Todo está listo para la demo
```

---

## ⚠️ Casos de Uso Específicos

### **Cuando usar `start_devnet.sh`:**
- ✅ Desarrollo diario
- ✅ Debugging de contratos
- ✅ Testing de frontend
- ✅ Demos y presentaciones

### **Cuando usar `clean_devnet.sh`:**
- ✅ Errores de estado corrupto
- ✅ Cambios en configuración de red
- ✅ Testing desde cero
- ✅ Resolución de problemas

### **Cuando usar `create_env.js`:**
- ✅ Configuración inicial del proyecto
- ✅ Cambio de configuración de red
- ✅ Setup en nueva máquina
- ✅ Restaurar configuración perdida

---

## 🔧 Configuración de Cuentas Predefinidas

Con `seed 0`, siempre tendrás estas cuentas disponibles:

| # | Address | Private Key | Uso |
|---|---------|-------------|-----|
| 1 | `0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691` | `0x71d7bb07b9a64f6f78ac4c816aff4da9` | **Deployer Principal** |
| 2 | `0x078662e7352d062084b0010068b99288486c2d8b914f6e2a55ce945f8792c8b1` | `0x0e1406455b7d66b1690803be066cbe5e` | Testing |
| 3 | `0x049dfb8ce986e21d354ac93ea65e6a11f639c1934ea253e5ff14ca62eca0f38e` | `0xa20a02f0ac53692d144b20cb371a60d7` | Testing |

**Nota**: Todas las cuentas tienen 1000 STRK de balance inicial.

---

## 🚨 Solución de Problemas

### **Error: "Contract not found"**
```bash
# El contrato no está desplegado, redesplegar:
yarn deploy
```

### **Error: "Port 5050 already in use"**
```bash
# Detener proceso anterior:
pkill -f starknet-devnet
# O cambiar puerto en los scripts
```

### **Error: "Permission denied"**
```bash
# Dar permisos de ejecución:
chmod +x *.sh
```

### **Estado corrupto**
```bash
# Limpiar todo y empezar de nuevo:
./clean_devnet.sh
./start_devnet.sh
yarn deploy
```

---

## 💡 Tips y Mejores Prácticas

1. **Siempre usa `./start_devnet.sh`** en lugar de comandos manuales
2. **Guarda el estado** antes de hacer cambios importantes
3. **Limpia regularmente** para evitar acumulación de archivos
4. **Usa las cuentas predefinidas** para testing consistente
5. **Documenta las direcciones** de contratos importantes

---

## 📁 Estructura de Archivos

```
realNFT/
├── start_devnet.sh          # Iniciar devnet
├── clean_devnet.sh          # Limpiar estado
├── create_env.js            # Configurar entorno
├── DEVNET_SCRIPTS.md        # Esta documentación
└── packages/snfoundry/
    ├── .env                 # Variables de entorno
    ├── snfoundry.toml       # Configuración de foundry
    ├── devnet_state.json    # Estado guardado (se crea automáticamente)
    └── deployments/         # Archivos de deployment
```

---

## 📄 Información del Contrato Actual

### **Contrato Desplegado:**
- **Nombre**: `YourCollectible`
- **Address**: `0x354ebcd9f7a0e2bd247f23eb5dc42ba9d997db904ffdac05d2de06e45764ee9`
- **Archivo de configuración**: `packages/nextjs/contracts/deployedContracts.ts`

### **Cómo Usar el Contrato en el Frontend:**

```typescript
import { useScaffoldReadContract, useScaffoldWriteContract } from "~~/hooks/scaffold-stark";

// Leer del contrato
const { data: tokenCount } = useScaffoldReadContract({
  contractName: "YourCollectible",
  functionName: "total_supply", // o cualquier función pública
});

// Escribir al contrato
const { sendAsync: mintAsync } = useScaffoldWriteContract({
  contractName: "YourCollectible",
  functionName: "mint_item",
  args: [recipientAddress, tokenUri],
});
```

### **Flujo Completo de Trabajo:**

#### **Sesión de Desarrollo Diaria:**
```bash
# 1. Iniciar devnet persistente (carga estado automáticamente)
./start_devnet.sh

# 2. En otra terminal, iniciar frontend
yarn start

# 3. El contrato ya está disponible, no necesitas redesplegar
```

#### **Cuando Necesites Cambiar el Contrato:**
```bash
# 1. Detener devnet (Ctrl+C)
# 2. Hacer cambios en el código Cairo
# 3. Limpiar estado si es necesario
./clean_devnet.sh

# 4. Iniciar devnet limpio
./start_devnet.sh

# 5. Redesplegar con cambios
yarn deploy

# 6. El estado se guardará automáticamente al cerrar
```

#### **Verificar Estado del Contrato:**
```bash
# Verificar que el contrato existe
curl -X POST http://127.0.0.1:5050/rpc \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "method": "starknet_getClassHashAt",
    "params": {
      "contract_address": "0x68298c942227e30cf56df6fd0857e56817404217cc3000adfdd80a0cdb935e",
      "block_id": "latest"
    },
    "id": 1
  }'
```

### **Configuración de Cuentas Predefinidas:**

| # | Address | Private Key | Uso |
|---|---------|-------------|-----|
| 1 | `0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691` | `0x71d7bb07b9a64f6f78ac4c816aff4da9` | **Deployer Principal** |
| 2 | `0x078662e7352d062084b0010068b99288486c2d8b914f6e2a55ce945f8792c8b1` | `0x0e1406455b7d66b1690803be066cbe5e` | Testing |
| 3 | `0x049dfb8ce986e21d354ac93ea65e6a11f639c1934ea253e5ff14ca62eca0f38e` | `0xa20a02f0ac53692d144b20cb371a60d7` | Testing |

**Nota**: Todas las cuentas tienen 1000 STRK de balance inicial.

### **Comandos de Verificación:**

```bash
# Verificar que el archivo de estado existe
ls -la packages/snfoundry/devnet_state.json

# Verificar configuración de entorno
cat packages/snfoundry/.env

# Verificar contratos desplegados
cat packages/nextjs/contracts/deployedContracts.ts
```

### **Solución de Problemas Específicos:**

#### **Error: "Contract not found"**
```bash
# El contrato no está desplegado o el devnet no está corriendo
./start_devnet.sh  # Reiniciar devnet
yarn deploy        # Si es necesario, redesplegar
```

#### **Error: "Port 5050 already in use"**
```bash
# Detener proceso anterior
pkill -f starknet-devnet
./start_devnet.sh  # Reiniciar
```

#### **Estado corrupto**
```bash
# Limpiar todo y empezar de nuevo
./clean_devnet.sh
./start_devnet.sh
yarn deploy
```

---

## 🔧 Solución Final del Problema de resource_bounds

### **Problema Identificado:**
- Error: `resource_bounds` aparecían como `0x0` en las transacciones
- Causa: Configuración incorrecta del `Scarb.toml` y falta de configuración manual de fees

### **Solución Final Implementada:**

#### **1. Alineación completa con speedrunstark:**
- ✅ `starknet.js`: `8.5.3`
- ✅ `starknet-foundry`: `0.49.0` 
- ✅ `starknet-devnet`: `0.5.1`
- ✅ `Scarb`: `2.12.0`

#### **2. Configuración crítica del Scarb.toml:**
```toml
[[target.starknet-contract]]
casm = true # ¡CRÍTICO! Debe ser true, no false

[[tool.snforge.fork]]
url = "https://starknet-sepolia.public.blastapi.io/rpc/v0_9" # RPC v0.9
```

#### **3. Configuración manual de resource_bounds en deploy-contract.ts:**
```typescript
const declareOptions = networkName === "devnet" ? {
  ...options,
  tip: 1000n,
  resourceBounds: {
    l1_gas: { max_amount: 1000000n, max_price_per_unit: 1000000000n },
    l2_gas: { max_amount: 1000000n, max_price_per_unit: 1000000000n },
    l1_data_gas: { max_amount: 1000000n, max_price_per_unit: 1000000000n }
  }
} : { ...options };

const executeOptions = networkName === "devnet" ? {
  ...options,
  tip: 1000n,
  resourceBounds: {
    l1_gas: { max_amount: 1000000n, max_price_per_unit: 1000000000n },
    l2_gas: { max_amount: 1000000n, max_price_per_unit: 1000000000n },
    l1_data_gas: { max_amount: 1000000n, max_price_per_unit: 1000000000n }
  }
} : { ...options };
```

### **Resultado Final:**
✅ **Deploy exitoso** - Contrato `YourCollectible` desplegado: `0x354ebcd9f7a0e2bd247f23eb5dc42ba9d997db904ffdac05d2de06e45764ee9`
✅ **resource_bounds funcionando** - Sin errores de validación de rango
✅ **Transaction hash**: `0x2ff4fe7fbbfbe4eabd0061f7b32a5eda1f20ae098a104ef90d7a42ae3171d48`
✅ **Frontend actualizado** - `deployedContracts.ts` actualizado automáticamente
✅ **Configuración estable** - Alineada 100% con speedrunstark

---

**🎉 ¡Con estos scripts y configuraciones, el debugging en Starknet Devnet será mucho más eficiente y predecible!**
