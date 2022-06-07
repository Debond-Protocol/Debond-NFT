pragma solidity ^0.8.0;

// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";


contract MysteryBoxToken is ERC20, Ownable {

//    struct SaleConfig {
//        uint256 startTime;
//        uint256 duration;
//    }

    using ECDSA for bytes32;

    uint256 startingTime;
    uint256 endingTime;
    uint256 duration;
    bool public saleOn = true;
    mapping(address => bool) public discountClaimed;



    constructor(string memory name_, string memory symbol_, uint _duration) ERC20(name_, symbol_){
        startingTime = block.timestamp;
        duration = _duration;
        endingTime = block.timestamp + _duration;
    }

    modifier isDiscountAuthorized(uint256 discount, bytes memory signature) {
        require(verifySignature(discount, signature) == owner(), "caller not authorized to get discount");
        _;
    }

    function verifySignature(uint256 discount, bytes memory signature) internal view returns (address) {
        return keccak256(abi.encodePacked(address(this), msg.sender, discount))
        .toEthSignedMessageHash()
        .recover(signature);
    }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

//    //@YU: This function read from an updatable jason file, in the file you can get un int from an adress.
//    function checkIfWhitelisted(address _to) public view virtual returns (uint8){
//        //from the jason file we get amount from 1 to 100, this represent the discount of the adress _to can enjoy.
//        return(50);
//    }


    //@YU: This function gives the price now
    function getMintingPrice() public view virtual returns (uint256) {
        //The percentage of time passed
        uint256 timePassed = 100-(endingTime - block.timestamp) * 100 / duration;
        uint256 priceNow = 2e17 + 3e17 * timePassed /100;
        return(priceNow / 100);
    }

    //front end get minting price () first then put the price in to payable parameter
    function mint() public payable{
        require(msg.value >= getMintingPrice());
        //after the transfer of eth mint token.
        _mint(msg.sender, 1);

    }

    function mintDiscount(uint256 _discount, bytes memory _signature) external payable isDiscountAuthorized(_discount, _signature) {
        require(saleOn == true, "Sale is Off");
        require(!discountClaimed[msg.sender], "caller already used his discount");
        require(_discount > 0 && _discount < 100, "discount must be between 0 and 100");
        require(msg.value >= getMintingPrice() * _discount / 100, "missing ETH");
        _mint(msg.sender, 1);
        discountClaimed[msg.sender] = true;
    }

    function setSaleOn() external onlyOwner {
        require(saleOn == false, "Sale already On.");
        saleOn = true;
    }

    function setSaleOff() external onlyOwner {
        require(saleOn == true, "Sale already Off.");
        saleOn = false;
    }

    function withdrawToOwner() external onlyOwner {
        uint256 _amount = address(this).balance;
        require(_amount > 0, "No ETH to Withdraw");
        payable(_msgSender()).transfer(_amount);
    }

//    function getPrice() public view returns (uint256) {
//        uint256 _price;
//        SaleConfig memory _saleConfig = saleConfig;
//        if (block.timestamp <= _saleConfig.startTime + 6 hours) {
//            _price = 0.5 ether;
//        } else if (
//            (block.timestamp >= _saleConfig.startTime + 6 hours) &&
//            (block.timestamp <= _saleConfig.startTime + 12 hours)
//        ) {
//            _price = 0.4 ether;
//        } else if (
//            (block.timestamp > _saleConfig.startTime + 12 hours) &&
//            (block.timestamp <= _saleConfig.startTime + 18 hours)
//        ) {
//            _price = 0.3 ether;
//        } else {
//            _price = 0.3 ether;
//        }
//        return _price;
//    }

}
