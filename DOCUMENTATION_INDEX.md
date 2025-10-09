# 📚 Documentation Index - realNFT Project

> Índice completo de toda la documentación del proyecto Scaffold-Stark 2

**Última actualización:** Octubre 2025  
**Versión del proyecto:** Scaffold-Stark 2  
**Devnet version:** starknet-devnet 0.5.1 (Python)

---

## 🚀 Quick Access

| Documento | Descripción | Lectura | Prioridad |
|-----------|-------------|---------|-----------|
| [START_HERE.md](#-start_heremd) | Punto de entrada principal | 10 min | ⭐⭐⭐ |
| [QUICK_START_README.md](#-quick_start_readmemd) | Guía rápida práctica | 5 min | ⭐⭐⭐ |
| [DEBUGGING.md](#-debuggingmd) | Info del contrato + debug | 8 min | ⭐⭐ |
| [FRONTEND_INTEGRATION.md](#-frontend_integrationmd) | Ejemplos de frontend | 15 min | ⭐⭐⭐ |
| [DEVNET_PERSISTENTE.md](#-devnet_persistentemd) | Guía técnica completa | 20 min | ⭐ |

---

## 📖 Documentos Disponibles

### 🎯 START_HERE.md
**Ubicación:** `/home/user/testing/realNFT/START_HERE.md`  
**Tamaño:** 9.7 KB  
**Prioridad:** ⭐⭐⭐ ALTA

**Descripción:**
Punto de entrada principal del proyecto. Contiene:
- Quick start en 30 segundos
- Índice de toda la documentación
- Guía de scripts disponibles
- Estructura de archivos del proyecto
- Workflow recomendado día a día
- Información sobre persistencia
- Direcciones predecibles
- Comandos útiles
- Troubleshooting rápido

**Léelo si:**
- ✅ Es tu primera vez en el proyecto
- ✅ Necesitas una visión general
- ✅ Quieres saber qué documentos leer

**Contenido principal:**
```
1. Quick Start (30 segundos)
2. Documentación disponible
3. Scripts ejecutables
4. Estructura de archivos
5. Flujo de trabajo
6. Información importante
7. Comandos útiles
8. Troubleshooting
9. Orden de lectura
10. Tips finales
```

---

### ⚡ QUICK_START_README.md
**Ubicación:** `/home/user/testing/realNFT/QUICK_START_README.md`  
**Tamaño:** 3.6 KB  
**Prioridad:** ⭐⭐⭐ ALTA

**Descripción:**
Guía práctica de inicio rápido. Contiene:
- Scripts disponibles y cuándo usarlos
- Workflow recomendado (mañana, día, noche)
- Comandos útiles más comunes
- Información sobre direcciones predecibles
- Tips prácticos para el día a día

**Léelo si:**
- ✅ Ya leíste START_HERE.md
- ✅ Quieres una referencia rápida
- ✅ Necesitas recordar comandos comunes

**Contenido principal:**
```
1. Scripts Disponibles
   - quick-start.sh
   - start-devnet-persistent.sh
2. Workflow Recomendado
3. Información sobre Persistencia
4. Direcciones Predecibles
5. Comandos Útiles
```

---

### 🐛 DEBUGGING.md
**Ubicación:** `/home/user/testing/realNFT/DEBUGGING.md`  
**Tamaño:** Variable  
**Prioridad:** ⭐⭐ MEDIA-ALTA

**Descripción:**
Información del contrato desplegado y debugging. Contiene:
- Info detallada del contrato YourCollectible
- Address y Class Hash del contrato
- Cuenta de desarrollo predefinida
- Comandos de debugging
- Estado del devnet
- Problemas comunes y soluciones
- Redesplegar contratos
- Archivos importantes
- Enlaces útiles

**Léelo si:**
- ✅ Necesitas info del contrato actual
- ✅ Tienes problemas con el devnet
- ✅ Quieres debuggear tu aplicación
- ✅ Necesitas verificar deployments

**Contenido principal:**
```
1. Contrato Desplegado Actual
   - Address: 0x1ddbf6eb3a5217e1b42cc2fd90ef6e50bd35bd333b49764b0207b5de298a31a
   - Class Hash
   - Archivo fuente
2. Verificación del Contrato
3. Dirección Predecible
4. Cuenta de Desarrollo
5. Comandos de Debugging
6. Estado del Devnet
7. Problemas Comunes
8. Redesplegar Contratos
9. Archivos Importantes
10. Enlaces Útiles
```

---

### 🎨 FRONTEND_INTEGRATION.md
**Ubicación:** `/home/user/testing/realNFT/FRONTEND_INTEGRATION.md`  
**Tamaño:** Variable  
**Prioridad:** ⭐⭐⭐ ALTA

**Descripción:**
Guía completa para integrar el contrato con el frontend. Contiene:
- Información sobre el contrato YourCollectible
- Todas las funciones disponibles (lectura y escritura)
- 7 ejemplos completos de componentes React
- Mejores prácticas de frontend
- Manejo de errores
- Loading states
- Tips y recursos

**Léelo si:**
- ✅ Vas a desarrollar el frontend
- ✅ Necesitas ejemplos de código
- ✅ Quieres usar los hooks de Scaffold-Stark
- ✅ Necesitas componentes listos para usar

**Contenido principal:**
```
1. Sobre el Contrato
2. Funciones Disponibles
   - Escritura: mint_item, transfer_from, approve
   - Lectura: balance_of, owner_of, token_uri, total_supply
3. Ejemplos de Uso (7 componentes completos):
   - MyNFTs: Ver tus NFTs
   - MintNFT: Mintear un NFT
   - NFTCard: Mostrar un NFT
   - AllNFTs: Listar todos
   - TransferNFT: Transferir
   - NFTsByAddress: Ver NFTs por dirección
   - NFTEvents: Escuchar eventos
4. Ejemplo Completo: Página de NFTs
5. Tips y Mejores Prácticas
6. Recursos Adicionales
```

---

### 📖 DEVNET_PERSISTENTE.md
**Ubicación:** `/home/user/testing/realNFT/DEVNET_PERSISTENTE.md`  
**Tamaño:** 16 KB  
**Prioridad:** ⭐ BAJA (para usuarios avanzados)

**Descripción:**
Guía técnica completa sobre starknet-devnet 0.5.1. Contiene:
- Explicación profunda del devnet
- Limitaciones de la versión 0.5.1
- Comparación con devnet-rs
- Configuración detallada
- Workflow completo
- Comandos avanzados
- Troubleshooting extensivo
- Mejores prácticas
- Recomendaciones de actualización

**Léelo si:**
- ✅ Quieres entender la arquitectura técnica
- ✅ Necesitas resolver problemas complejos
- ✅ Te interesa actualizar a devnet-rs
- ✅ Quieres conocimiento profundo

**Contenido principal:**
```
1. ¿Qué es el Devnet con Guardado de Estado?
2. Limitaciones de starknet-devnet 0.5.1
3. Inicio Rápido
4. Estructura de Archivos
5. Configuración del Devnet
6. Comandos Útiles
7. Workflow de Desarrollo
8. Verificar Estado
9. Problemas Comunes
10. Migrar desde Devnet Normal
11. Comparación: Normal vs Dump vs devnet-rs
12. Mejores Prácticas
13. Integración con Scaffold-Stark 2
14. Recursos Adicionales
15. Resumen Ejecutivo (TL;DR)
```

---

## 🔧 Scripts Disponibles

### ⭐ quick-start.sh (Principal)
**Ubicación:** `/home/user/testing/realNFT/quick-start.sh`  
**Tamaño:** 3.4 KB  
**Permisos:** Ejecutable

**Descripción:**
Script todo-en-uno que prepara el entorno completo.

**Funcionalidad:**
1. Verifica si hay devnet corriendo
2. Detiene el devnet anterior si existe
3. Limpia dumps previos (evita conflictos)
4. Inicia devnet con seed 0
5. Espera a que esté listo
6. Despliega todos los contratos
7. Muestra resumen con colores

**Uso:**
```bash
./quick-start.sh
```

**Tiempo de ejecución:** ~30 segundos

**Cuándo usarlo:**
- ✅ Empezar tu día de desarrollo
- ✅ Necesitas resetear todo
- ✅ Quieres todo listo rápido

---

### 🔧 start-devnet-persistent.sh
**Ubicación:** `/home/user/testing/realNFT/start-devnet-persistent.sh`  
**Tamaño:** 1.6 KB  
**Permisos:** Ejecutable

**Descripción:**
Inicia solo el devnet con guardado de estado.

**Funcionalidad:**
1. Crea directorio de datos
2. Verifica si existe dump previo
3. Inicia devnet con configuración específica
4. Muestra información y advertencias

**Uso:**
```bash
./start-devnet-persistent.sh
```

**Cuándo usarlo:**
- ✅ Solo necesitas el devnet
- ✅ Vas a desplegar manualmente
- ✅ Estás haciendo pruebas específicas

---

## 📦 Información del Contrato

### YourCollectible NFT

**Tipo:** ERC721 (usando OpenZeppelin Cairo)  
**Address:** `0x1ddbf6eb3a5217e1b42cc2fd90ef6e50bd35bd333b49764b0207b5de298a31a`  
**Class Hash:** `0x6b018667ff971fdaa6c8cd1d94ff080c1d37e06af66fa6e322389c77fc408e8`  
**Archivo:** `packages/snfoundry/contracts/src/your_collectible.cairo`

**Características:**
- ✅ ERC721 estándar
- ✅ Enumerable (listar todos los NFTs)
- ✅ Ownable (solo owner puede mintear)
- ✅ URI Storage (metadata IPFS)
- ✅ Counter (IDs auto-incrementales)

**Funciones principales:**
- `mint_item(recipient, uri)` → u256
- `balance_of(account)` → u256
- `owner_of(token_id)` → ContractAddress
- `token_uri(token_id)` → ByteArray
- `transfer_from(from, to, token_id)`
- `total_supply()` → u256
- `name()` → "YourCollectible"
- `symbol()` → "YCB"

---

## 💰 Cuenta de Desarrollo (--seed 0)

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

## 🎯 Workflow Recomendado

### 🌅 Inicio del día:
```bash
# 1. Ejecutar quick-start
./quick-start.sh

# 2. Esperar ~30 segundos

# 3. Iniciar frontend
cd packages/nextjs && yarn start

# 4. ¡Desarrollar! 🎨
```

### 💻 Durante el desarrollo:
- El devnet sigue corriendo en background
- Los contratos están desplegados
- Solo modificas tu código
- Hot reload funciona normalmente

### 🌙 Fin del día:
```bash
# Detener devnet (opcional)
pkill starknet-devnet
```

---

## 🛠️ Comandos Más Usados

### Devnet:
```bash
# Iniciar todo
./quick-start.sh

# Solo devnet
./start-devnet-persistent.sh

# Detener
pkill starknet-devnet

# Ver si está corriendo
curl http://127.0.0.1:5050/is_alive

# Ver proceso
ps aux | grep starknet-devnet
```

### Deployment:
```bash
# Desplegar a devnet
cd packages/snfoundry && yarn deploy --network devnet

# Ver deployments
cat packages/snfoundry/deployments/devnet_latest.json
```

### Debugging:
```bash
# Ver logs del devnet
cat /tmp/devnet.log

# Ver logs del deployment
cat /tmp/deploy.log

# Ver contratos en frontend
cat packages/nextjs/contracts/deployedContracts.ts
```

---

## 🆘 Problemas Comunes

### 1. "Port 5050 already in use"
```bash
pkill starknet-devnet
# O forzar: lsof -ti:5050 | xargs kill -9
```

### 2. "Contract already deployed"
```bash
pkill starknet-devnet
rm -f ./devnet-data/devnet_dump.pkl
./quick-start.sh
```

### 3. "Connection refused"
```bash
./quick-start.sh
```

### 4. Contrato no responde
```bash
# Verificar deployment
cat packages/snfoundry/deployments/devnet_latest.json

# Redesplegar
./quick-start.sh
```

---

## 📂 Estructura del Proyecto

```
realNFT/
│
├── 📚 Documentación:
│   ├── START_HERE.md              ← Punto de entrada ⭐
│   ├── QUICK_START_README.md      ← Guía rápida
│   ├── DEBUGGING.md               ← Debug + info contrato
│   ├── FRONTEND_INTEGRATION.md    ← Ejemplos frontend
│   ├── DEVNET_PERSISTENTE.md      ← Guía técnica
│   └── DOCUMENTATION_INDEX.md     ← Este archivo
│
├── 🚀 Scripts:
│   ├── quick-start.sh             ← TODO-EN-UNO ⭐
│   ├── start-devnet-persistent.sh ← Solo devnet
│   ├── backup-current-devnet.sh
│   ├── clean_devnet.sh
│   └── reset-devnet-data.sh
│
├── 📦 Frontend (packages/nextjs/):
│   ├── app/                       ← Páginas Next.js
│   ├── components/                ← Componentes React
│   ├── contracts/                 ← Contratos desplegados
│   ├── hooks/                     ← Custom hooks
│   └── scaffold.config.ts         ← Configuración
│
├── 🔧 Contratos (packages/snfoundry/):
│   ├── contracts/src/             ← Código Cairo
│   │   └── your_collectible.cairo ← NFT contract
│   ├── deployments/               ← Info de deployments
│   │   └── devnet_latest.json
│   └── scripts-ts/                ← Scripts de deploy
│
└── 💾 Datos:
    └── devnet-data/
        └── devnet_dump.pkl        ← Estado guardado
```

---

## 🎓 Orden de Lectura Recomendado

### Para principiantes (primer día):
1. 📄 `START_HERE.md` (10 min) - Visión general
2. 📄 `QUICK_START_README.md` (5 min) - Práctica rápida
3. 🚀 Ejecutar `./quick-start.sh` - Preparar entorno
4. 📄 `DEBUGGING.md` (8 min) - Info del contrato
5. 📄 `FRONTEND_INTEGRATION.md` (15 min) - Ejemplos
6. 💻 ¡Empezar a desarrollar!

### Para usuarios experimentados:
1. 📄 `START_HERE.md` (lectura rápida)
2. 🚀 Ejecutar `./quick-start.sh`
3. 📄 `FRONTEND_INTEGRATION.md` (ejemplos directos)
4. 💻 ¡Desarrollar!

### Para debugging/troubleshooting:
1. 📄 `DEBUGGING.md` - Soluciones rápidas
2. 📄 `DEVNET_PERSISTENTE.md` - Problemas complejos

---

## ⚠️ Información Crítica

### Sobre la Persistencia:

❌ **starknet-devnet 0.5.1 NO tiene persistencia real**
- Solo guarda el estado, no puede recargarlo
- Cada reinicio empieza desde cero
- Debes redesplegar contratos cada vez

✅ **Pero tenemos una solución:**
- `--seed 0` hace que las direcciones sean predecibles
- `./quick-start.sh` redesplega automáticamente en 30 seg
- Siempre obtienes las mismas direcciones

💡 **Para persistencia real:**
- Actualizar a `starknet-devnet-rs` (versión Rust)
- O desplegar a Sepolia testnet

---

## 💡 Tips Esenciales

1. ✅ **Siempre usa `./quick-start.sh`** - Más rápido y confiable
2. ✅ **Lee START_HERE.md primero** - Te ahorrará tiempo
3. ✅ **Usa los ejemplos de FRONTEND_INTEGRATION.md** - Código listo
4. ✅ **Revisa DEBUGGING.md si hay problemas** - Soluciones rápidas
5. ✅ **Commitea devnet_latest.json** - Importante sin persistencia
6. ✅ **No uses kill -9** - Usa `pkill starknet-devnet`

---

## 🔗 Recursos Externos

### Documentación Oficial:
- [Scaffold-Stark 2](https://www.scaffoldstark.com/)
- [Starknet Docs](https://docs.starknet.io/)
- [OpenZeppelin Cairo](https://docs.openzeppelin.com/contracts-cairo/)
- [Starknet.js](https://www.starknetjs.com/)
- [Starknet-React](https://starknet-react.com/)

### Devnet:
- [starknet-devnet (Python)](https://github.com/Shard-Labs/starknet-devnet) - Tu versión
- [starknet-devnet-rs (Rust)](https://github.com/0xSpaceShard/starknet-devnet-rs) - Recomendada

### Exploradores (Testnet):
- [Voyager Sepolia](https://sepolia.voyager.online/)
- [Starkscan Sepolia](https://sepolia.starkscan.co/)
- [StarkCompass Sepolia](https://sepolia.starkcompass.com/)

### Faucets:
- [Starknet Faucet](https://starknet-faucet.vercel.app/)
- [Blast Faucet](https://blastapi.io/faucets/starknet-sepolia-eth)

---

## 📞 Siguiente Paso

👉 **Empieza aquí:** [`START_HERE.md`](./START_HERE.md)

```bash
# O ejecuta directamente:
./quick-start.sh
```

---

## 📊 Resumen Rápido (TL;DR)

**¿Qué tienes?**
- ✅ Scaffold-Stark 2 con devnet 0.5.1
- ✅ Script `quick-start.sh` que hace todo
- ✅ Contrato NFT (YourCollectible) listo
- ✅ Ejemplos de frontend completos
- ✅ Direcciones predecibles con seed 0

**¿Qué NO tienes?**
- ❌ Persistencia real entre reinicios
- ❌ Recarga automática del estado

**¿Solución?**
- 🚀 Usar `./quick-start.sh` cada día (30 seg)
- 📖 Seguir los ejemplos de FRONTEND_INTEGRATION.md
- 💡 O actualizar a devnet-rs para persistencia real

---

**¡Todo listo para desarrollar tu dApp de NFTs en Starknet!** 🎨🚀⚡

---

**Creado por:** Claude (AI Assistant)  
**Fecha:** Octubre 2025  
**Versión:** 1.0  
**Proyecto:** Scaffold-Stark 2 - realNFT  
**Última actualización de este índice:** Octubre 9, 2025

