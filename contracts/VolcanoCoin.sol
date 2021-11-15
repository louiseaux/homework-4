// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    
    uint supply = 10000;
    address owner;
    
    event Supply_increase(uint indexed);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        if(msg.sender == owner) {
            _;
        }
    }
    
    function getSupply() public view returns (uint) {
        return supply;
    }
    
    function increaseSupply() public onlyOwner {
        supply += 1000;
        emit Supply_increase(supply);
    }
}