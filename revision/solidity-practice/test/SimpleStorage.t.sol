// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/week1/SimpleStorage.sol";



/**
 * @title SimpleStorageTest
 * @dev Comprehensive test suite for SimpleStorage contract
 * 
 * Testing principles:
 * 1. Test happy paths (things that should work)
 * 2. Test sad paths (things that should fail)
 * 3. Test edge cases (boundary conditions)
 * 4. Test events are emitted correctly
 * 5. Test state changes are correct
 **/
 contract SimpleStorageTest is Test{
    //Test State variables

    SimpleStorage public simpleStorage;

    address public owner;
    address public user1; // Just the user not owner
    address public user2; //Just the another user not the owner 

    //SETUP

    /// @notice Runs before EACH test function
    /// @dev This gives each test a fresh contract state

        function setUp()public {
            // Create test addresses
            owner=address (this);
            user1= address(0x1);
            user2=address(0x2);



            simpleStorage=new SimpleStorage();

             // At this point:
        // - simpleStorage.owner() == address(this)
        // - simpleStorage.getNumber() == 0
        }

         function test_InitialState()public{
            //Check owner was set correctly 
            assertEq(simpleStorage.owner(),owner,"Owner should be deployer");

            //Check initial number is 0
            assertEq(simpleStorage.getNumber(),0,"Initially this number should work");

        }


        function test_OwnerCanUpdateNumber()public {
            //Owner (this contract) calls number 

            uint256 newNumber=42;
            simpleStorage.updateNumber(newNumber);

            assertEq(simpleStorage.getNumber(),newNumber,"Number should be changed to newNumber");
        }

    /// @notice Test 3: Non-owner cannot update the number
    /// @dev Sad path - this should revert with NotOwner error

        function test_NonOwnerCannotUpdate() public {
            vm.prank(user1);// Cheat-code this will call the update the function 
            //// vm.expectRevert() says "the next call should fail"
        // We expect the NotOwner() custom error
        vm.expectRevert(SimpleStorage.NotOwner.selector);
        //This  should fail beacuse user 1 is not the owner 
        simpleStorage.updateNumber(100);
        }

         /// @notice Test 4: Owner can transfer ownership
    /// @dev Happy path for ownership transfer

        function test_OwnerCanTransferOwnership()public{
            simpleStorage.transferOwnership(user1);
            assertEq(simpleStorage.owner(),user1,'Owner should be User 1');
        }

   

    /// @notice Test 6: New owner can update after ownership transfer
    /// @dev Verify ownership transfer actually works end-to-end
    function test_NewOwnerCanUpdate() public {
        // Step 1: Transfer ownership to user1
        simpleStorage.transferOwnership(user1);
        
        // Step 2: user1 should now be able to update
        vm.prank(user1);  // Next call from user1
        simpleStorage.updateNumber(999);
        
        // Verify the update worked
        assertEq(simpleStorage.getNumber(), 999, "New owner should be able to update");
    }

    /// @notice Test 6: Old owner cannot update after transferring ownership
    /// @dev Verify old owner loses privileges
    function test_OldOwnerCannotUpdateAfterTransfer() public {
        // Transfer ownership away
        simpleStorage.transferOwnership(user1);
        // Original owner (this contract) should no longer be able to update
        vm.expectRevert(SimpleStorage.NotOwner.selector);
        simpleStorage.updateNumber(100);
    }
    
    /// @notice Test 7: Non-owner cannot transfer ownership
    /// @dev Only current owner can transfer
    function test_NonOwnerCannotTransferOwnership() public {
        vm.prank(user1);  // Call from non-owner
        vm.expectRevert(SimpleStorage.NotOwner.selector);
        simpleStorage.transferOwnership(user2);
    }
 }