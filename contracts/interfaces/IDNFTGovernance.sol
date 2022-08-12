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

/* @notice structure for storing the NFT description based on the tier.
*
*/

struct NFTDetails {
uint tokenId;
uint8 tier;
}
interface IDNFTGovernance  {
/**
@info: allows the owner of the contract to utilise the ERC20 contract from the given type, and then issuing the NFT randomly from the given tier .
@dev only being called by the owner of the MBT.
@param _tokenAddress is the address of the MBToken that user wants to burn.
@param amountTokens is the tokens that are to be burned in order to mint the token
@returns bool is the status whether the token is minted 
@returns object details about the token that is gnenerated.
**/
function reveal(address _tokenAddress, uint amountTokens) external returns(NFTDetails memory);

/**
@info allows general participants (non whitelisted ) for minting sepecific types of NFT.
@info it takes 10dGOV as the minting fees everytime to create the NFT.
@param _numDGOVTokens is the number of tokens that users can pay to mint single/multiple NFT's (including fees).)
@param tokenIds is the tokenId of the potential NFT's that you want to mint.
@param _to is the destination address (who pays the DGOV) will be getting the NFT's .
*/

function forgeMonolith(uint _numDGOVTokens, uint[] tokenIds,  address _to) external returns(uint[] tokenIds);

/**
allows to mint random NFT (that can be higher than tier 0).
@info this will be requiring internal costs for minting the DGOV that is probabilistic, being 2000 DGOV as worst case scenario(minting 2 tier-3  DGOV in succession).
@param _for is the address which will mint the random NFT's airdrops while paying the correspo
*/
function reforge(address _for) external returns(NFTDetails[] nft);
/**
allows the creation of the higher tier NFT's from the burning of 10 lower level NFT's. 
@param _of is the address of owner that will be bartering the NFT's with the higher tier NFT's
@param tokenIds is the array of tokenId  NFTs  from the lower tier that is being burned to generate the higher tier NFT
@return NFTMinted is the tokenId of the higher tier NFT that is being minted.
*/
function composeNFT(address _of ,NFTDetails[] nft) external returns(NFTDetails _nftDetails);

/**
function for holders of NFT to stake their NFT and getting the interest free loan.
@info unlike the debond-loan package mechanism, here the loan will be fixed based on the tier of the NFT
@param  nftLoans is the array of the details about the tokens that user owns.
*/

function borrowDGOV(NFTDetails[] nftLoans) external returns(bool);
}