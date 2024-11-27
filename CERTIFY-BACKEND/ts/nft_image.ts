import wallet from "../wallet/dev-wallet.json"
import { createUmi } from "@metaplex-foundation/umi-bundle-defaults"
import { createGenericFile, createSignerFromKeypair, signerIdentity } from "@metaplex-foundation/umi"
import { irysUploader } from "@metaplex-foundation/umi-uploader-irys"
import { readFile } from "fs/promises"

// Create a devnet connection
const umi = createUmi('https://api.devnet.solana.com');

let keypair = umi.eddsa.createKeypairFromSecretKey(new Uint8Array(wallet));
const signer = createSignerFromKeypair(umi, keypair);

umi.use(irysUploader());
umi.use(signerIdentity(signer));

(async () => {
    try {
        //1. Load image
        //2. Convert image to generic file.
        //3. Upload image
        /// Example output >> https://devnet.irys.xyz/4Y6Xh3LRFQM3brHMEeJ8oHh6cXXzSLTcvRJYE2iXeo14
        /// Do not forget to remove arweave and put devnet

        const image = await readFile("/Users/immadominion/codes/turbin/solana-starter/ts/cluster1/tpain.jpeg");

        const myUri = createGenericFile(image, "TPain", {
            contentType: "image/png"
        })

        const uri = await umi.uploader.upload([myUri]);

        console.log("Generic file: ", myUri);

        console.log("Your image URI: ", uri);
    }
    catch(error) {
        console.log("Oops.. Something went wrong", error);
    }
})();
