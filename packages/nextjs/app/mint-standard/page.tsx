"use client";

import { useState } from "react";
import { useAccount } from "@starknet-react/core";
import { AddressInput } from "~~/components/scaffold-stark";
import { useScaffoldWriteContract } from "~~/hooks/scaffold-stark";
import { notification } from "~~/utils/scaffold-stark";

export default function MintStandardNFT() {
  const { address: connectedAddress, isConnected } = useAccount();
  const [recipientAddress, setRecipientAddress] = useState("");
  const [ipfsUri, setIpfsUri] = useState("");
  const [isMinting, setIsMinting] = useState(false);

  const { sendAsync: mintNFT } = useScaffoldWriteContract({
    contractName: "QuestlyNFTStandard",
    functionName: "mint_item",
    args: [recipientAddress, ipfsUri], // Requiere recipient Y URI
  });

  const handleMint = async () => {
    if (!isConnected) {
      notification.error("Por favor conecta tu wallet Braavos primero");
      return;
    }

    if (!recipientAddress) {
      notification.error("Por favor ingresa la dirección del destinatario");
      return;
    }

    if (!ipfsUri) {
      notification.error("Por favor ingresa la URI de IPFS");
      return;
    }

    // Validar que la dirección sea válida (empieza con 0x y tiene la longitud correcta)
    if (!recipientAddress.startsWith("0x") || recipientAddress.length < 10) {
      notification.error("Dirección de wallet inválida");
      return;
    }

    // Validar que la URI de IPFS sea válida
    if (!ipfsUri.startsWith("ipfs://") && !ipfsUri.startsWith("https://")) {
      notification.error("URI de IPFS inválida (debe empezar con ipfs:// o https://)");
      return;
    }

    try {
      setIsMinting(true);
      notification.info("Iniciando minteo del NFT estándar...");
      
      await mintNFT();
      
      notification.success("¡NFT estándar minteado exitosamente! 🎉");
      
      // Limpiar los campos después del minteo exitoso
      setRecipientAddress("");
      setIpfsUri("");
    } catch (error: any) {
      console.error("Error al mintear NFT:", error);
      notification.error(
        error?.message || "Error al mintear el NFT. Por favor intenta nuevamente."
      );
    } finally {
      setIsMinting(false);
    }
  };

  return (
    <div className="flex items-center flex-col flex-grow pt-10">
      <div className="px-5 w-full max-w-3xl">
        <h1 className="text-center mb-8">
          <span className="block text-4xl font-bold mb-2">Mintear NFT Estándar</span>
          <span className="block text-2xl">QuestlyNFTStandard en Mainnet 🚀</span>
        </h1>

        <div className="card bg-base-200 shadow-xl p-8">
          {!isConnected ? (
            <div className="alert alert-warning">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="stroke-current shrink-0 h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"
                />
              </svg>
              <span>Por favor conecta tu wallet Braavos para continuar</span>
            </div>
          ) : (
            <>
              <div className="mb-6">
                <div className="alert alert-info">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                    className="stroke-current shrink-0 w-6 h-6"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth="2"
                      d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                    />
                  </svg>
                  <div>
                    <p className="font-bold">Contrato QuestlyNFTStandard</p>
                    <p className="text-xs break-all">
                      0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
                    </p>
                    <p className="text-xs mt-1 text-info-content/70">
                      ERC721 estándar - Con metadata IPFS personalizada
                    </p>
                  </div>
                </div>
              </div>

              <div className="form-control w-full mb-6">
                <label className="label">
                  <span className="label-text text-lg font-semibold">
                    Dirección del destinatario
                  </span>
                </label>
                <AddressInput
                  value={recipientAddress}
                  onChange={setRecipientAddress}
                  placeholder="0x..."
                />
                <label className="label">
                  <span className="label-text-alt">
                    La wallet que recibirá el NFT estándar
                  </span>
                </label>
              </div>

              <div className="form-control w-full mb-8">
                <label className="label">
                  <span className="label-text text-lg font-semibold">
                    URI de IPFS (Metadata)
                  </span>
                </label>
                <input
                  type="text"
                  placeholder="ipfs://Qm... o https://..."
                  className="input input-bordered w-full"
                  value={ipfsUri}
                  onChange={(e) => setIpfsUri(e.target.value)}
                />
                <label className="label">
                  <span className="label-text-alt">
                    URI de la metadata del NFT (IPFS o HTTPS)
                  </span>
                </label>
              </div>

              <button
                className={`btn btn-primary w-full text-lg ${
                  isMinting ? "loading" : ""
                }`}
                onClick={handleMint}
                disabled={isMinting || !recipientAddress || !ipfsUri}
              >
                {isMinting ? (
                  <>
                    <span className="loading loading-spinner loading-md"></span>
                    Minteando NFT...
                  </>
                ) : (
                  "✨ Mintear NFT Estándar"
                )}
              </button>

              {connectedAddress && (
                <div className="mt-6 text-center text-sm opacity-70">
                  Conectado con: {connectedAddress.slice(0, 6)}...
                  {connectedAddress.slice(-4)}
                </div>
              )}
            </>
          )}
        </div>

        <div className="card bg-base-300 shadow-xl p-6 mt-6">
          <h2 className="text-2xl font-bold mb-4">📋 Instrucciones</h2>
          <ul className="list-disc list-inside space-y-2">
            <li>Conecta tu wallet Braavos usando el botón en la esquina superior derecha</li>
            <li>Ingresa la dirección de la wallet que recibirá el NFT estándar</li>
            <li>Ingresa la URI de IPFS con la metadata del NFT</li>
            <li>Haz clic en "Mintear NFT Estándar" y confirma la transacción en tu wallet</li>
            <li>¡Espera a que se confirme la transacción y listo! 🎉</li>
          </ul>

          <div className="divider"></div>

          <div className="space-y-4">
            <h3 className="text-xl font-bold">🔄 Diferencias con QuestlyNFT</h3>
            <div className="grid md:grid-cols-2 gap-4">
              <div className="card bg-base-100 p-4">
                <h4 className="font-bold text-primary">QuestlyNFT (Personalizado)</h4>
                <ul className="text-sm space-y-1">
                  <li>✅ Metadata IPFS personalizada</li>
                  <li>✅ URI individual por token</li>
                  <li>✅ Más flexible</li>
                  <li>⚠️ Requiere subir metadata</li>
                </ul>
              </div>
              <div className="card bg-base-100 p-4">
                <h4 className="font-bold text-secondary">QuestlyNFTStandard (Estándar)</h4>
                <ul className="text-sm space-y-1">
                  <li>✅ ERC721 estándar completo</li>
                  <li>✅ Metadata IPFS personalizada</li>
                  <li>✅ Compatible con todos los wallets</li>
                  <li>✅ Requiere URI de IPFS</li>
                </ul>
              </div>
            </div>
          </div>

          <div className="divider"></div>

          <h3 className="text-xl font-bold mb-2">🔍 Verificar en Explorer</h3>
          <a
            href="https://starkscan.co/contract/0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa"
            target="_blank"
            rel="noopener noreferrer"
            className="link link-primary"
          >
            Ver contrato en Starkscan →
          </a>
        </div>
      </div>
    </div>
  );
}
