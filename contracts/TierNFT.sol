pragma solidity ^0.8.0;

// SPDX-License-Identifier: apache 2.0
/*
    Copyright 2022 Debond Protocol <info@debond.org>
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@debond/debond-governance/utils/GovernanceOwnable.sol";
import "./utils/types.sol";
contract TierNFT is ITierNFT, ERC721{

    using SafeMath for uint256;
    using Counters for Counters.Counter;
    // mapping of the tier of NFT with the corresponding tier tokenId of the NFT.
    // here the tokenId will be randomly generated so not need to be tracked seperately
    mapping(uint => NFTDetails) tokenCounter;

// storages for other contract addresses.
address dgovAddress;
address nftGovAddress;
uint tier;

uint tokenId;
string immutable baseURI = "";

modifier onlydNFTGoverner {
require(msg.sender == nftGovAddress, "TierNFT-only-DNFTGov");
}

constructor(address _dgovAddress, address _dnftGovAddress, uint8 _tierNumber , string calldata  name , string calldata symbol)  ERC721(_name, _symbol){
tier = _tierNumber;
dgovAddress = _dgovAddress;
nftGovAddress = _dnftGovAddress;
}
// setter function for the different accounts.
function setDGOVAddress(address _newDGOVAddress)  onlyGovernance returns(bool) {
newDGOVAddress = _newDGOVAddress;
return true;
}

function setNFTGovAddress(address _newDBITAddress) onlyGovernance returns(bool) {
newDBITAddress = _newDBITAddress;
return true;
}

function tokenURI(uint256 _tokenId) override public pure returns (string memory) {
return super.tokenURI(_tokenId);

}

/**
 * @note this function does not provide enough randomness in order to insure the security of NFT's against the sniping.
 * thus better secured method (VRF) should at least be used.
 * 
 */

function generateTokenIdRandom() external return(uint randomNumber) {
string randomSalt = blockhash(block.number - 1);
uint randomNumber = uint(keccak256(randomSalt % 100));
}

function _randomMint(address to, uint _tier) private returns(uint _tokenId ) {

_tokenId = generateTokenIdRandom();

tokenCounter[_tier].NFTDetails.tier = _tier; 
tokenCounter[_tier].NFTDetails.tokenId = _tokenId;

super._safeMint(to,_tokenId);
}

// for batch minting.
function safeMints(address to, uint nftNumber, uint _tier) external returns(uint[] tokenIds) {
for(uint i = 0; i < nftNumber; i++) {
_randomMint(to,_tier);
tokenIds.push(generateTokenIdRandom());

}
return tokenIds;
}




function burn(uint tokenId, uint _tier) external onlydNFTGoverner returns(uint[] tokenIds) {
// TODO: to see how to resolve the issue about the burn function needing only the tokenId, thus needing an pattern in order to do burn for the given ter tokenId only.

}






}