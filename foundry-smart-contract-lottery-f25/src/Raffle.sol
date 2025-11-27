// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
 /**
     * @title A sample Raffle contract
     * @author Devang Gandhi
     * @notice This is a contract for designing the Raffle
     * @dev used chainlink VRFv2.5
     */
    

contract Raffle {
    /*Errors */

    error Raffle__SendMoreToEnterRaffle();

    uint256 private immutable i_entranceFee;
    address payable[] private s_players; // The players will get added to the array and their addresses will be payable 

    /**Events */
    event RaffleEntered(address indexed player)

    constructor(uint256 entranceFee){
        i_entranceFee=entranceFee;
    }

    function enterRaffle()public payable{

        // require(msg.value>=i_entranceFee,"Not enough ETH sent")
        // }
        if(msg.value<i_entranceFee){
            revert Raffle__SendMoreToEnterRaffle();
        }

        s_players.push(payable(msg.sender))
        //1. Makes migration faster and easier
        //2. Makes front ens "indexing" easier
        emit RaffleEntered(msg.sender);


        function pickWinner()public{

    }

    /**Getter Funtions */


    function getEntranceFee()external view returns(uint256){
        return i_entranceFee;
    }

   

}