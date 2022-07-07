import {ethers} from "ethers";
import {default as keys} from "./_keys.json";
import {MysteryBoxTokenInstance} from "../types/truffle-contracts";

export interface AirdropModel {
    address: string,
    discount: string,
    signature: string,
}

const MysteryBoxToken = artifacts.require("MysteryBoxToken");


/*
 INIT GANACHE WITH : ganache-cli -m "stereo consider quality wild fat farm symptom bundle laundry side one lemon" --account_keys_path test/_keys.json
 */

contract('Airdrop', async (accounts: string[]) => {
    let mysteryBoxTokenInstance: MysteryBoxTokenInstance;

    const [owner, claimer1, claimer2, claimer3, claimer4, claimerNotAuth]: string[] = accounts

    console.log(keys.private_keys);
    const privateKey = Object.values(keys.private_keys)[0] as string
    const wallet = new ethers.Wallet(privateKey);

    const discount = "40"

    let airdrops: AirdropModel[];


    it('Initialisation', async () => {
        mysteryBoxTokenInstance = await MysteryBoxToken.deployed();

        const airdropAddress = mysteryBoxTokenInstance.address;
        airdrops = [
            {address: claimer1, discount: discount, signature: ""},
            {address: claimer2, discount: discount, signature: ""},
            {address: claimer3, discount: discount, signature: ""},
            {address: claimer4, discount: discount, signature: ""},
        ]

        airdrops = await Promise.all(airdrops.map(async (airdrop) => {
            const messageHash = ethers.utils.solidityKeccak256(
                ["address", "address", "uint256"],
                [airdropAddress, airdrop.address, parseInt(airdrop.discount)]
            )
            let messageHashBytes = ethers.utils.arrayify(messageHash)
            airdrop.signature = await wallet.signMessage(messageHashBytes);
            return airdrop
        }))

        console.log(airdrops);

        // Setting airdrop On
        //await MysteryBoxTokenContract.setSaleOn();
    })

    it('should airdrop successfully', async () => {
        await mysteryBoxTokenInstance.mintDiscount(discount, airdrops.filter(airdrop => airdrop.address == claimer1)[0].signature, {from: claimer1, value: ethers.utils.parseEther("0.3").toString()})

        const claimerBalance = await mysteryBoxTokenInstance.balanceOf(claimer1);
        assert.equal(claimerBalance.toString(), "1");
    })

    it('should airdrop successfully', async () => {
        await mysteryBoxTokenInstance.mint(3, {from: claimer2, value: ethers.utils.parseEther("1.5").toString()});

        const claimerBalance = await mysteryBoxTokenInstance.balanceOf(claimer2);
        assert.equal(claimerBalance.toString(), "3");
    })
})