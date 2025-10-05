# 🔧 Gestión de Versiones para Desarrollo Starknet

Esta documentación explica las versiones compatibles de las herramientas de Starknet según Cairo Coder MCP y cómo configurarlas usando `asdf` y otros gestores de versiones.

## 📊 Matriz de Compatibilidad de Versiones

### **RPC 0.9 (Recomendado para Desarrollo Actual)**

| Herramienta | Versión Recomendada | RPC Compatible |
|-------------|-------------------|----------------|
| **Starknet Foundry** | `0.49.0` | 0.9 |
| **Starknet Devnet** | `0.5.1` | 0.9 |
| **starknet.js** | `8.5.3` ✅ | 0.9 |
| **Scarb** | `2.12.0` | 0.9 |
| **Cairo** | `2.12.0` | 0.9 |
| **Sierra** | `1.7.0` | 0.9 |

> ✅ **Versiones Probadas y Funcionales**: Estas versiones han sido probadas y funcionan correctamente juntas. El proyecto speedrunstark utiliza exactamente estas versiones sin problemas de `resource_bounds`.

### **Configuración Crítica para resource_bounds**

Para que `starknet.js 8.5.3` funcione correctamente, es necesario configurar manualmente los `resource_bounds` en los scripts de deploy:

```typescript
// En deploy-contract.ts, para devnet:
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

### **Configuración Crítica del Scarb.toml**

El `Scarb.toml` debe coincidir exactamente con speedrunstark:

```toml
[dependencies]
starknet = ">=2.12.0"
openzeppelin_access = ">=2.0.0"
openzeppelin_token = ">=2.0.0"
openzeppelin_introspection = ">=2.0.0"

[dev-dependencies]
openzeppelin_utils = ">=2.0.0"
openzeppelin_testing = ">=4.6.0"
snforge_std = ">=0.49.0"

[[target.starknet-contract]]
casm = true # ¡CRÍTICO! Debe ser true, no false

[tool.scarb]
allow-prebuilt-plugins = ["snforge_std"]

[tool.fmt]
sort-module-level-items = true

[[tool.snforge.fork]]
name = "SEPOLIA_LATEST"
url = "https://starknet-sepolia.public.blastapi.io/rpc/v0_9" # RPC v0.9
block_id.tag = "latest"

