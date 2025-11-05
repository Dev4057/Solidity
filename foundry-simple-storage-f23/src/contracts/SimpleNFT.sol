//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
contract SimpleNFT{
    string public name = "SimpleNFT";
    string public symbol= "SNFT";
    mapping(uint=>address)public ownerOf;
    mapping(address=>uint)public balanceOf;
    uint public nextTokenId;

    event Transfer(address indexed  from , address indexed to , uint indexed tokenID);

    function mint()external returns (uint){
        uint tokenId= nextTokenId++;
        ownerOf[tokenId]=msg.sender;
        balanceOf[msg.sender]+=1;
        emit Transfer(address(0),msg.sender ,tokenId);
    }

    // Below function lets you mint the existin token to some one else accordingly  
    function transferFrom(address from , address to, uint tokenId)external {

        require(ownerOf[tokenId]==from ,"Not Owner");
        require(msg.sender==from ,"Not Approved");
        ownerOf[tokenId]==to;
        balanceOf[from]+=1;
        balanceOf[to]-=1;
        emit Transfer(from, to, tokenId);
    }
}
    