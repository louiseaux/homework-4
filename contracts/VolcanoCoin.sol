// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    
    uint supply = 10000;
    address owner;
    
    mapping(address => uint) public balance;
    mapping(address => Payment[]) payments;
    
    event Supply_increase(uint indexed);
    event Transfer(address, uint);
    
    struct Payment {
        address recipient;
        uint amount;
    }
    
    constructor() {
        owner = msg.sender;
        balance[owner] = supply;
    }
    
    modifier onlyOwner {
        if(msg.sender == owner) {
            _;
        }
    }
    
    function getPayments(address user) public view returns (Payment[] memory) {
        return payments[user]; // returns tuple
    }
    
    function totalSupply() public view returns (uint) {
        return supply;
    }
    
    function increaseSupply() public onlyOwner {
        supply += 1000;
        emit Supply_increase(supply);
    }
    
    function transfer(address _recipient, uint _amount) public {
        require(_amount > 0, "Amount must be > 0");
        
        uint funds = balance[msg.sender];
        require(funds >= _amount, "Transfer amount exceeds funds");
        
        balance[msg.sender] -= _amount;
        balance[_recipient] += _amount;
        
        payments[_recipient].push(Payment({recipient: _recipient, amount: _amount}));
        
        emit Transfer(_recipient, _amount);
    }
}