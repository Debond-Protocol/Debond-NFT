/** @type import('hardhat/config').HardhatUserConfig */

require("dotenv").config({ path: ".env" });
require("@nomiclabs/hardhat-etherscan");

const ALCHEMY_MAINNET_URL = process.env.ALCHEMY_URL

module.exports = {
  solidity: "0.8.7",
  networks: {
    hardhat: {

    },
    mainnet: {
      url: ALCHEMY_MAINNET_URL,
      accounts:[process.env.PRIVATE_KEY]
    }
  }, 
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },

  etherscan: {
    apiKey: {
      mainnet: 'JAZ4J4CYJDSPKIIS6VTAVGJTKEXIIMUJHY'
    }
  }
};
