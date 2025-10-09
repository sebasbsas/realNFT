# 🗄️ Guía de Uso: Devnet con Guardado de Estado en Scaffold-Stark 2

> **⚠️ Versión del documento**: Específico para `starknet-devnet 0.5.1` (versión Python)  
> **📅 Última actualización**: Octubre 2025

## 📖 ¿Qué es el Devnet con Guardado de Estado?

Esta guía explica cómo usar el devnet con la funcionalidad de **guardado de estado** (dump), que permite exportar el estado completo del devnet a un archivo.

## ⚠️ IMPORTANTE: Limitaciones de starknet-devnet 0.5.1

Tu proyecto usa **starknet-devnet 0.5.1** (versión Python), que tiene las siguientes características:

### ✅ Lo que SÍ hace:
- **Guarda el estado** en archivos `.pkl` (pickle) en tiempo real
- **Exporta** todos los contratos desplegados, transacciones y bloques
- Usa `--dump-on block` para guardar después de cada bloque

### ❌ Lo que NO puede hacer:
- **NO puede recargar** el estado guardado automáticamente
- **NO tiene `--load-path`** para restaurar desde un dump
- Por tanto, **NO es verdadera persistencia** entre reinicios

### 💡 Para verdadera persistencia:
Actualiza a **starknet-devnet-rs** (versión en Rust), que sí soporta:
- `--dump-path` + `--load-path` para persistencia completa
- `--db-path` para usar SQLite como backend
- Recarga automática del estado entre reinicios

## 🎯 ¿Para qué sirve entonces el dump en 0.5.1?

El archivo `.pkl` generado es útil para:
- **Backup del estado** para análisis posterior
- **Debugging** de problemas específicos
- **Compartir** un estado específico con el equipo
- **Documentación** del estado del devnet en un momento dado

### ✅ Ventajas del guardado

- **Cuentas estables**: Con `--seed 0`, siempre las mismas direcciones
- **Backup automático**: El estado se guarda continuamente
- **Debugging**: Exportar estado para análisis
- **Testing consistente**: Seed determinista

### ❌ Desventajas

- **Sin recarga automática**: Debes redesplegar al reiniciar
- **Espacio en disco**: El archivo .pkl crece con el tiempo (~300KB+)
- **No es persistencia real**: Solo es un snapshot/backup

---

## 🚀 Inicio Rápido

### 1. Iniciar el Devnet Persistente

```bash
./start-devnet-persistent.sh
```

O con bash:

```bash
bash start-devnet-persistent.sh
```

Verás una salida como esta:

```
🚀 Iniciando Starknet Devnet con guardado de estado...
✅ Devnet iniciado en puerto 5050
📊 El estado se guardará en: ./devnet-data/devnet_dump.pkl
🌐 URL: http://127.0.0.1:5050
🆔 PID del proceso: 239574

💾 Modo: --dump-on block (guarda después de cada bloque minado)

⚠️  LIMITACIÓN DE VERSIÓN 0.5.1:
   - Guarda el estado en tiempo real ✅
   - NO puede recargar el estado automáticamente ❌
   - Para persistencia real, actualiza a starknet-devnet-rs
```

### 2. Verificar que está Corriendo

```bash
curl http://127.0.0.1:5050/is_alive
```

Deberías ver: `"Alive!!!"`

### 3. Desplegar tus Contratos

```bash
cd packages/snfoundry
yarn deploy
```

Los contratos se desplegarán y el estado **se guardará en el archivo .pkl** después de cada bloque.

⚠️ **Nota**: Si reinicias el devnet, tendrás que redesplegar los contratos (la versión 0.5.1 no puede recargar el estado).

---

## 📁 Estructura de Archivos

```
realNFT/
├── start-devnet-persistent.sh       # Script de inicio
├── devnet-data/                     # Directorio de persistencia
│   └── devnet_dump.pkl              # Archivo de estado (pickle)
├── backup-current-devnet.sh         # Script para hacer backups
├── clean_devnet.sh                  # Script para limpiar datos
└── reset-devnet-data.sh             # Script para resetear todo
```

---

## 🔧 Configuración del Devnet

El script `start-devnet-persistent.sh` usa estos parámetros:

```bash
starknet-devnet \
    --port 5050                      # Puerto de escucha
    --seed 0                         # Seed para cuentas deterministas
    --accounts 1                     # Número de cuentas precargadas
    --initial-balance 1000000000000000000000  # Balance inicial (1000 ETH)
    --gas-price 1000000000           # Precio del gas
    --host 127.0.0.1                 # Host de escucha
    --timeout 60                     # Timeout de requests
    --dump-path ./devnet-data/devnet_dump.pkl  # Archivo donde se guarda el estado
    --dump-on exit                   # Guardar al salir (exit, transaction, o block)
```

