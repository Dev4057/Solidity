//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

contract Ownable{
    address private _owner;
    
    event ownerShipTransferred(address indexed from , address indexed to);

    modifier onlyOwner(){
        require(msg.sender==_owner,"Only owner can transfer the ownership");
        _;
    }

    constructor(){
        _owner=msg.sender;
        emit ownerShipTransferred(address(0),msg.sender);
    }

    function owner()public view returns(address){
        return _owner;
    }
    function transferOwnership(address newOwner)public onlyOwner{

        require(newOwner!=address(0),"Ownable: New owner is a zero address");
        address oldOwner= _owner; // This we did cause to understand from which address actually the owner ship got transferred that is ahy we stores it in the oldOwner variable and then gave _owner a new value.
        _owner=newOwner;

        emit ownerShipTransferred(oldOwner,newOwner);
    }

    function renounceOwnership public () onlyOnwer{
        emit ownerShipTransferred(_owner,address(0));
        _owner=address(0);
    }
}