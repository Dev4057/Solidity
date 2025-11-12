//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19 ;
import {Test,console} from "forge-std/Test.sol";
import{FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";


contract FundMeTest is Test{
    FundMe fundMe;
    DeployFundMe deployFundMe;
    address alice = makeAddr("alice");
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    uint256 constant  SEND_VALUE= 0.1 ether ;
    modifier funded() {
    vm.prank(alice);
    fundMe.fund{value: SEND_VALUE}();
    assert(address(fundMe).balance > 0);
    _;
}


    function setUp() external {
    deployFundMe = new DeployFundMe();
    fundMe = deployFundMe.run();
    vm.deal(alice, STARTING_BALANCE);
    
}

    function testMinimumDollarIsFive() public{
        assertEq(fundMe.MINIMUM_USD(),5e18);
    }

    // Debugging with understanding that how to check whether who is calling the function 

    // function testOwnerIsMsgSender()public {
        
    //     console.log(msg.sender);
    //     console.log(fundMe.i_owner());

        // assertEq(fundMe.i_owner(),msg.sender); 
        /*When we do this thing the error comes that PASS] testMinimumDollarIsFive() (gas: 5750)
[FAIL: assertion failed: 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496 != 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38] testOwnerIsMsgSender() (gas: 16205)        
Logs:
  0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38
  0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496 
  Cause Technically we are not the ones that deployed the FundMe contract. The FundMe contract was deployed by the setUp function, which is part of the FundMeTest contract. So, even though we are the ones who called setUp via forge test, the actual testing contract is the deployer of the FundMe contract. */
//   assertEq(fundMe.i_owner(),address(this));
//     }
function testOwnerIsMsgSender() public {
    assertEq(fundMe.getOwner(), msg.sender);
}

  function testPriceFeedVersionIsAccurate() public {
        if (block.chainid == 11155111) {
            uint256 version = fundMe.getVersion();
            assertEq(version, 4);
        } else if (block.chainid == 1) {
            uint256 version = fundMe.getVersion();
            assertEq(version, 6);
        }
  }       

        /*Create a .env file. (Also make sure that your .gitignore file contains the .env entry)

In the .env file create a new entry as follows:

SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOURAPIKEYWILLGOHERE
Run source .env in your terminal;

Run forge test --mt testPriceFeedVersionIsAccurate --fork-url $SEPOLIA_RPC_URL */


// this is the cheat code which foundry talk about to revert 
function testFundFailsWIthoutEnoughETH() public {
    vm.expectRevert(); // <- The next line after this one should revert! If not test fails.
    fundMe.fund();     // <- We send 0 value
}
    
function testFundUpdatesFundDataStructure() public {
    vm.prank(alice);
    fundMe.fund{value: SEND_VALUE}();
    uint256 amountFunded = fundMe.getAddressToAmountFunded(alice);
    assertEq(amountFunded, SEND_VALUE);
}


function testAddsFunderToArrayOfFunders()public {
    vm.startPrank(alice);
    fundMe.fund{value:SEND_VALUE}();
    vm.stopPrank();

    address funder =fundMe.getFunder(0);
    assertEq(funder,alice);
}

function testOnlyOwnerCanWithdraw()public funded{
   
    vm.expectRevert();
    
    fundMe.withdraw();
}

function testWithdrawFromASingleFunder() public funded {
    // Arrange
    uint256 startingFundMeBalance = address(fundMe).balance;
    uint256 startingOwnerBalance = fundMe.getOwner().balance;

    vm.txGasPrice(GAS_PRICE);
    uint256 gasStart = gasleft();

    // Act
    vm.startPrank(fundMe.getOwner());
    fundMe.withdraw();
    vm.stopPrank();

    uint256 gasEnd = gasleft();
    uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice;
    console.log("Withdraw consumed: %d gas", gasUsed);

    // Assert
    uint256 endingFundMeBalance = address(fundMe).balance;
    uint256 endingOwnerBalance = fundMe.getOwner().balance;
    assertEq(endingFundMeBalance, 0);
    assertEq(
        startingFundMeBalance + startingOwnerBalance,
        endingOwnerBalance
    );
}


}