### ⚠️ Nota sobre Guardado en starknet-devnet 0.5.1

En esta versión, el guardado funciona con **archivos pickle** (`.pkl`):

- `--dump-path`: Especifica dónde guardar el estado
- `--dump-on`: Cuándo guardar el estado

**Opciones de `--dump-on`** (versión 0.5.1):
- `block`: Guarda después de cada bloque minado ✅ **RECOMENDADO**
- `request`: Guarda después de cada request RPC (muy frecuente, más lento)
- `exit`: Guarda solo al salir correctamente (requiere `kill <PID>`, NO `kill -9`)

**Limitación crítica**: Esta versión **NO soporta `--load-path`**, por lo que:
- ✅ El archivo `.pkl` se crea correctamente
- ❌ Pero NO se puede usar para restaurar el estado
- ❌ Al reiniciar el devnet, empieza desde cero

**Resultado**: Tienes un **backup del estado** pero no verdadera persistencia.

### 🔐 Cuenta Predeployada

Con `--seed 0`, siempre obtendrás la misma cuenta:

```
Address: 0x34ba56f92265f0868c57d3fe72ecab144fc96f97954bbbc4252cef8e8a979ba
Private Key: 0x00c1cf1490de1352865301bb8705143f3ef938f97fdf892f1090dcb5ac7bcd1d
Public Key: 0x04486e2308d4bididied9c38de21c34ee22f443814c314611c08c9e12a24e5
```

---

## 🛠️ Comandos Útiles

### Detener el Devnet

```bash
# Opción 1: Buscar el proceso
ps aux | grep starknet-devnet

# Opción 2: Matar por nombre
pkill -f starknet-devnet

# Opción 3: Matar por puerto
lsof -ti:5050 | xargs kill -9
```

### Reiniciar el Devnet (manteniendo datos)

```bash
# 1. Detener el devnet actual
pkill -f starknet-devnet

# 2. Iniciar de nuevo
./start-devnet-persistent.sh
```

Los contratos desplegados **seguirán ahí** ✅

### Limpiar la Base de Datos (empezar de cero)

```bash
# Opción 1: Usar el script
./clean_devnet.sh

# Opción 2: Manual
pkill -f starknet-devnet
rm -rf ./devnet-data
./start-devnet-persistent.sh
```

### Hacer Backup de los Datos

```bash
./backup-current-devnet.sh
```

Esto creará un archivo `devnet-backup-YYYY-MM-DD-HH-MM-SS.tar.gz`

### Restaurar desde Backup

```bash
# 1. Detener devnet
pkill -f starknet-devnet

# 2. Restaurar backup
tar -xzf devnet-backup-2025-10-08-14-30-00.tar.gz
mv devnet-data ./

# 3. Reiniciar devnet
./start-devnet-persistent.sh
```

---

## 🎯 Workflow de Desarrollo con starknet-devnet 0.5.1

### Cada vez que desarrolles:

```bash
# 1. Iniciar devnet con guardado de estado
./start-devnet-persistent.sh

# 2. En otra terminal, desplegar contratos
cd packages/snfoundry
yarn deploy

# 3. En otra terminal, iniciar frontend
cd packages/nextjs
yarn start

# 4. Desarrollar tu dapp...
```

### ⚠️ Al reiniciar (día siguiente):

```bash
# 1. Iniciar devnet (estado se pierde, empieza limpio)
./start-devnet-persistent.sh

# 2. REDESPLEGAR contratos (necesario porque se perdió el estado)
cd packages/snfoundry
yarn deploy

# 3. Iniciar frontend
cd packages/nextjs
yarn start

# ❌ Los contratos del día anterior NO están disponibles
# ✅ Pero tienes el backup en devnet_dump.pkl para análisis
```

### Ventaja de usar --seed 0:

Aunque tienes que redesplegar, con `--seed 0`:
- Las **direcciones de cuentas** son siempre las mismas
- Las **claves privadas** son predecibles
- El **setup inicial** es consistente

### Cuando necesites cambiar contratos

```bash
# 1. Editar contrato en packages/snfoundry/contracts/src/

# 2. Redesplegar (nueva versión)
cd packages/snfoundry
yarn deploy

# El nuevo contrato se desplegará y se guardará en el dump
```

---

## 🔍 Verificar Estado del Devnet

### Ver Bloques

```bash
curl http://127.0.0.1:5050/blocks
```

### Ver Transacciones

```bash
curl http://127.0.0.1:5050/transactions
```

### Ver Contratos Desplegados

Los contratos se guardan en:

```
packages/snfoundry/deployments/devnet_latest.json
```

### Consultar Balance de Cuenta

```bash
# Usando sncast
sncast account fetch-balance \
  --address 0x34ba56f92265f0868c57d3fe72ecab144fc96f97954bbbc4252cef8e8a979ba \
  --url http://127.0.0.1:5050
```

