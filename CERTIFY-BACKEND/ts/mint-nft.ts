import { createUmi } from "@metaplex-foundation/umi-bundle-defaults"
import { createSignerFromKeypair, signerIdentity, generateSigner, percentAmount } from "@metaplex-foundation/umi"
import { createNft, mplTokenMetadata } from "@metaplex-foundation/mpl-token-metadata";

import wallet from "../../CERTIFY-BACKEND/wallet/dev-wallet.json"
import base58 from "bs58";

const RPC_ENDPOINT = "https://api.devnet.solana.com";
const umi = createUmi(RPC_ENDPOINT);

let keypair = umi.eddsa.createKeypairFromSecretKey(new Uint8Array(wallet));
const myKeypairSigner = createSignerFromKeypair(umi, keypair);
umi.use(signerIdentity(myKeypairSigner));
umi.use(mplTokenMetadata())

const mint = generateSigner(umi);

(async () => {
    let tx = createNft(umi, {
        mint: mint,
        name: "T-Pain",
        symbol: "TP",
        uri: "https://devnet.irys.xyz/7xG7g4CNU2AB4WNgbcFBorNg2GTYckdEe9j7FZmBEfM2",
        sellerFeeBasisPoints: percentAmount(1),
    })
    let result = await tx.sendAndConfirm(umi);
    const signature = base58.encode(result.signature);
    
    console.log(`Succesfully Minted! Check out your TX here:\nhttps://explorer.solana.com/tx/${signature}?cluster=devnet`)

    console.log("Mint Address: ", mint.publicKey);
})();

/// Last process
/// Succesfully Minted! Check out your TX here:
/// https://explorer.solana.com/tx/2BouCGGGfZ9vyRrErRFXHmqe4u2P243seampEUMfWWwPSnNNWhtNhcRCSvAPqbAbbShmntdTbjsuuEvwJV9wqaJk?cluster=devnet
/// Example outputs <> Mint Address:  5bQPwz1cnPAgidzJia9dxMcvsXQ6jd2ZdSSajP5aus16