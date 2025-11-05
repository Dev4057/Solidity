// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Bank {

    //Mapping to store balances of each address
    mapping(address => uint) public balances;

    //Events to log deposits and withdrawals
    event Deposit(address indexed who, uint amount);
    event Withdraw(address indexed who, uint amount);

    //Deposit ETH into your account in the bank
    function deposit() public payable {
        require(msg.value > 0, "Deposit must be greater than zero");

        // Increase user's balance
        balances[msg.sender] += msg.value;

        // Emit event for transparency
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw ETH from your account
    function withdraw(uint amount) public virtual {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Reduce balance before transferring (prevents reentrancy)
        balances[msg.sender] -= amount;

        // Safely transfer ETH
        payable(msg.sender).transfer(amount);

        // Log the withdrawal event
        emit Withdraw(msg.sender, amount);
    }

    // Check balance of any address
    function getBalance(address who) public view returns (uint) {
        return balances[who];
    }

}

 contract Savings is Bank{

        uint public interestRate;
        constructor(uint _rate){
            interestRate=_rate; // basis points, e.g., 100 = 1%
        }

        function accrueInterest (address who)public {
            uint bal= balances[who];
            uint interest=(bal*interestRate)/10000;
            balances[who]+=interest;
        }

        function withdraw(uint amount)public override {
            accrueInterest(msg.sender);
            super.withdraw(amount);
        }
    }



    