---

## ⚠️ Problemas Comunes

### Error: "Address already in use"

**Causa**: Ya hay un devnet corriendo en el puerto 5050

**Solución**:
```bash
# Matar el proceso existente
lsof -ti:5050 | xargs kill -9

# Reintentar
./start-devnet-persistent.sh
```

### Error: El archivo .pkl no se guarda

**Causa**: El devnet se detuvo con `kill -9` o forzadamente

**Solución**:
```bash
# Siempre usar kill normal (no -9)
kill <PID>

# O usar pkill sin -9
pkill starknet-devnet

# Para mayor seguridad, usa --dump-on transaction
# (edita el script y cambia "exit" por "transaction")
```

### Los Contratos No Persisten

**Causa**: El devnet se inició sin `--dump-path` o se detuvo incorrectamente

**Solución**: 
```bash
# 1. Asegúrate de usar el script
./start-devnet-persistent.sh

# 2. Detén el devnet correctamente (NO con kill -9)
kill <PID>

# 3. Verifica que existe el archivo
ls -lh ./devnet-data/devnet_dump.pkl
```

### Archivo de Persistencia Muy Grande

**Causa**: Acumulación de datos históricos en el archivo .pkl

**Solución**:
```bash
# Ver tamaño
du -h ./devnet-data/devnet_dump.pkl

# Hacer backup y limpiar
./backup-current-devnet.sh
./clean_devnet.sh

# O simplemente eliminar y empezar de nuevo
rm -f ./devnet-data/devnet_dump.pkl
```

---

## 🔄 Migrar desde Devnet Normal

Si ya estabas usando devnet normal y quieres migrar:

### 1. Hacer Backup de Deployments

```bash
cp packages/snfoundry/deployments/devnet_latest.json \
   packages/snfoundry/deployments/devnet_latest.json.backup
```

### 2. Detener Devnet Normal

```bash
# Si lo iniciaste con yarn chain:
# Ctrl+C en la terminal

# O matar el proceso:
pkill -f starknet-devnet
```

### 3. Iniciar Devnet Persistente

```bash
./start-devnet-persistent.sh
```

### 4. Redesplegar Contratos

```bash
cd packages/snfoundry
yarn deploy
```

### 5. Actualizar Frontend

El frontend automáticamente usará los nuevos contratos desplegados en `deployedContracts.ts`

---

## 📊 Comparación: Normal vs Con Guardado (versión 0.5.1)

| Característica | Devnet Normal | Devnet con --dump-path |
|----------------|---------------|----------------------|
| **Persistencia** | ❌ Se pierde al reiniciar | ❌ Se pierde al reiniciar |
| **Backup del estado** | ❌ No guarda nada | ✅ Archivo .pkl con snapshot |
| **Velocidad inicio** | ⚡ Más rápido | ⚡ Igual de rápido |
| **Uso de disco** | 💾 Mínimo (0 KB) | 💾 ~300-500KB por archivo |
| **Testing limpio** | ✅ Siempre desde cero | ✅ Siempre desde cero |
| **Desarrollo continuo** | ❌ Redesplegar siempre | ❌ Redesplegar siempre |
| **Debugging** | ⚠️ Sin historia exportable | ✅ Historia exportada en .pkl |
| **Cuentas predecibles** | ✅ Con --seed 0 | ✅ Con --seed 0 |

### Comparación con starknet-devnet-rs (versión Rust)

| Característica | 0.5.1 (Python) | devnet-rs (Rust) |
|----------------|----------------|------------------|
| **Persistencia real** | ❌ No soportada | ✅ Con --load-path |
| **Base de datos** | ❌ Solo dumps | ✅ SQLite con --db-path |
| **Recarga automática** | ❌ No | ✅ Sí |
| **Rendimiento** | 🐢 Más lento | ⚡ Mucho más rápido |
| **Mantenimiento** | ⚠️ Versión legacy | ✅ Versión activa |

---

## 🎓 Mejores Prácticas con starknet-devnet 0.5.1

### 1. **Usa --seed 0 para Consistencia**

Aunque no hay persistencia real, el seed garantiza:
- ✅ Mismas cuentas pre-desplegadas siempre
- ✅ Mismas claves privadas
- ✅ Setup predecible para testing

### 2. **Guarda el deployment info en Git**

El archivo `devnet_latest.json` es más importante sin persistencia:

```bash
# Siempre commitear después de desplegar
git add packages/snfoundry/deployments/devnet_latest.json
git commit -m "Deploy: YourContract v1.2.3"
```

### 3. **Los archivos .pkl son para Debugging**

No intentes usarlos para "restaurar" estado:
- ✅ Úsalos para análisis de errores
- ✅ Compártelos con el equipo para reproducir bugs
- ❌ No esperes que el devnet los cargue automáticamente