[tool]
panic-backtrace = true
```

### **RPC 0.8 (Versión Anterior)**

| Herramienta | Versión Compatible | RPC Compatible |
|-------------|-------------------|----------------|
| **Starknet Foundry** | `0.39.0` | 0.8 |
| **Starknet Devnet** | `0.3.0` | 0.8 |
| **starknet.js** | `7.0.1` | 0.8 |
| **Scarb** | `2.8.5+` | 0.8 |
| **Cairo** | `2.8.5+` | 0.8 |

### **RPC 0.7 (Versión Legacy)**

| Herramienta | Versión Compatible | RPC Compatible |
|-------------|-------------------|----------------|
| **Starknet Foundry** | `0.27.0` | 0.7 |
| **Starknet Devnet** | `0.1.2` | 0.7 |
| **starknet.js** | `6.11.0` | 0.7 |
| **Scarb** | `2.6.0+` | 0.7 |
| **Cairo** | `2.6.0+` | 0.7 |

---

## 🚀 Instalación con Starkup (Recomendado)

### **Instalación Automática**

```bash
# Instalar todas las herramientas con versiones compatibles
curl --proto '=https' --tlsv1.2 -sSf https://sh.starkup.sh | sh
```

**Starkup instala automáticamente:**
- ✅ Scarb (última versión estable)
- ✅ Starknet Foundry (última versión estable)
- ✅ Starknet Devnet (última versión estable)
- ✅ Universal Sierra Compiler
- ✅ Cairo Profiler
- ✅ Cairo Coverage
- ✅ CairoLS

### **Verificación de Instalación**

```bash
# Verificar versiones instaladas
scarb --version
snforge --version && sncast --version
starknet-devnet --version
```

**Salida esperada:**
```console
scarb 2.11.4 (c0ef5ec6a 2025-04-09)
cairo: 2.11.4 (https://crates.io/crates/cairo-lang-compiler/2.11.4)
sierra: 1.7.0

snforge 0.48.1
sncast 0.48.1

starknet-devnet 0.4.3
```

---

## 🛠️ Instalación Manual con asdf

### **1. Instalar asdf**

```bash
# Linux/macOS
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc
source ~/.bashrc

# macOS con Homebrew
brew install asdf
echo -e '\n. $(brew --prefix asdf)/libexec/asdf.sh' >> ~/.bash_profile
```

### **2. Instalar Scarb**

```bash
# Agregar plugin de Scarb
asdf plugin add scarb

# Instalar versión específica para RPC 0.9
asdf install scarb 2.12.0

# Configurar globalmente
asdf set --home scarb 2.12.0

# Verificar instalación
scarb --version
```

### **3. Instalar Rust (Opcional para Scarb >= 2.10.0)**

```bash
# Solo necesario si usas Scarb < 2.10.0 o plataformas no soportadas
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Verificar versión (debe ser >= 1.80.1)
rustc --version
```

### **4. Instalar Starknet Foundry**

```bash
# Agregar plugin de Starknet Foundry
asdf plugin add starknet-foundry

# Instalar última versión estable
asdf install starknet-foundry latest

# Configurar globalmente
asdf set --home starknet-foundry latest

# Verificar instalación
snforge --version
sncast --version
```

### **5. Instalar Starknet Devnet**

```bash
# Agregar plugin de Starknet Devnet
asdf plugin add starknet-devnet

# Instalar última versión estable
asdf install starknet-devnet latest

# Configurar globalmente
asdf set --home starknet-devnet latest

# Verificar instalación
starknet-devnet --version
```

---

## 📁 Configuración por Proyecto

### **Archivo `.tool-versions`**

Crea un archivo `.tool-versions` en la raíz de tu proyecto para fijar versiones específicas:

```bash
# .tool-versions
scarb 2.12.0
starknet-foundry 0.48.0
starknet-devnet 0.5.0-rc.4
nodejs 22.0.0
```

### **Aplicar Versiones del Proyecto**

```bash
# En el directorio del proyecto
asdf install  # Instala las versiones especificadas en .tool-versions
```

---

## 🔄 Gestión de Versiones

### **Comandos Básicos de asdf**

```bash
# Listar versiones instaladas
asdf list

# Listar versiones disponibles
asdf list all scarb
asdf list all starknet-foundry
asdf list all starknet-devnet

# Cambiar versión global
asdf set --home scarb 2.12.0
asdf set --home starknet-foundry 0.48.0

# Cambiar versión para proyecto actual
asdf set --local scarb 2.12.0
asdf set --local starknet-foundry 0.48.0

# Actualizar a última versión
asdf install scarb latest
asdf set --home scarb latest
```

### **Configuración de Node.js para Frontend**

```bash
# Agregar plugin de Node.js
asdf plugin add nodejs

# Instalar versión específica
asdf install nodejs 22.0.0

# Configurar globalmente
asdf set --home nodejs 22.0.0

# Verificar instalación
node --version
npm --version
```

---

## ⚙️ Configuración de Variables de Entorno

### **Archivo `.env` para el Proyecto**

```bash
# packages/snfoundry/.env
# Versiones compatibles RPC 0.9
STARKNET_FOUNDRY_VERSION=0.48.0
STARKNET_DEVNET_VERSION=0.5.0-rc.4
SCARB_VERSION=2.12.0
STARKNET_JS_VERSION=8.0.0-beta.4

# Configuración de red
RPC_URL_DEVNET=http://127.0.0.1:5050
RPC_URL_SEPOLIA=https://starknet-sepolia.public.blastapi.io/rpc/v0_9
RPC_URL_MAINNET=https://starknet-mainnet.public.blastapi.io/rpc/v0_9
```

### **Script de Verificación de Versiones**

```bash
#!/bin/bash
# verify_versions.sh

echo "🔍 Verificando versiones de herramientas Starknet..."
echo ""

echo "📦 Scarb:"
scarb --version
echo ""

echo "🔨 Starknet Foundry:"
snforge --version
sncast --version
echo ""

echo "🌐 Starknet Devnet:"
starknet-devnet --version
echo ""

echo "📱 Node.js:"
node --version
npm --version
echo ""

echo "📚 asdf:"
asdf --version
echo ""

echo "✅ Verificación completada"
```

---

## 🔧 Configuración de package.json

### **Versiones de Dependencias Recomendadas**

```json
{
  "dependencies": {
    "starknet": "8.0.0-beta.4",
    "@starknet-react/core": "latest",
    "@starknet-react/chains": "latest"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "@types/node": "^20.0.0"
  }
}
```

### **Scripts de Configuración**

```json
{
  "scripts": {
    "setup:versions": "asdf install",
    "verify:versions": "./verify_versions.sh",
    "update:tools": "asdf update && asdf plugin update --all",
    "reset:versions": "rm .tool-versions && asdf install"
  }
}
```

---

## 🚨 Solución de Problemas

### **Error: "No version set"**

```bash
# Establecer versión global
asdf set --home scarb latest
asdf set --home starknet-foundry latest

# O establecer para proyecto específico
asdf set --local scarb 2.11.4
```

### **Error: "Invalid Rust version"**

```bash
# Actualizar Rust
rustup update

# Verificar versión (debe ser >= 1.80.1)
rustc --version

# Reinstalar herramientas si es necesario
asdf uninstall starknet-foundry latest
asdf install starknet-foundry latest
```

### **Error: "scarb test isn't running snforge"**

```bash
# Verificar que snforge está en PATH
which snforge

# Reinstalar Starknet Foundry
asdf uninstall starknet-foundry latest
asdf install starknet-foundry latest
```

### **Conflictos de Versiones**

```bash
# Limpiar caché de asdf
asdf plugin remove scarb
asdf plugin remove starknet-foundry
asdf plugin remove starknet-devnet

# Reinstalar plugins
asdf plugin add scarb
asdf plugin add starknet-foundry
asdf plugin add starknet-devnet

# Reinstalar versiones
asdf install scarb latest
asdf install starknet-foundry latest
asdf install starknet-devnet latest
```

---

## 📋 Checklist de Configuración

### **Configuración Inicial**

- [ ] ✅ Instalar asdf
- [ ] ✅ Instalar Scarb >= 2.8.5
- [ ] ✅ Instalar Rust >= 1.80.1 (si es necesario)
- [ ] ✅ Instalar Starknet Foundry
- [ ] ✅ Instalar Starknet Devnet
- [ ] ✅ Instalar Node.js
- [ ] ✅ Configurar variables de entorno
- [ ] ✅ Crear archivo `.tool-versions`
- [ ] ✅ Verificar todas las versiones

### **Configuración por Proyecto**

- [ ] ✅ Crear `.tool-versions` con versiones específicas
- [ ] ✅ Ejecutar `asdf install` en el proyecto
- [ ] ✅ Configurar `.env` con URLs de RPC
- [ ] ✅ Actualizar `package.json` con dependencias correctas
- [ ] ✅ Probar compilación con `scarb build`
- [ ] ✅ Probar tests con `scarb test`

---

## 🎯 Mejores Prácticas

### **1. Usar Versionado Semántico**
```bash
# ✅ Correcto - versión específica
scarb 2.12.0

# ❌ Evitar - versión genérica
scarb latest
```

### **2. Documentar Versiones**
```bash
# Siempre documentar las versiones usadas
echo "Versiones probadas:" > VERSIONS.md
echo "- Scarb: $(scarb --version)" >> VERSIONS.md
echo "- Starknet Foundry: $(snforge --version)" >> VERSIONS.md
```

### **3. Usar Entornos Aislados**
```bash
# Crear entorno específico para cada proyecto
mkdir -p ~/.asdf/installs/scarb/project-specific
```

### **4. Automatizar Verificaciones**
```bash
# Script de pre-commit para verificar versiones
#!/bin/bash
# .git/hooks/pre-commit
./verify_versions.sh || exit 1
```

---

**🎉 ¡Con esta configuración tendrás un entorno de desarrollo Starknet robusto y versionado correctamente!**
