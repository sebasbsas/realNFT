"use client";

import React, { useState } from "react";
import { NextPage } from "next";
import { useAccount } from "@starknet-react/core";
import { useScaffoldWriteContract } from "~~/hooks/scaffold-stark";
import { notification } from "~~/utils/scaffold-stark";

const MintMinimalNFT: NextPage = () => {
  const { address: connectedAddress } = useAccount();
  const [recipientAddress, setRecipientAddress] = useState<string>("");
  const [isMinting, setIsMinting] = useState(false);
  const [mintStatus, setMintStatus] = useState<string | null>(null);

  const { sendAsync: mintMinimalNFT } = useScaffoldWriteContract({
    contractName: "MinimalNFT",
    functionName: "mint",
    args: [recipientAddress],
  });

  const handleMint = async () => {
    if (!connectedAddress) {
      notification.error("Please connect your wallet.");
      return;
    }
    if (!recipientAddress) {
      notification.error("Please enter a recipient address.");
      return;
    }

    setIsMinting(true);
    setMintStatus("Minting in progress...");

    try {
      const txHash = await mintMinimalNFT();
      if (txHash) {
        notification.success(`Minimal NFT minted successfully! Transaction Hash: ${txHash}`);
        setMintStatus(`Minted! Transaction: ${txHash}`);
        setRecipientAddress("");
      } else {
        notification.error("Minimal Minting failed: No transaction hash returned.");
        setMintStatus("Minimal Minting failed.");
      }
    } catch (e: any) {
      console.error("Minimal Minting error:", e);
      notification.error(`Minimal Minting failed: ${e.message || e.toString()}`);
      setMintStatus(`Minimal Minting failed: ${e.message || e.toString()}`);
    } finally {
      setIsMinting(false);
    }
  };

  return (
    <div className="flex items-center flex-col flex-grow pt-10">
      <div className="px-5">
        <h1 className="text-center mb-8">
          <span className="block text-4xl font-bold">Mint MinimalNFT</span>
        </h1>
        <p className="text-center text-lg">
          Mint your MinimalNFT (ERC721 without IPFS URI) on Starknet Mainnet.
        </p>
        <div className="alert alert-info mt-4">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" className="stroke-current shrink-0 w-6 h-6">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
          <span>This NFT does NOT support IPFS metadata. It's a basic NFT for simple use cases.</span>
        </div>
      </div>

      <div className="flex flex-col bg-base-100 shadow-xl p-8 rounded-xl w-full max-w-lg mt-8">
        <div className="form-control mb-4">
          <label className="label">
            <span className="label-text">Recipient Address</span>
          </label>
          <input
            type="text"
            placeholder="0x..."
            className="input input-bordered w-full"
            value={recipientAddress}
            onChange={(e) => setRecipientAddress(e.target.value)}
          />
        </div>

        <button
          className="btn btn-primary w-full"
          onClick={handleMint}
          disabled={isMinting || !connectedAddress}
        >
          {isMinting ? (
            <span className="loading loading-spinner"></span>
          ) : (
            "🎯 Mint Minimal NFT"
          )}
        </button>

        {mintStatus && (
          <p className="text-center mt-4 text-sm text-info">{mintStatus}</p>
        )}
      </div>

      <div className="mt-8 p-6 bg-base-200 rounded-xl max-w-2xl">
        <h3 className="text-lg font-bold mb-4">📋 MinimalNFT Characteristics:</h3>
        <ul className="space-y-2 text-sm">
          <li>✅ <strong>Basic ERC721:</strong> Standard NFT functionality</li>
          <li>❌ <strong>No IPFS Support:</strong> Cannot store metadata URIs</li>
          <li>✅ <strong>Simple Minting:</strong> Just recipient address required</li>
          <li>✅ <strong>Lower Gas:</strong> More cost-effective for basic NFTs</li>
          <li>⚠️ <strong>Use Case:</strong> Ideal for simple tokens or testing</li>
        </ul>
      </div>
    </div>
  );
};

export default MintMinimalNFT;
