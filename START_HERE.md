# 🎯 START HERE - Guía de Inicio para Devnet

> **📅 Creado:** Octubre 2025  
> **🎯 Propósito:** Punto de entrada a toda la documentación de devnet del proyecto

---

## 🚀 ¡Bienvenido!

Esta es tu guía de inicio para trabajar con **Starknet Devnet** en Scaffold-Stark 2.

Si es tu **primera vez aquí**, sigue esta página en orden. Si ya conoces el proyecto, ve directo a [Quick Start](#-quick-start-30-segundos).

---

## ⚡ Quick Start (30 segundos)

Si solo quieres **empezar a trabajar YA**:

```bash
# Ejecuta este comando:
./quick-start.sh

# Espera ~30 segundos

# ¡Listo! Ahora inicia el frontend:
cd packages/nextjs && yarn start
```

**Eso es todo.** El script hace todo automáticamente.

---

## 📚 Documentación Disponible

Este proyecto tiene la siguiente documentación sobre devnet:

### 📄 1. QUICK_START_README.md (Lee esto primero) ⭐
**Archivo:** [`QUICK_START_README.md`](./QUICK_START_README.md)  
**Tamaño:** 3.6 KB  
**Tiempo de lectura:** 5 minutos

**Contenido:**
- 🎯 Workflow recomendado día a día
- 📋 Lista de scripts disponibles
- 💡 Comandos útiles
- 🔑 Direcciones predecibles (seed 0)
- ⚡ Tips prácticos

**Léelo si:**
- ✅ Es tu primera vez con el proyecto
- ✅ Quieres empezar rápido
- ✅ Necesitas una referencia rápida

---

### 📖 2. DEVNET_PERSISTENTE.md (Guía técnica completa)
**Archivo:** [`DEVNET_PERSISTENTE.md`](./DEVNET_PERSISTENTE.md)  
**Tamaño:** 16 KB  
**Tiempo de lectura:** 15-20 minutos

**Contenido:**
- 🔍 Explicación profunda de starknet-devnet 0.5.1
- ⚠️ Limitaciones de la versión actual
- 📊 Comparación: Normal vs Dump vs devnet-rs
- 🛠️ Configuración detallada
- 🎯 Workflow completo de desarrollo
- 🔧 Comandos avanzados
- ❓ Troubleshooting detallado
- 📝 Mejores prácticas
- 💡 Recomendaciones para actualizar

**Léelo si:**
- ✅ Quieres entender cómo funciona todo
- ✅ Necesitas resolver problemas específicos
- ✅ Te interesa la arquitectura técnica
- ✅ Quieres saber por qué no hay persistencia real

---

### 📋 3. DEVNET_SCRIPTS.md (Documentación de scripts legacy)
**Archivo:** [`DEVNET_SCRIPTS.md`](./DEVNET_SCRIPTS.md)  
**Tamaño:** 12 KB  
**Nota:** Documento pre-existente del proyecto

**Léelo si:**
- ✅ Necesitas referencias de scripts antiguos
- ✅ Quieres entender otros scripts del proyecto

---

## 🔧 Scripts Ejecutables

### 🌟 1. quick-start.sh (El Script Principal) ⭐⭐⭐

**Archivo:** `./quick-start.sh`  
**Uso:** `./quick-start.sh`

**¿Qué hace?**
1. ✅ Detecta si hay devnet corriendo
2. 🛑 Lo detiene si existe
3. 🧹 Limpia dumps previos (evita conflictos)
4. 📡 Inicia devnet con seed 0
5. ⏳ Espera a que esté listo
6. 📦 Despliega todos los contratos
7. 📊 Muestra resumen con direcciones y cuentas

**Tiempo total:** ~30 segundos

**Úsalo cuando:**
- ✅ Empiezas tu día de desarrollo
- ✅ Necesitas resetear todo
- ✅ Quieres todo listo rápido

**Salida típica:**
```
🚀 Quick Start - Scaffold-Stark 2
📡 Iniciando Starknet Devnet...
⏳ Esperando a que el devnet esté listo...
✅ Devnet listo!
📦 Desplegando contratos...
✅ ¡Todo listo para desarrollar!

📊 Información del Devnet:
  🌐 URL: http://127.0.0.1:5050
  🆔 PID: 12345

📦 Contratos Desplegados:
  ✅ 0x1ddbf6eb3a5217e1b42cc2fd90ef6e50bd35bd333b49764b0207b5de298a31a
```

---

### 🔧 2. start-devnet-persistent.sh (Solo Devnet)

**Archivo:** `./start-devnet-persistent.sh`  
**Uso:** `./start-devnet-persistent.sh`

**¿Qué hace?**
1. 📡 Inicia devnet en puerto 5050
2. 💾 Guarda estado en `devnet_dump.pkl`
3. ⚠️ Muestra advertencias sobre limitaciones

**NO despliega contratos** (lo haces manualmente después)

**Úsalo cuando:**
- ✅ Solo necesitas el devnet corriendo
- ✅ Vas a desplegar manualmente
- ✅ Estás haciendo pruebas específicas

---

## 📁 Estructura de Archivos

```
/home/user/testing/realNFT/
│
├── 📖 START_HERE.md               ← ¡Estás aquí! Punto de entrada
│
├── 📚 Documentación:
│   ├── QUICK_START_README.md      ← Guía rápida (lee primero)
│   ├── DEVNET_PERSISTENTE.md      ← Guía técnica completa
│   └── DEVNET_SCRIPTS.md          ← Scripts legacy
│
├── 🚀 Scripts Principales:
│   ├── quick-start.sh             ← TODO-EN-UNO ⭐
│   └── start-devnet-persistent.sh ← Solo devnet
│
├── 🛠️ Scripts Auxiliares:
│   ├── backup-current-devnet.sh   ← Backups
│   ├── clean_devnet.sh            ← Limpieza
│   └── reset-devnet-data.sh       ← Reset completo
│
└── 📦 Datos:
    └── devnet-data/               ← Dumps del devnet
        └── devnet_dump.pkl        ← Estado guardado
```

---

## 🎯 Flujo de Trabajo Recomendado

### 🌅 Al empezar tu día:

```bash
# 1. Ejecuta el quick-start
./quick-start.sh

# 2. Inicia el frontend en otra terminal
cd packages/nextjs
yarn start

# 3. ¡A desarrollar! 🎨
```

### 💻 Durante el desarrollo:

- El devnet sigue corriendo en background
- Los contratos están desplegados
- Solo modificas tu código

### 🌙 Al terminar tu día:

```bash
# Detener el devnet (opcional, o déjalo corriendo)
pkill starknet-devnet
```

### 🌅 Al día siguiente:

```bash
# Volver a ejecutar quick-start
./quick-start.sh

# ✅ Los contratos tendrán las MISMAS direcciones
# Gracias a --seed 0
```

---

## ⚠️ Información Importante

### 🔴 Sobre la Persistencia

Tu proyecto usa **starknet-devnet 0.5.1** (versión Python):

❌ **NO tiene persistencia real** entre reinicios  
✅ **Con --seed 0**, las direcciones son predecibles  
✅ **Solución**: El script `quick-start.sh` redesplega automáticamente

**¿Por qué?** La versión 0.5.1 puede **guardar** el estado pero **NO puede recargarlo**. 

**Lee más:** [`DEVNET_PERSISTENTE.md`](./DEVNET_PERSISTENTE.md) para detalles técnicos.

---

### 🎯 Direcciones Predecibles (--seed 0)

Gracias a usar `--seed 0`, siempre obtienes:

#### 💰 Cuenta Predeployada:
```
Address:     0x064b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691
Private Key: 0x0000000000000000000000000000000071d7bb07b9a64f6f78ac4c816aff4da9
Public Key:  0x039d9e6ce352ad4530a0ef5d5a18fd3303c3606a7fa6ac5b620020ad681cc33b
Balance:     1000 ETH y FRI
```

#### 📦 Contrato YourCollectible:
```
Address: 0x1ddbf6eb3a5217e1b42cc2fd90ef6e50bd35bd333b49764b0207b5de298a31a
```

*Siempre la misma dirección si despliegas en el mismo orden*

---

## 🛠️ Comandos Útiles

### Ver si devnet está corriendo:
```bash
curl http://127.0.0.1:5050/is_alive
# Respuesta: "Alive!!!"
```

### Ver el proceso del devnet:
```bash
ps aux | grep starknet-devnet
```

### Detener el devnet:
```bash
pkill starknet-devnet
```

### Ver logs del devnet:
```bash
cat /tmp/devnet.log
```

### Desplegar contratos manualmente:
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

## 🆘 ¿Problemas?

### Error: "Port 5050 already in use"
```bash
# Detener el proceso en ese puerto
pkill starknet-devnet
# O forzar:
lsof -ti:5050 | xargs kill -9
```

### Error: "Contract already deployed"
```bash
# Limpiar dump y reiniciar
pkill starknet-devnet
rm -f ./devnet-data/devnet_dump.pkl
./quick-start.sh
```

### El devnet no responde
```bash
# Ver los logs
cat /tmp/devnet.log

# Reiniciar todo
./quick-start.sh
```

**Más troubleshooting:** Lee [`DEVNET_PERSISTENTE.md`](./DEVNET_PERSISTENTE.md) sección "Problemas Comunes"

---

## 📖 Orden de Lectura Recomendado

### Para principiantes:
1. 📄 `START_HERE.md` (este documento) - 10 min
2. 📄 `QUICK_START_README.md` - 5 min
3. 🚀 Ejecutar `./quick-start.sh`
4. 💻 ¡Empezar a desarrollar!

### Para usuarios avanzados:
1. 📄 `START_HERE.md` (referencia rápida)
2. 📖 `DEVNET_PERSISTENTE.md` (entender todo)
3. 🚀 Ejecutar `./quick-start.sh`

---

## 🎓 Recursos Adicionales

### Documentación Oficial:
- 🌐 [Scaffold-Stark 2](https://www.scaffoldstark.com/)
- 🌐 [Starknet Docs](https://docs.starknet.io/)
- 🌐 [starknet-devnet (Python)](https://github.com/Shard-Labs/starknet-devnet)
- 🌐 [starknet-devnet-rs (Rust)](https://github.com/0xSpaceShard/starknet-devnet-rs)

### Actualizar a devnet-rs (para persistencia real):
```bash
# Instalar Rust primero
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Instalar devnet-rs
cargo install starknet-devnet
```

---

## 💡 Tips Finales

1. ✅ **Siempre usa `quick-start.sh`** - Más rápido y confiable
2. ✅ **No uses `kill -9`** - Usa `pkill starknet-devnet`
3. ✅ **Commitea `devnet_latest.json`** - Importante sin persistencia
4. ✅ **Usa `--seed 0`** - Direcciones predecibles
5. ✅ **Lee `DEVNET_PERSISTENTE.md`** - Para entender limitaciones

---

## 📊 Resumen Ejecutivo

### ✅ Lo que TIENES:
- Script `quick-start.sh` que hace todo automáticamente
- Direcciones predecibles con `--seed 0`
- Guardado de estado para debugging
- Setup consistente en 30 segundos

### ❌ Lo que NO TIENES:
- Persistencia real entre reinicios
- Recarga automática del estado
- Base de datos permanente

### 💡 Solución:
- Usa `./quick-start.sh` cada día (30 seg)
- O actualiza a `starknet-devnet-rs` para persistencia real

---

## 🚀 ¡Empieza Ahora!

```bash
# Paso 1: Ejecuta el quick-start
./quick-start.sh

# Paso 2: Espera ~30 segundos

# Paso 3: Inicia el frontend
cd packages/nextjs && yarn start

# Paso 4: Abre http://localhost:3000

# ¡Listo para desarrollar! 🎨
```

---

## 📞 Siguiente Paso

👉 **Lee ahora:** [`QUICK_START_README.md`](./QUICK_START_README.md)

---

¡Feliz desarrollo con Starknet! 🚀⚡

---

**Creado por:** Claude (AI Assistant)  
**Fecha:** Octubre 2025  
**Versión:** 1.0  
**Proyecto:** Scaffold-Stark 2 - realNFT

