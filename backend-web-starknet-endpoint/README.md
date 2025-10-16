# 🚀 Backend de Minteo para Questly NFTs

Backend serverless para mintear NFTs en Starknet Mainnet.

## 📋 Requisitos Previos

1. **Cuenta en Vercel** (gratis): https://vercel.com
2. **Wallet con STRK** (para pagar gas):
   - Crear wallet en ArgentX: https://www.argent.xyz/
   - Enviar $5-10 de STRK (~100-500 mints)
   - Exportar private key

## 🔧 Configuración

### 1. Instalar Vercel CLI

```bash
npm install -g vercel
```

### 2. Login en Vercel

```bash
vercel login
```

### 3. Configurar Variables de Entorno

En tu proyecto de Vercel, ve a **Settings → Environment Variables** y agrega:

- `BACKEND_WALLET_ADDRESS`: Tu dirección de wallet (0x...)
- `BACKEND_PRIVATE_KEY`: Tu private key (⚠️ SECRETO)

## 🚀 Despliegue

Desde la carpeta `backend`:

```bash
vercel
```

Sigue las instrucciones:
1. Set up and deploy? → **Yes**
2. Which scope? → **Tu cuenta**
3. Link to existing project? → **No**
4. Project name? → **questly-backend**
5. Directory? → **./backend**
6. Override settings? → **No**

Una vez desplegado, obtendrás una URL como:
```
https://questly-backend.vercel.app
```

## 📡 API Endpoint

### POST /api/mint

Mintea un NFT al usuario especificado.

**Request:**
```json
{
  "userAddress": "0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565",
  "nftData": {
    "name": "Epic Sword",
    "rarity": "legendary"
  }
}
```

**Response (Success):**
```json
{
  "success": true,
  "transactionHash": "0xabc123...",
  "tokenId": "42",
  "explorerUrl": "https://voyager.online/tx/0xabc123...",
  "message": "NFT minteado exitosamente en Starknet Mainnet"
}
```

**Response (Error):**
```json
{
  "success": false,
  "error": "Error message"
}
```

## 🧪 Testing Local

Para probar localmente antes de desplegar:

```bash
# Instalar dependencias
npm install

# Crear archivo .env con tus credenciales
cp env.example .env
# Editar .env con tus valores reales

# Instalar Vercel Dev
npm install -g vercel

# Ejecutar en modo dev
vercel dev
```

Luego prueba con:

```bash
curl -X POST http://localhost:3000/api/mint \
  -H "Content-Type: application/json" \
  -d '{"userAddress": "0x078e3f9e7663b1c5e903aa889aea5c025a141e3439146c12e9890723bb66b565"}'
```

## 💰 Costos

- **Vercel**: Gratis (plan Hobby)
- **Gas en Starknet**: ~$0.01-0.05 por mint
- **Total estimado**: $5-10 de STRK = 100-500 mints

## 🔐 Seguridad

⚠️ **IMPORTANTE:**
- NUNCA compartas tu `BACKEND_PRIVATE_KEY`
- NUNCA subas el archivo `.env` a Git
- Las variables de entorno solo se configuran en Vercel Dashboard

## 📝 Notas

- Contrato: `0x02Cf4E33CD8F9844fc928ed43c72C7bdAbC1773aE9C3F26AC1C2B232ca7b0080`
- Network: Starknet Mainnet
- RPC: `https://starknet-mainnet.public.blastapi.io/rpc/v0_7`

---

**Última actualización:** 2025-10-16

