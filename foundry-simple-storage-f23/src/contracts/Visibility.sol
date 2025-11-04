//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract VisibilityDemo {
    uint public publicVar = 1;
    uint internal internalVar = 2;
    uint private privateVar = 3;

    function viewPureExample(uint x) external pure returns(uint){
        return x*2;
    }

    function viewExamples()external view returns(uint){
        return publicVar+internalVar+privateVar;
    }

    function setPrivate(uint _p) external{
        privateVar=_p;
    }

    function readprivate()external view returns (uint){
        return privateVar;
    }
}