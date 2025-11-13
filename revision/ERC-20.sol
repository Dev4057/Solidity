
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract token{

    string public name = "Dev Token";
    string public symbol="DEV";
    uint256 public totalSupply;

    mapping(address=>uint256)public balances;// Mapping to store how tokes does each user stores 
    // Address of the contract owner 
    address public owner ;


    //Events to log transfers
    event transfer (address indexed from, address indexed to, uint256 amount  );
    event Mint(address to , uint amount);// Minting mai from ka addres mera hi rahega

    constructor (uint _initialSupply){
        owner= msg.sender;//Whoever deploys is the owner 
        totalSupply = _initialSupply;
        balances[msg.sender]=_initialSupply;// Give the total suply to the msg.sender;
    }
    modifier onlyOwner{
        require(msg.sender==owner,"Not Owner")
    }

    function transfer(address to ,uint _amount)external {
        require(balances[msg.sender]>=_amount,"Not Enought Tokens ");
        balances[msg.sender]-=amount;
        balances[to]+=amount ;
        emit transfer(msg.sender,to, _amount);
    }

    function mint ( address to , uint _amount )external onlyOwner{
        totalSupply+=amount;
        balances[to]+=amount;

        emit Mint(to,amount);
    }

    function balancesOf(address account)external view returns(uint){
        return balances[account];
    }
}