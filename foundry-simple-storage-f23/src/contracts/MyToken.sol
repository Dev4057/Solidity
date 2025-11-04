//SPDX-License-Identifier :MIT 

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract Mytoken{


    string public name="MyToken";
    string public symbol="DEV";
    uint8 public    decimals = 18;
    uint public totalSupply;
    

    mapping(address=>uint)public balanceOf;
    mapping(address=>mapping (address=>uint))public allowance;  //how much amt. did owner approved to the party to spend on behalf of owner

    event  Transfer(address indexed from ,address indexed to , uint amt);
    event Approval(address indexed owner, address indexed spender, uint indexed  amt );

    constructor(uint _initial){
        totalSupply= _initial*(10**decimals);
        balanceOf[msg.sender]=totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);

    }

    function transfer(address to , uint value)external returns (bool){
        require(balanceOf[msg.sender]>value,"insifficient Funds");
        balanceOf[msg.sender]-=value;
        balanceOf[to]+=value;
        emit Transfer(msg.sender,to,value);
        return true;
    }

    function approve(address spender, uint value) external returns(bool){
        allowance[msg.sender][spender]=value;
        emit Approval(msg.sender, spender, value);
        return true;

    }
    function transferFrom(address from, address to, uint value) external returns(bool){
        require(balanceOf[from]>=value,"insufficient Funds");
        require(allowance[from][msg.sender]>=value,"allowance is less");
        balanceOf[from]-=value;
        balanceOf[to]+=value;
        allowance[from][msg.sender]-=value;
        emit Transfer(from,to,value);
        return true;
    }
    }
    



