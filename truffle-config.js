require("ts-node").register({files: true});
const HDWalletProvider = require("truffle-hdwallet-provider");
require('dotenv').config();
const Web3 = require("web3");
const web3 = new Web3();

module.exports = {
  plugins: ['truffle-plugin-verify'],
  api_keys: {
    etherscan: 'JAZ4J4CYJDSPKIIS6VTAVGJTKEXIIMUJHY'
  },

  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
    },
    rinkeby: {
      provider: function() {
        return new HDWalletProvider(process.env.PRIVATE_KEY, `https://rinkeby.infura.io/v3/958be2ccc3339faaae7e778a783034b4e3352742d771f8a3591d498d4079e2f4`);
      },
      network_id: 4,
      // gas: 30000000, //from ganache-cli output
      // gasPrice: web3.utils.toWei('1', 'gwei')
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(process.env.PRIVATE_KEY, `https://ropsten.infura.io/v3/${process.env.INFURA_ACCESS_TOKEN}`);
      },
      network_id: 3,
    },
    mainnet: {
      provider: function() {
        return new HDWalletProvider('958be2ccc3339faaae7e778a783034b4e3352742d771f8a3591d498d4079e2f4', `https://eth-mainnet.g.alchemy.com/v2/QUf0tu7z5Qlu2p8sFyIGPgqxzV_u5EKR`);
      },
      network_id: 1,

    },

      // gas: 30000000, //from ganache-cli output
      gasPrice: web3.utils.toWei('1', 'gwei')
    },
  
  mocha: {
    // reporter: 'eth-gas-reporter',
  },
  compilers: {
    solc: {
      version: "0.8.7",
      settings: { // See the solidity docs for advice about optimization and evmVersion
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
