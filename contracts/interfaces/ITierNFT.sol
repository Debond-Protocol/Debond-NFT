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


interface ITierNFT {


/**
@notice this will be an override version of the standard 721 NFT that will allow issuance of multiple NFT's
for the user
@dev: only called by DNFTGovernance Contract .
@param  to is the address of claimer.
@param nftNumber is the number of NFT's to be minted for the user.
*/
function safeMints(address to, uint nftNumber) external returns(bool);

/**
@notice allows the owner to invalidate the NFT's and return the tokenID to be then used by the governance contract to issue new NFT's 
@dev only be callable by the IDNFTGovernance contract for the NFT's that are not used.
@param  tokenId is the indexation number for the given NFT contract
**/
function  burn(uint tokenIds, uint _tier) external returns(bool);

}


