const MysteryBoxToken = artifacts.require("MysteryBoxToken");

module.exports = function (deployer) {
  deployer.deploy(MysteryBoxToken, "MysteryBox", "MBOX", 432000);
};
