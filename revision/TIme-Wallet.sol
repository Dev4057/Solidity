// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;


contract Time_Wallet{
        address public owner;
        uint public unlockTime;

        event Deposited(address indexed from , uint amount); // We are not trasferring we are just getting it to our account from all others that is why from is take and not to 

    event withdraw(address indexed to , uint amount);


    constructor(uint _lockDurationInSeconds){
        owner= msg.sender// Who ever deoloys the contract 
        unlockTime=_lockDurationInSeconds;
    }

    receive()external payable {
        emit Deposited(msg.sender,msg.value);
    }

    modifier onlyOwner{
        require(msg.sender==owner,"Not Owner");
        _;
    }

    function withdraw(uint _amount)external onlyOwner{

        require(block.timestamp>=unlockTime,"Funds are still locked");
        uint amount = address(this).balances ;
        require(amount>=_amount,"No funds Available ");
        payable(owner).transfer(amount);
        emit withdraw(owner,uint _amount);
    }





}