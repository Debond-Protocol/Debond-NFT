import {ethers} from "ethers";
import fs from "fs";
import path from "path";
require('dotenv').config();




export interface Discount {
    address: string,
    discountRate: number,
    signature: string,
}
const contractAddress = process.env.CONTRACT_ADDRESS;
let airdrops: Discount[] = [
    {address: "0x51E3B4fDcC33df3D5eC3574F6E1D3558332FC6Fe", discountRate: 50, signature: ""},
]
console.log(process.env.MAINNET_PRIVATE_KEY)
let wallet = new ethers.Wallet(""+(process.env.MAINNET_PRIVATE_KEY));

Promise.all(airdrops.map(async (discount) => {
    const messageHash = ethers.utils.solidityKeccak256(
        ["address", "address", "uint256"],
        [contractAddress, discount.address, discount.discountRate]
    )
    let messageHashBytes = ethers.utils.arrayify(messageHash)
// console.log(messageHash)
    discount.signature = await wallet.signMessage(messageHashBytes);
    return discount
})).then(discounts => {
    fs.writeFile(
        path.dirname(__filename) + "/discounts.json",
        JSON.stringify(discounts),
        err => {
            err ? console.log(err) : ""
        }
    )
})
