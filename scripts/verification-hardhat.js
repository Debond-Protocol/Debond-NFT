const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });
require('@nomiclabs/hardhat-etherscan');
async function main() {
// Verify the contract after deploying
await hre.run("verify:verify", {
address: "0xe38fec0ce55b6742d2adb400d9f6e538709004a8",
constructorArguments: ['DeBond NFT', 'DNFT', {timeperiod: 2592000 }],
});
}
// Call the main function and catch if there is any error
main()
.then(() => process.exit(0))
.catch((error) => {
console.error(error);
process.exit(1);
});