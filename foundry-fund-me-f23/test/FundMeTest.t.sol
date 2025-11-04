//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19 ;
import {Test,console} from "forge-std/Test.sol";
import{FundMe} from "../src/FundMe.sol";


contract FundMeTest is Test{
    FundMe fundMe;
    function setUp() external {
        fundMe= new FundMe();

    }

    function testMinimumDollarIsFive() public{
        assertEq(fundMe.MINIMUM_USD(),5e18);
    }

    // Debugging with understanding that how to check whether who is calling the function 

    function testOwnerIsMsgSender()public {
        
        console.log(msg.sender);
        console.log(fundMe.i_owner());

        // assertEq(fundMe.i_owner(),msg.sender); 
        /*When we do this thing the error comes that PASS] testMinimumDollarIsFive() (gas: 5750)
[FAIL: assertion failed: 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496 != 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38] testOwnerIsMsgSender() (gas: 16205)        
Logs:
  0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38
  0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496 
  Cause Technically we are not the ones that deployed the FundMe contract. The FundMe contract was deployed by the setUp function, which is part of the FundMeTest contract. So, even though we are the ones who called setUp via forge test, the actual testing contract is the deployer of the FundMe contract. */
  assertEq(fundMe.i_owner(),address(this));
    }

    function testPriceFeedVersionIsAccurate()public{
        uint256 version =fundMe.getVersion();
        assertEq(version,4);
        /*Create a .env file. (Also make sure that your .gitignore file contains the .env entry)

In the .env file create a new entry as follows:

SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOURAPIKEYWILLGOHERE
Run source .env in your terminal;

Run forge test --mt testPriceFeedVersionIsAccurate --fork-url $SEPOLIA_RPC_URL */

    }

}

