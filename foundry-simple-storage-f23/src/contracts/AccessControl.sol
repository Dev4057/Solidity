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