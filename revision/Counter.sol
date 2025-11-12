//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract counter{
    uint private count ;
    address public owner ;

    event counterIncreased(uint newCount, address By);
    event counterDecreased(uint newCount, address BY);
    event Reset(address by);

    constructor (){
        owner= msg.sender;
        count =0;
    }

    function incrementCounter()public{
        count+=1;
        emit counterIncreased(count,msg.sender);
    }

    function decrementCounter(){
        require(count>0,"Count should be greater than 0")
        count-=1;
        emit counterDecreased(count,msg.sender);
    }

    function reset()public{
        require(msg.sender==owner,"Only owner can change");

        count=0;
        emit Reset(msg.sender);
    }

    function getCount()public view returns(uint256){
        return count ;
    }

}