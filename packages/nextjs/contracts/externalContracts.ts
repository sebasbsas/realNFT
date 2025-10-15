import { GenericContractsDeclaration } from "~~/utils/scaffold-stark/contract";

/**
 * @example
 * const externalContracts = {
 *   "0x534e5f4d41494e": {
 *     DAI: {
 *       address: "0x00da114221cb83fa859dbdb4c44beeaa0bb37c7537ad5ae66fe5e0efd20e6eb3",
 *       abi: [...],
 *     },
 *   },
 * } as const;
 */
const externalContracts = {
  // Starknet Mainnet
  "0x534e5f4d41494e": {
    // QuestlyNFT moved to deployedContracts.ts for consistency
    // All NFT contracts are now in deployedContracts.ts
  }
} as const;

export default externalContracts satisfies GenericContractsDeclaration;

