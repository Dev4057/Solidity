//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

contract AccessControl{

    address public owner ;
    mapping(address=>bool)public admins;

    event ownerShipTransferred(address indexed oldOwner,address indexed newOwner);
    event AdminToggled(address indexed admin, bool enabled);

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"Not Owner");
        _;
    }

    function transferOwnerShip(address newowner )external onlyOwner{
        require(newowner!=address(0),"Invalid Address");
        emit ownerShipTransferred(owner, newowner);
        owner=newowner;
    }

    function toggleAdmin(address _admin,bool _enabled)external onlyOwner{
        admins[_admin]=_enabled;
        emit AdminToggled(_admin, _enabled);
    }
    modifier onlyAdmin(){
        require(admins[msg.sender],"Not Admin");
        _;
    }


    function sensitiveAction() external onlyAdmin {
        // logic only admins can run
    }

}

/ SO basically what is happening in this contract is first we declared a the address of owner and did the mapping that wich adddress can be  admin
/* So now the contructor gets called and the who ever deploys the contract has the access so now of the full contract and he can only transffer the ownership to other contracts 
  then function declarations are made where we are actually giving the access to the new address by defiing the modifieers and etc things */