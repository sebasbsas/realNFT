# 🚀 Quick Start - Scaffold-Stark 2

## 📋 Scripts Disponibles

### 1. `./quick-start.sh` - Todo en uno ⚡ (RECOMENDADO)

**Uso:**
```bash
./quick-start.sh
```

**Lo que hace:**
1. ✅ Detiene devnet anterior si existe
2. 🧹 Limpia dumps previos
3. 📡 Inicia devnet con seed 0
4. 📦 Despliega todos los contratos automáticamente
5. 📊 Muestra resumen de direcciones y cuentas

**Tiempo:** ~30 segundos

**Cuándo usarlo:** Cada vez que empiezas a trabajar en el proyecto

---

### 2. `./start-devnet-persistent.sh` - Solo devnet

**Uso:**
```bash
./start-devnet-persistent.sh
```

**Lo que hace:**
- 📡 Inicia solo el devnet en puerto 5050
- 💾 Guarda el estado en `./devnet-data/devnet_dump.pkl`
- ⚠️ NO despliega contratos (lo haces manual)

**Cuándo usarlo:** Si solo quieres el devnet sin deployments

---

## 🎯 Workflow Recomendado

### Empezar tu día de desarrollo:

```bash
# 1. Usa el quick-start (hace todo)
./quick-start.sh

# 2. Espera ~30 segundos

# 3. Inicia el frontend
cd packages/nextjs
yarn start
```

### Durante el desarrollo:

El devnet sigue corriendo en background. Solo trabajas en tu código.

### Terminar tu día:

```bash
# Detener el devnet
pkill starknet-devnet
```

### Al día siguiente:

```bash
# Volver a ejecutar quick-start (redespliegue automático)
./quick-start.sh

# Los contratos tendrán las MISMAS direcciones ✅
# Gracias a --seed 0
```

---

## 📝 Información Importante

### ⚠️ Sobre la Persistencia

Tu proyecto usa `starknet-devnet 0.5.1`:
- ❌ **NO tiene persistencia real** entre reinicios
- ✅ **Con --seed 0**, las direcciones son predecibles
- 📦 **Solución**: El script `quick-start.sh` redesplega automáticamente

Lee [`DEVNET_PERSISTENTE.md`](./DEVNET_PERSISTENTE.md) para más detalles.

### 🎯 Direcciones Predecibles

Gracias a `--seed 0`, siempre obtienes:

**Cuenta predeployada:**
- Address: `0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691`
- Private Key: `0x0000000000000000000000000000000071d7bb07b9a64f6f78ac4c816aff4da9`
- Balance: 1000 ETH

**Contrato YourCollectible:**
- Address: `0x1ddbf6eb3a5217e1b42cc2fd90ef6e50bd35bd333b49764b0207b5de298a31a`
- (Siempre la misma si despliegas en el mismo orden)

---

## 🛠️ Comandos Útiles

### Ver si el devnet está corriendo:
```bash
curl http://127.0.0.1:5050/is_alive
# Respuesta: "Alive!!!"
```

### Ver el PID del devnet:
```bash
ps aux | grep starknet-devnet
```

### Detener el devnet:
```bash
pkill starknet-devnet
```

### Ver los logs del devnet:
```bash
cat /tmp/devnet.log
```

### Desplegar manualmente:
```bash
cd packages/snfoundry
yarn deploy --network devnet
```

### Limpiar todo y empezar de cero:
```bash
pkill starknet-devnet
rm -rf ./devnet-data
./quick-start.sh
```

---

## 🎓 Scripts Adicionales

- `backup-current-devnet.sh` - Hace backup del dump actual
- `clean_devnet.sh` - Limpia los datos del devnet
- `reset-devnet-data.sh` - Resetea todo

---

## 📚 Más Información

- **Guía completa:** [`DEVNET_PERSISTENTE.md`](./DEVNET_PERSISTENTE.md)
- **Scaffold-Stark Docs:** [scaffoldstark.com](https://www.scaffoldstark.com/)
- **Starknet Docs:** [docs.starknet.io](https://docs.starknet.io/)

---

## 💡 Tips

1. **Siempre usa `quick-start.sh`** - Es más rápido que hacer todo manual
2. **Los contratos son deterministas** - Con seed 0, siempre mismas direcciones
3. **No uses kill -9** - Usa `pkill starknet-devnet` para detener correctamente
4. **Commitea deployments** - El archivo `devnet_latest.json` es importante

---

¡Feliz desarrollo con Starknet! 🚀⚡

