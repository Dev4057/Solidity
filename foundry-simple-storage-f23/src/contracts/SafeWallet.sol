//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract SafeWallet{
    address public owner ;
    uint public dailyLimit;
    uint public spentToday;
    uint public lastDay;

    error NotOwner();
    error LimitExceeds(uint requested, uint available);

    constructor (uint _dailyLimit){
        owner= msg.sender;
        dailyLimit=_dailyLimit;
    }

    modifier onlyOwner(){
        if(msg.sender!=owner) revert NotOwner();
        _;
    }
    function _resetDay()internal {
            if(block.timestamp/1 days > lastDay){
                lastDay=block.timestamp/1 days;
                spentToday=0;
            }
    }

    function spend(uint amount) external onlyOwner{
        _resetDay();
        if (amount+spentToday>dailyLimit)revert LimitExceeds (amount,dailyLimit-spentToday);
        spentToday+amount;
        payable (owner).transfer(amount);

    }
    receive() external payable { }


}