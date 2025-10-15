"use client";

import { useState } from "react";
import { useAccount } from "@starknet-react/core";
import { AddressInput } from "~~/components/scaffold-stark";
import { useScaffoldWriteContract } from "~~/hooks/scaffold-stark";
import { notification } from "~~/utils/scaffold-stark";

export default function MintNFT() {
  const { address: connectedAddress, isConnected } = useAccount();
  const [recipientAddress, setRecipientAddress] = useState("");
  const [ipfsUri, setIpfsUri] = useState("");
  const [isMinting, setIsMinting] = useState(false);

  const { sendAsync: mintNFT } = useScaffoldWriteContract({
    contractName: "QuestlyNFTStandard",
    functionName: "mint_item",
    args: [recipientAddress, ipfsUri],
  });

  const handleMint = async () => {
    if (!isConnected) {
      notification.error("Por favor conecta tu wallet Braavos primero");
      return;
    }

    if (!recipientAddress || !ipfsUri) {
      notification.error("Por favor completa todos los campos");
      return;
    }

    // Validar que la dirección sea válida (empieza con 0x y tiene la longitud correcta)
    if (!recipientAddress.startsWith("0x") || recipientAddress.length < 10) {
      notification.error("Dirección de wallet inválida");
      return;
    }

    // Validar que la URI tenga contenido
    if (ipfsUri.trim().length === 0) {
      notification.error("La URI de IPFS no puede estar vacía");
      return;
    }

    try {
      setIsMinting(true);
      notification.info("Iniciando minteo del NFT...");
      
      await mintNFT();
      
      notification.success("¡NFT minteado exitosamente! 🎉");
      
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
          <span className="block text-4xl font-bold mb-2">Mintear Questly NFT</span>
          <span className="block text-2xl">en Starknet Mainnet 🚀</span>
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
                    <p className="font-bold">Contrato QuestlyNFT Standard</p>
                    <p className="text-xs break-all">
                      0x434c8fefb5d4f6e48c26d44c47fcc896e67592ad67840b961d6b5f4614ef4aa
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
                    La wallet que recibirá el NFT
                  </span>
                </label>
              </div>

              <div className="form-control w-full mb-8">
                <label className="label">
                  <span className="label-text text-lg font-semibold">
                    URI de IPFS
                  </span>
                </label>
                <input
                  type="text"
                  placeholder="ipfs://Qm... o https://ipfs.io/ipfs/Qm..."
                  className="input input-bordered w-full text-base"
                  value={ipfsUri}
                  onChange={(e) => setIpfsUri(e.target.value)}
                />
                <label className="label">
                  <span className="label-text-alt">
                    La URI completa del metadata en IPFS
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
                  "✨ Mintear NFT"
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
            <li>Ingresa la dirección de la wallet que recibirá el NFT</li>
            <li>Pega la URI completa del metadata en IPFS (ejemplo: ipfs://QmXxx... o https://ipfs.io/ipfs/QmXxx...)</li>
            <li>Haz clic en "Mintear NFT" y confirma la transacción en tu wallet</li>
            <li>¡Espera a que se confirme la transacción y listo! 🎉</li>
          </ul>

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

