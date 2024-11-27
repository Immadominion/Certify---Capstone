import { createNftForApp } from "./create-nft";

// Example usage
const imagePath = "/Users/immadominion/codes/CERTIFY/CERTIFY-BACKEND/assets/images/nft.png";
const nftName = "T-Pain";
const description = "T-Pain don make kobo irrelevant 2.0";
const attributes = [
    { trait_type: 'Color', value: 'Is' },
    { trait_type: 'Material', value: 'it' },
    { trait_type: 'Size', value: 'for' },
    { trait_type: 'Quality', value: 'Garri?' },
    { trait_type: 'Year', value: 'Emilokan' },
];



    (async () => {
        try {
            createNftForApp(imagePath, nftName, description, attributes)
            .then(result => {
                console.log("NFT created successfully:", result);
            })
            .catch(error => {
                console.error("Error creating NFT:", error);
            });
        }
        catch(error) {
            console.log("Oops.. Something went wrong", error);
        }
    })();