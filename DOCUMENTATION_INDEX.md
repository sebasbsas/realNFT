# 📚 Documentation Index - realNFT Project (UPDATED)

> Índice completo de toda la documentación del proyecto Scaffold-Stark 2

**Última actualización:** Enero 2025  
**Versión del proyecto:** Scaffold-Stark 2  
**Estado:** ✅ 3 Frontends Funcionales + Configuración Unificada  
**Configuración:** Todos los contratos en `deployedContracts.ts`  

## 🚀 **FRONTENDS DISPONIBLES:**

| Frontend | URL | Contrato | IPFS | Estado |
|----------|-----|----------|------|--------|
| **QuestlyNFT** | `/mint` | QuestlyNFT | ✅ Requerido | ✅ Funcional |
| **QuestlyNFTStandard** | `/mint-standard` | QuestlyNFTStandard | ✅ Requerido | ✅ Funcional |
| **MinimalNFT** | `/mint-minimal` | MinimalNFT | ❌ No requerido | ✅ Funcional |

---

## 🚀 Quick Access (Actualizado)

| Documento | Descripción | Lectura | Estado |
|-----------|-------------|---------|--------|
| [QUICK_START_ALL_FRONTENDS.md](#quick-start-all-frontends) | Guía rápida para los 3 frontends | 5 min | ✅ Nuevo |
| [CONTRACTS_CONFIGURATION_UNIFIED.md](#contracts-configuration-unified) | Configuración unificada de contratos | 8 min | ✅ Nuevo |
| [MINT_STANDARD_IPFS_FIX.md](#mint-standard-ipfs-fix) | Corrección del frontend mint-standard | 5 min | ✅ Nuevo |
| [MINIMAL_NFT_CONFIGURATION_FIX.md](#minimal-nft-configuration-fix) | Fix configuración MinimalNFT | 5 min | ✅ Nuevo |
| [TROUBLESHOOTING_FRONTEND.md](#troubleshooting-frontend) | Solución problemas frontend | 10 min | ✅ Actualizado |
| [HOOKS_EXPORT_FIX.md](#hooks-export-fix) | Fix específico hooks Scaffold-Stark | 5 min | ✅ Actualizado |

---

## 📖 Documentos Disponibles

### 🎨 QUESTLY_NFT_MAINNET_MINT_INSTRUCTIONS.md
**Ubicación:** `/home/user/testing/realNFT/QUESTLY_NFT_MAINNET_MINT_INSTRUCTIONS.md`  
**Tamaño:** 15.2 KB  
**Prioridad:** ⭐⭐⭐ ALTA

**Descripción:**
Guía completa para mintear NFTs en el contrato QuestlyNFTStandard (ERC721 estándar) desplegado en Starknet Mainnet. Contiene:
- Información detallada del contrato QuestlyNFTStandard
- Implementación completa del estándar ERC721 con OpenZeppelin
- Compatibilidad total con exploradores (Starkscan, Voyager)
- Pasos completos para configurar y usar el frontend
- Validaciones y características de seguridad
- Solución de problemas específicos
- Ejemplos de uso y configuración
- Referencias técnicas del contrato

**Léelo si:**
- ✅ Quieres mintear NFTs en el contrato QuestlyNFT
- ✅ Necesitas entender cómo funciona el frontend de minteo
- ✅ Tienes problemas con el proceso de minteo

**Contenido principal:**
```
1. Información del contrato QuestlyNFT
2. Configuración del frontend
3. Cómo mintear NFTs paso a paso
4. Validaciones y seguridad
5. Solución de problemas
6. Funciones del contrato
```

---

### 🎨 QUESTLY_NFT_STANDARD_INSTRUCTIONS.md
**Ubicación:** `/home/user/testing/realNFT/QUESTLY_NFT_STANDARD_INSTRUCTIONS.md`  
**Tamaño:** 18.3 KB  
**Prioridad:** ⭐⭐⭐ ALTA

**Descripción:**
Guía completa para mintear NFTs en el contrato QuestlyNFTStandard (ERC721 estándar) desplegado en Starknet Mainnet. Contiene:
- Información detallada del contrato QuestlyNFTStandard
- Implementación completa del estándar ERC721 con OpenZeppelin
- Pasos completos para configurar y usar el frontend
- Validaciones y características de seguridad
- Diferencias con QuestlyNFT (personalizado vs estándar)
- Solución de problemas específicos
- Referencias técnicas del contrato

**Léelo si:**
- ✅ Quieres mintear NFTs estándar sin metadata personalizada
- ✅ Necesitas entender las diferencias entre QuestlyNFT y QuestlyNFTStandard
- ✅ Tienes problemas con el proceso de minteo estándar

**Contenido principal:**
```
1. Información del contrato QuestlyNFTStandard
2. Configuración del frontend
3. Cómo mintear NFTs estándar paso a paso
4. Diferencias con QuestlyNFT
5. Validaciones y seguridad
6. Solución de problemas
7. Funciones del contrato
```

---

### ⚡ QUICK_START_MINT_STANDARD.md
**Ubicación:** `/home/user/testing/realNFT/QUICK_START_MINT_STANDARD.md`  
**Tamaño:** 2.8 KB  
**Prioridad:** ⭐⭐⭐ ALTA

**Descripción:**
Guía súper rápida para empezar a mintear NFTs estándar inmediatamente. Contiene:
- Comandos esenciales (3 comandos)
- Pasos de minteo en 3 pasos (más simple)
- Checklist pre-minteo
- Comparación con QuestlyNFT
- Links de verificación
- Referencias a documentación completa

**Léelo si:**
- ✅ Quieres empezar a mintear NFTs estándar rápido
- ✅ Ya conoces el proceso y necesitas un resumen
- ✅ Necesitas comandos rápidos

**Contenido principal:**
```
1. Inicio rápido (3 comandos)
2. Mintear en 3 pasos (más simple)
3. Checklist pre-minteo
4. Diferencias con QuestlyNFT
5. Verificar NFT minteado
6. Referencias
```

---

### ⚡ QUICK_START_MINT.md
**Ubicación:** `/home/user/testing/realNFT/QUICK_START_MINT.md`  
**Tamaño:** 3.8 KB  
**Prioridad:** ⭐⭐⭐ ALTA

**Descripción:**
Guía rápida para empezar a mintear NFTs inmediatamente. Contiene:
- Comandos esenciales (3 comandos)
- Pasos de minteo en 4 pasos
- Checklist pre-minteo
- Links de verificación
- Referencias a documentación completa

**Léelo si:**
- ✅ Quieres empezar a mintear rápido
- ✅ Ya conoces el proceso y necesitas un resumen
- ✅ Necesitas comandos rápidos

**Contenido principal:**
```
1. Inicio rápido (3 comandos)
2. Mintear en 4 pasos
3. Checklist pre-minteo
4. Verificar NFT minteado
5. Referencias
```

---

### 🔧 TROUBLESHOOTING_FRONTEND.md
**Ubicación:** `/home/user/testing/realNFT/TROUBLESHOOTING_FRONTEND.md`  
**Tamaño:** 12.4 KB  
**Prioridad:** ⭐⭐ MEDIA

**Descripción:**
Guía completa de solución de problemas para el frontend de minteo. Contiene:
- 11 errores comunes y sus soluciones
- Comandos de diagnóstico
- Verificaciones paso a paso
- Logs útiles para debugging
- Checklist de verificación

**Léelo si:**
- ✅ Tienes errores al usar el frontend
- ✅ El servidor no inicia correctamente
- ✅ Hay problemas de conexión o configuración

**Contenido principal:**
```
1. Error: "Could not find a production build"
2. Error: "ENOENT: no such file or directory"
3. Error: "Module not found"
4. Error: "Failed to fetch"
5. Error: "Contract not found"
6. Error: "Wallet not connected"
7. Error: "Transaction failed"
8. Error: "URI invalid"
9. Error: "Page not found"
10. Error: "useScaffoldWriteContract is not a function"
11. Error: "Build failed"
+ Comandos de diagnóstico
```

---

### 🔧 HOOKS_EXPORT_FIX.md
**Ubicación:** `/home/user/testing/realNFT/HOOKS_EXPORT_FIX.md`  
**Tamaño:** 4.2 KB  
**Prioridad:** ⭐⭐ MEDIA

**Descripción:**
Documentación específica del fix aplicado para resolver el error "useScaffoldWriteContract is not a function". Contiene:
- Descripción detallada del problema
- Solución paso a paso
- Archivos modificados
- Comandos de verificación
- Estado antes y después del fix

**Léelo si:**
- ✅ Tienes el error "useScaffoldWriteContract is not a function"
- ✅ Quieres entender qué se corrigió exactamente
- ✅ Necesitas verificar que el fix se aplicó correctamente

**Contenido principal:**
```
1. Problema identificado
2. Solución aplicada
3. Hooks ahora disponibles
4. Estado actual
5. Verificación del fix
```

---

### 📊 SERVER_STATUS_LOG.md
**Ubicación:** `/home/user/testing/realNFT/SERVER_STATUS_LOG.md`  
**Tamaño:** 8.7 KB  
**Prioridad:** ⭐ BAJA

**Descripción:**
Log completo del estado actual del servidor y resumen de todos los problemas resueltos durante el desarrollo. Contiene:
- Logs completos del servidor Next.js
- Métricas de compilación y rendimiento
- Endpoints verificados y sus códigos de estado
- Configuración actual del servidor
- Comandos de monitoreo continuo

**Léelo si:**
- ✅ Quieres ver el estado completo del servidor
- ✅ Necesitas información técnica detallada
- ✅ Quieres entender el rendimiento del sistema

**Contenido principal:**
```
1. Logs del servidor
2. Problemas resueltos
3. Endpoints verificados
4. Módulos compilados
5. Configuración del servidor
6. Métricas de rendimiento
7. Monitoreo continuo
```

---

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

### 📋 list_tests.sh
**Ubicación:** `/home/user/testing/realNFT/list_tests.sh`  
**Tamaño:** 0.5 KB  
**Permisos:** Ejecutable

**Descripción:**
Lista todos los tests disponibles en el proyecto.

**Funcionalidad:**
1. Busca todas las funciones de test en test_contract.cairo
2. Las enumera y formatea
3. Muestra el total de tests
4. Proporciona comandos útiles

**Uso:**
```bash
./list_tests.sh
```

**Output ejemplo:**
```
📋 Tests disponibles en test_contract.cairo:

 1. test_mint_item
 2. test_mint_item2
 3. test_token_uri_of_nonexistent_token
 4. test_owner_of_nonexistent_token
 5. test_transfer_from_unauthorized
 6. test_balance_of_zero_address

Total de tests: 6
```

**Cuándo usarlo:**
- ✅ Quieres ver qué tests existen
- ✅ Necesitas el nombre exacto de un test
- ✅ Estás documentando nuevos tests

**Nota:** `snforge --list` no existe en la versión 0.50.0, por eso creamos este script.

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

---

## 🎯 MINIMAL_NFT_FRONTEND_GUIDE.md
**Ubicación:** `/home/user/testing/realNFT/MINIMAL_NFT_FRONTEND_GUIDE.md`  
**Tamaño:** 8.5 KB  
**Prioridad:** ⭐⭐ MEDIA

**Descripción:**
Guía completa del frontend para MinimalNFT - un contrato ERC721 básico SIN soporte IPFS. Contiene:
- Características del MinimalNFT (sin metadata)
- Acceso y navegación al frontend
- Funcionalidad de minting simple
- Configuración técnica del contrato
- Comparación con otros contratos del proyecto
- Casos de uso recomendados
- Información del contrato desplegado

**Léelo si:**
- Quieres usar el MinimalNFT (sin IPFS)
- Necesitas un NFT básico para pruebas
- Buscas una solución económica sin metadata
- Quieres entender las limitaciones del contrato

---

## ✅ MINIMAL_NFT_VERIFICATION_UPDATE.md
**Ubicación:** `/home/user/testing/realNFT/MINIMAL_NFT_VERIFICATION_UPDATE.md`  
**Tamaño:** 6.2 KB  
**Prioridad:** ⭐ MEDIA

**Descripción:**
Actualización de la verificación del MinimalNFT confirmando su existencia en mainnet. Contiene:
- Evidencia de que el contrato SÍ existe
- Corrección del análisis anterior
- Estado actualizado de todos los contratos
- Próximos pasos para integración
- Conclusiones y acciones requeridas

**Léelo si:**
- Quieres entender el estado real del MinimalNFT
- Necesitas verificar la existencia del contrato
- Buscas información actualizada sobre el deployment

---

## 📋 CONTRACTS_CLARIFICATION_GUIDE.md
**Ubicación:** `/home/user/testing/realNFT/CONTRACTS_CLARIFICATION_GUIDE.md`  
**Tamaño:** 7.8 KB  
**Prioridad:** ⭐⭐⭐ ALTA

**Descripción:**
Clarificación completa sobre qué contratos están realmente desplegados vs cuáles son solo de prueba. Contiene:
- Lista de los 3 contratos funcionales (desplegados en mainnet)
- Lista de todos los contratos de prueba/desarrollo
- Tabla comparativa detallada
- Explicación de por qué existen tantos contratos
- Recomendaciones de uso
- Estado real vs archivos de desarrollo

**Léelo si:**
- Quieres entender qué contratos usar realmente
- Te confunden los muchos archivos .cairo en el proyecto
- Necesitas saber cuáles son funcionales vs experimentales
- Quieres evitar usar contratos que no están desplegados

---

**¡Todo listo para desarrollar tu dApp de NFTs en Starknet!** 🎨🚀⚡

---

**Creado por:** Claude (AI Assistant)  
**Fecha:** Enero 2025  
**Versión:** 1.1  
**Proyecto:** Scaffold-Stark 2 - realNFT  
---

## 🔧 **NUEVOS DOCUMENTOS (Enero 2025):**

### **CONTRACTS_CONFIGURATION_UNIFIED.md**
**Estado:** ✅ Nuevo  
**Descripción:** Documentación completa de la unificación de contratos de `externalContracts.ts` a `deployedContracts.ts`

### **MINT_STANDARD_IPFS_FIX.md**  
**Estado:** ✅ Nuevo  
**Descripción:** Corrección del frontend `mint-standard` para incluir campo IPFS URI

### **MINIMAL_NFT_CONFIGURATION_FIX.md**
**Estado:** ✅ Nuevo  
**Descripción:** Fix para el error "Target Contract is not deployed" de MinimalNFT

### **CONTRACTS_CONFIGURATION_EXPLANATION.md**
**Estado:** ✅ Nuevo  
**Descripción:** Explicación detallada de las diferencias entre `externalContracts.ts` y `deployedContracts.ts`

### **QUICK_START_ALL_FRONTENDS.md**
**Estado:** ✅ Nuevo  
**Descripción:** Guía rápida actualizada para los 3 frontends funcionales

---

## 🎯 **ESTADO ACTUAL DEL PROYECTO:**

### ✅ **Funcionalidades Completadas:**
1. **3 Frontends Funcionales** - Todos operativos en Mainnet
2. **Configuración Unificada** - Todos los contratos en `deployedContracts.ts`
3. **Fix IPFS URI** - Frontend `mint-standard` corregido
4. **Fix MinimalNFT** - Error "Target Contract is not deployed" resuelto
5. **Documentación Completa** - Todos los cambios documentados

### 📊 **Contratos en Mainnet:**
| Contrato | Address | IPFS | Estado | Frontend |
|----------|---------|------|--------|----------|
| QuestlyNFT | `0x2cf4...0080` | ✅ | ✅ Funcional | `/mint` |
| QuestlyNFTStandard | `0x434c...f4aa` | ✅ | ✅ Funcional | `/mint-standard` |
| MinimalNFT | `0x7556...e88` | ❌ | ✅ Funcional | `/mint-minimal` |

### 🚀 **Comandos Rápidos:**
```bash
# Iniciar servidor de desarrollo
cd /home/user/testing/realNFT/packages/nextjs
yarn dev

# URLs de los frontends
# http://localhost:3000/mint          - QuestlyNFT (con IPFS)
# http://localhost:3000/mint-standard - QuestlyNFTStandard (con IPFS)  
# http://localhost:3000/mint-minimal  - MinimalNFT (sin IPFS)
```

---

**Última actualización de este índice:** Enero 2025

