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
    
import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";
contract Raffle is VRFConsumerBaseV2Plus{
    /*Errors */
    error Raffle__SendMoreToEnterRaffle();
    error Raffle__TransferFailed()
    uint16 private constant REQUEST_CONFIRMATIONS=3;
    uint32 private constant NUM_WORDS=1;
    uint256 private immutable i_entranceFee;
    //@dev The duration of the lottery in seconds 
    uint256 private immutable i_interval; 
    uint256 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGasLimit;
    bytes32 private immutable i_keyHash;
    address payable[] private s_players; // The players will get added to the array and their addresses will be payable 
    uint256 private s_lastTimeStamp;
    address private s_recentWinner;
    

    
    /**Events */
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee,uint256 interval, address vrfCoordinator,bytes32 gasLane, uint256 subscriptionId, uint32 callbackGasLimit) 
        VRFConsumerBaseV2Plus(vrfCoordinator)
    {
        i_entranceFee=entranceFee;
        i_interval=interval;
        s_lastTimeStamp=block.timestamp;
        i_keyHash=gasLane;
        i_subscriptionId=subscriptionId;
        i_callbackGasLimit=callbackGasLimit;
    }

    function enterRaffle() public payable {

        // require(msg.value>=i_entranceFee,"Not enough ETH sent")
        // }
        if(msg.value < i_entranceFee){
            revert Raffle__SendMoreToEnterRaffle();
        }

        s_players.push(payable(msg.sender));
        //1. Makes migration faster and easier
        //2. Makes front ens "indexing" easier
        emit RaffleEntered(msg.sender);
    }


/**
 * 1. Get a random number
 * 2. Use random number to pick a player
 * 3. Be automatically called
*/

    function pickWinner() external {
        if ((block.timestamp - s_lastTimeStamp) < i_interval){
            revert();
        }

        /**
             * As We niw that getting a random number on blockchain in difficult so its hard to make it possible so for that we are using the chainlink VRF 
             * What is the Request and Receive cycle?
            The Data Feeds Getting Started guide explains how to consume Chainlink Data Feeds, which consist of reference data posted onchain by oracles. This data is stored in a contract and can be referenced by consumers until the oracle updates the data again.

            Randomness, on the other hand, cannot be reference data. If the result of randomness is stored onchain, any actor could retrieve the value and predict the outcome. Instead, randomness must be requested from an oracle, which generates a number and a cryptographic proof. Then, the oracle returns that result to the contract that requested it. This sequence is known as the Request and Receive cycle.
             */

            //Get our Random number
                   VRFV2PlusClient.RandomWordsRequest memory request =  VRFV2PlusClient.RandomWordsRequest(
                    {
                keyHash: i_keyHash,
                subId: i_subscriptionId,
                requestConfirmations: REQUEST_CONFIRMATIONS,
                callbackGasLimit: i_callbackGasLimit,
                numWords: NUM_WORDS,
                extraArgs: VRFV2PlusClient._argsToBytes(
                  // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
                  VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
              });
                    uint256 requestId = s_vrfCoordinator.requestRandomWords (request);

    }



    /**
     * REQUIRED by VRFConsumerBaseV2Plus
     * Chainlink node sends random words here
     */
    function fulfillRandomWords(
        uint256 requestId,
        uint256[] calldata randomWords
    ) internal override {
        // TODO: Add logic later to pick winner from randomWords


        uint256 indexOfWinner= randomWords[0]%s_players.length;
        address payable recentWinner=s_players[indexOfWinner];
        s_recentWinner=recentWinner;
        (bool,success)=recentWinner.call{value:address(this).balance}("");
        if(!success){
            revert Raffle__TransferFailed();
        }
    }



    /**Getter Funtions */
    function getEntranceFee() external view returns(uint256){
        return i_entranceFee;
    }

}
