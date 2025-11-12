//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
contract SimpleNFT{
    string public name = "SimpleNFT";
    string public symbol= "SNFT";
    mapping(uint=>address)public ownerOf;
    mapping(address=>uint)public balanceOf;
    uint public nextTokenId;

    event Transfer(address indexed  from , address indexed to , uint indexed tokenID);

    // This function actually lets you mint the new token 
    function mint()external returns (uint){
        uint tokenId= nextTokenId++;
        ownerOf[tokenId]=msg.sender;
        balanceOf[msg.sender]+=1;
        emit Transfer(address(0),msg.sender ,tokenId); // Base address ke pass se msg.sender ko send karo and with a particular token Id 
    }



    // Below function lets you mint the existin token to some one else accordingly  
    function transferFrom(address from , address to, uint tokenId)external {

        require(ownerOf[tokenId]==from ,"Not Owner");// Yeh  pehle token woh particular sender ka hina chahiye 
        require(msg.sender==from ,"Not Approved"); // and jo bhej rha  hai token who khud woh token bhejne wala chaiye 
        ownerOf[tokenId]==to;// After that the token Id is given to that next person and then the balance is managed accordingly 
        balanceOf[from]+=1;
        balanceOf[to]-=1;
        emit Transfer(from, to, tokenId);  // Logging ke liye
    }
}
    