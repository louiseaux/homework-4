// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    
    uint supply = 10000;
    address owner;
    
    mapping(address => uint) public balance;
    event Supply_increase(uint indexed);
    event Transfer(address, uint);
    error NotEnoughFunds(uint requested, uint available);
    
    constructor() {
        owner = msg.sender;
        balance[owner] = supply;
    }
    
    modifier onlyOwner {
        if(msg.sender == owner) {
            _;
        }
    }
    
    function totalSupply() public view returns (uint) {
        return supply;
    }
    
    function increaseSupply() public onlyOwner {
        supply += 1000;
        emit Supply_increase(supply);
    }
    
    function transfer(address recipient, uint amount) public {
        require(amount > 0, "Amount must be > 0");
        uint funds = balance[msg.sender];
        if (funds < amount) {
            revert NotEnoughFunds(amount, funds);
        }
        balance[msg.sender] -= amount;
        balance[recipient] += amount;
        emit Transfer(recipient, amount);
    }
}