### 4. **Automatiza el Redespliegue**

Crea un script que haga todo:

```bash
#!/bin/bash
# deploy-and-start.sh
./start-devnet-persistent.sh
sleep 3
cd packages/snfoundry && yarn deploy
cd ../nextjs && yarn dev
```

### 5. **Considera Actualizar a devnet-rs**

Para verdadera persistencia, actualiza a la versión Rust:

```bash
# Instalar starknet-devnet-rs
cargo install starknet-devnet
# O con un gestor de paquetes
```

### 6. **Limpia los .pkl Periódicamente**

```bash
# Los archivos .pkl crecen con el tiempo
rm -f ./devnet-data/devnet_dump.pkl

# O usa el script
./clean_devnet.sh
```

---

## 🔗 Integración con Scaffold-Stark 2

### Frontend (packages/nextjs)

Tu configuración en `scaffold.config.ts` ya apunta al puerto correcto:

```typescript
import { chains } from "@starknet-react/chains";

const scaffoldConfig = {
  targetNetworks: [chains.devnet], // Puerto 5050 por defecto
  // ...
};
```

### Contratos (packages/snfoundry)

El deployment en `scripts-ts/deploy.ts` usa el puerto 5050 automáticamente.

### URLs de Conexión

```typescript
// Devnet persistente
NEXT_PUBLIC_DEVNET_PROVIDER_URL=http://127.0.0.1:5050
```

---

## 📚 Recursos Adicionales

- [Documentación Starknet Devnet](https://github.com/0xSpaceShard/starknet-devnet-rs)
- [Scaffold-Stark 2 Docs](https://www.scaffoldstark.com/)
- [Starknet Foundry](https://foundry-rs.github.io/starknet-foundry/)

---

## 🆘 Soporte

Si tienes problemas:

1. Revisa la sección "Problemas Comunes"
2. Verifica los logs del devnet en la terminal
3. Intenta limpiar y reiniciar: `./clean_devnet.sh && ./start-devnet-persistent.sh`
4. Restaura desde un backup conocido funcional

---

## 📝 Notas Finales sobre starknet-devnet 0.5.1

### ✅ Lo que tienes:
- **Guardado automático** del estado en archivos `.pkl`
- **Cuentas predecibles** con `--seed 0`
- **Backup para debugging** y análisis
- **Setup consistente** en cada reinicio

### ❌ Lo que NO tienes:
- **Persistencia real** entre reinicios
- **Recarga automática** del estado
- **Ahorro de tiempo** en redespliegues

### 💡 Recomendaciones:

1. **Para desarrollo casual**: Esta versión está bien, solo recuerda redesplegar
2. **Para desarrollo serio**: Considera actualizar a `starknet-devnet-rs` para persistencia real
3. **Para producción**: Siempre usa Sepolia o Mainnet, no devnet

### 🚀 Actualizar a starknet-devnet-rs:

```bash
# Con cargo (requiere Rust)
cargo install starknet-devnet

# O descarga binarios desde:
# https://github.com/0xSpaceShard/starknet-devnet-rs/releases
```

Con devnet-rs obtendrías:
- ✅ Persistencia REAL con `--load-path`
- ✅ Base de datos SQLite con `--db-path`
- ✅ Mejor rendimiento (3-5x más rápido)
- ✅ Mantenimiento activo

### 📚 Recursos:

- [starknet-devnet (Python)](https://github.com/Shard-Labs/starknet-devnet) - Versión que usas
- [starknet-devnet-rs (Rust)](https://github.com/0xSpaceShard/starknet-devnet-rs) - Versión recomendada
- [Scaffold-Stark 2 Docs](https://www.scaffoldstark.com/)

---

¡Feliz desarrollo con Starknet! 🚀⚡

---

## 📋 Resumen Ejecutivo (TL;DR)

**Tu situación actual:**
- ✅ Tienes `starknet-devnet 0.5.1` funcionando
- ✅ El script `./start-devnet-persistent.sh` funciona correctamente
- ✅ Se crea el archivo `devnet_dump.pkl` con el estado (~300KB)

**Lo importante:**
- ⚠️ Esta versión **NO tiene persistencia real**
- ⚠️ Cada reinicio del devnet empieza desde cero
- ⚠️ Debes **redesplegar contratos** cada vez

**Lo bueno:**
- ✅ Con `--seed 0` las cuentas son predecibles
- ✅ Tienes backups automáticos del estado para debugging
- ✅ El setup es consistente

**Solución para persistencia real:**
- 🚀 Actualizar a `starknet-devnet-rs` (versión Rust)
- 📦 `cargo install starknet-devnet`

---

**Recuerda**: Esta guía describe las limitaciones reales de la versión 0.5.1. Para verdadera persistencia, actualiza a devnet-rs.

