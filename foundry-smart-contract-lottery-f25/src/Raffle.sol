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
    
    import {VRFConsumerBaseV2Plus} from "@chainlink/contracts@1.5.0/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";

contract Raffle {
    /*Errors */
    error Raffle__SendMoreToEnterRaffle();

    uint256 private immutable i_entranceFee;
    //@dev The duration of the lottery in seconds 
    uit256 private immutable i_interval; 
    address payable[] private s_players; // The players will get added to the array and their addresses will be payable 
    uint256 private s_lastTimeStamp;

    
    /**Events */
    event RaffleEntered(address indexed player)

    constructor(uint256 entranceFee){
        i_entranceFee=entranceFee;
        i_interval=interval;
        s_lastTimeStamp=block.timestamp;
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



/**
 * 1. Get a random number
 * 2. Use random number to pick a player
 * 3. Be automatically called
 */

        function pickWinner() external {
           if ((block.timeStamp-s_lastTimeStamp)<i_interval){
                revert();
            }

            /**
             * As We niw that getting a random number on blockchain in difficult so its hard to make it possible so for that we are using the chainlink VRF 
             * What is the Request and Receive cycle?
            The Data Feeds Getting Started guide explains how to consume Chainlink Data Feeds, which consist of reference data posted onchain by oracles. This data is stored in a contract and can be referenced by consumers until the oracle updates the data again.

            Randomness, on the other hand, cannot be reference data. If the result of randomness is stored onchain, any actor could retrieve the value and predict the outcome. Instead, randomness must be requested from an oracle, which generates a number and a cryptographic proof. Then, the oracle returns that result to the contract that requested it. This sequence is known as the Request and Receive cycle.
             */

            //Get our Random number
            

            
    }



    /**Getter Funtions */
    function getEntranceFee()external view returns(uint256){
        return i_entranceFee;
    }

   

}