# 🐛 Debugging & Contract Info

> Información sobre contratos desplegados y debugging para Scaffold-Stark 2

---

## 📦 Contrato Desplegado Actual

### 📝 Información del Contrato

**Nombre del Contrato:** `YourCollectible`

**Address (Dirección):**
```
0x1ddbf6eb3a5217e1b42cc2fd90ef6e50bd35bd333b49764b0207b5de298a31a
```

**Class Hash:**
```
0x6b018667ff971fdaa6c8cd1d94ff080c1d37e06af66fa6e322389c77fc408e8
```

**Archivo fuente:**
```
packages/snfoundry/contracts/src/your_collectible.cairo
```

**Network:** Devnet (local)

**URL Devnet:** `http://127.0.0.1:5050`

---

## 🔍 Verificación del Contrato

### Ver información de deployment:

```bash
# Ver el deployment file completo
cat packages/snfoundry/deployments/devnet_latest.json

# Ver contratos en el frontend
cat packages/nextjs/contracts/deployedContracts.ts

# Verificar que el devnet está corriendo
curl http://127.0.0.1:5050/is_alive
```

### Verificar el contrato en el devnet:

```bash
# Ver información del contrato usando sncast
sncast --url http://127.0.0.1:5050 \
  call \
  --contract-address 0x1ddbf6eb3a5217e1b42cc2fd90ef6e50bd35bd333b49764b0207b5de298a31a \
  --function nombre_de_funcion
```

---

## 🎯 Dirección Predecible

✅ **Importante:** Gracias a `--seed 0`, esta dirección será **siempre la misma** cada vez que ejecutes `./quick-start.sh`, siempre y cuando:

- ✅ Despliegues en el mismo orden
- ✅ Uses el mismo seed (0)
- ✅ No cambies el código del contrato
- ✅ No cambies el constructor del contrato

---

## 💰 Cuenta de Desarrollo Predefinida

Con `--seed 0`, siempre obtienes esta cuenta:

**Address:**
```
0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691
```

**Private Key:**
```
0x0000000000000000000000000000000071d7bb07b9a64f6f78ac4c816aff4da9
```

**Public Key:**
```
0x039d9e6ce352ad4530a0ef5d5a18fd3303c3606a7fa6ac5b620020ad681cc33b
```

**Balance Inicial:** 1000 ETH y FRI

---

## 🔧 Comandos de Debugging

### Ver logs del devnet:

```bash
# Ver últimas líneas
tail -f /tmp/devnet.log

# Ver todo el log
cat /tmp/devnet.log
```

### Ver proceso del devnet:

```bash
# Ver si está corriendo
ps aux | grep starknet-devnet

# Ver PID
pgrep -f starknet-devnet

# Ver puerto
lsof -i :5050
```

### Interactuar con el contrato:

```bash
# Llamar una función de lectura
sncast --url http://127.0.0.1:5050 \
  call \
  --contract-address 0x1ddbf6eb3a5217e1b42cc2fd90ef6e50bd35bd333b49764b0207b5de298a31a \
  --function get_function_name

# Llamar una función de escritura (requiere cuenta)
sncast --url http://127.0.0.1:5050 \
  --account ./path/to/account.json \
  invoke \
  --contract-address 0x1ddbf6eb3a5217e1b42cc2fd90ef6e50bd35bd333b49764b0207b5de298a31a \
  --function set_function_name \
  --calldata 0x123
```

---

## 📊 Estado del Devnet

### Verificar bloques:

```bash
# Ver número de bloque actual
curl -X POST http://127.0.0.1:5050 \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "method": "starknet_blockNumber",
    "params": [],
    "id": 1
  }' | jq
```

### Ver transacciones:

```bash
# Ver transacciones recientes
curl http://127.0.0.1:5050/transactions | jq
```

---

## 🐛 Problemas Comunes

### Error: "Contract already deployed"

**Causa:** El devnet tiene un dump previo con el contrato ya desplegado

**Solución:**
```bash
pkill starknet-devnet
rm -f ./devnet-data/devnet_dump.pkl
./quick-start.sh
```

### Error: "Port 5050 already in use"

**Causa:** Ya hay un devnet corriendo

**Solución:**
```bash
# Ver qué está usando el puerto
lsof -i :5050

# Matar el proceso
pkill starknet-devnet
# O forzar:
lsof -ti:5050 | xargs kill -9
```

### Error: "Connection refused"

**Causa:** El devnet no está corriendo

**Solución:**
```bash
./start-devnet-persistent.sh
# O usar el quick-start completo:
./quick-start.sh
```

### El contrato no responde

**Verificar:**
```bash
# 1. ¿Está el devnet corriendo?
curl http://127.0.0.1:5050/is_alive

# 2. ¿Está el contrato desplegado?
cat packages/snfoundry/deployments/devnet_latest.json

# 3. ¿La dirección es correcta?
cat packages/nextjs/contracts/deployedContracts.ts
```

---

## 🔄 Redesplegar el Contrato

### Redespliegue completo (recomendado):

```bash
./quick-start.sh
```

### Redespliegue manual:

```bash
# 1. Detener devnet
pkill starknet-devnet

# 2. Limpiar dump
rm -f ./devnet-data/devnet_dump.pkl

# 3. Iniciar devnet
./start-devnet-persistent.sh

# 4. Esperar 3 segundos
sleep 3

# 5. Desplegar
cd packages/snfoundry
yarn deploy --network devnet
```

---

## 📝 Archivos Importantes

### Contratos:
- `packages/snfoundry/contracts/src/your_collectible.cairo` - Código del contrato
- `packages/snfoundry/contracts/src/lib.cairo` - Archivo principal

### Deployments:
- `packages/snfoundry/deployments/devnet_latest.json` - Info de contratos desplegados
- `packages/nextjs/contracts/deployedContracts.ts` - Contratos para el frontend

### Scripts de Deploy:
- `packages/snfoundry/scripts-ts/deploy.ts` - Script principal de deployment
- `packages/snfoundry/scripts-ts/deploy-contract.ts` - Lógica de deployment

### Configuración:
- `packages/nextjs/scaffold.config.ts` - Config del frontend
- `packages/snfoundry/snfoundry.toml` - Config de Starknet Foundry

---

## 🔗 Enlaces Útiles

### Exploradores de Bloques (cuando despliegues a testnet):
- **Sepolia:** 
  - [Voyager](https://sepolia.voyager.online/)
  - [Starkscan](https://sepolia.starkscan.co/)
  - [StarkCompass](https://sepolia.starkcompass.com/)

### Faucets (para testnet):
- [Starknet Faucet](https://starknet-faucet.vercel.app/)
- [Blast Faucet](https://blastapi.io/faucets/starknet-sepolia-eth)

---

## 📚 Ver También

- [`START_HERE.md`](./START_HERE.md) - Punto de entrada principal
- [`QUICK_START_README.md`](./QUICK_START_README.md) - Guía de inicio rápido
- [`DEVNET_PERSISTENTE.md`](./DEVNET_PERSISTENTE.md) - Guía técnica completa

---

**Última actualización:** Octubre 2025  
**Proyecto:** Scaffold-Stark 2 - realNFT
