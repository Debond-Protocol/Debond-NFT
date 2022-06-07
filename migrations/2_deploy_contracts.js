const MysteryBoxToken = artifacts.require("MysteryBoxToken");

module.exports = function (deployer) {
  deployer.deploy(MysteryBoxToken, "MysteryBox", "MBOX", 3600);
};
