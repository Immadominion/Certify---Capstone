import wallet from "../wallet/dev-wallet.json"
import { createUmi } from "@metaplex-foundation/umi-bundle-defaults"
import { createGenericFile, createSignerFromKeypair, signerIdentity } from "@metaplex-foundation/umi"
import { irysUploader } from "@metaplex-foundation/umi-uploader-irys"

// Create a devnet connection
const umi = createUmi('https://api.devnet.solana.com');

let keypair = umi.eddsa.createKeypairFromSecretKey(new Uint8Array(wallet));
const signer = createSignerFromKeypair(umi, keypair);

umi.use(irysUploader());
umi.use(signerIdentity(signer));

(async () => {
    try {
        // Follow this JSON structure
        // https://docs.metaplex.com/programs/token-metadata/changelog/v1.0#json-structure

        const image = 'https://devnet.irys.xyz/4Y6Xh3LRFQM3brHMEeJ8oHh6cXXzSLTcvRJYE2iXeo14';
        const metadata = {
            name: "T-Pain",
            symbol: "TP",
            description: "T-Pain don make kobo irrelevant 2.0",
            image: image,
            attributes: [
                {trait_type: 'Color', value: 'Is'},
                {trait_type: 'Material', value: 'it'},
                {trait_type: 'Size', value: 'for'},
                {trait_type: 'Quality', value: 'Garri?'},
                {trait_type: 'Year', value: 'Emilokan'},
            ],
            properties: {
                files: [
                    {
                        type: "image/png",
                        uri: image
                    },
                ]
            },
            creators: [keypair.publicKey]
        };
        const myUri = await umi.uploader.uploadJson(metadata);
        console.log("Your metadata URI: ", myUri);
    }
    catch(error) {
        console.log("Oops.. Something went wrong", error);
    }
})();


///Example output >> https://devnet.irys.xyz/7xG7g4CNU2AB4WNgbcFBorNg2GTYckdEe9j7FZmBEfM2