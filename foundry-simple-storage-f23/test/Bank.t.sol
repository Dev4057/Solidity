// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/Revision/Bank.sol";

contract BankTest is Test {
    Bank bank;

    // Needed so test contract can receive ETH
    receive() external payable {}

    function setUp() public {
        bank = new Bank();
    }

    function testDeposit() public {
        bank.deposit{value: 1 ether}();
        assertEq(bank.getBalance(address(this)), 1 ether);
    }

    function testWithdraw() public {
        bank.deposit{value: 1 ether}();
        bank.withdraw(0.5 ether);
        assertEq(bank.getBalance(address(this)), 0.5 ether);
    }

    function testRevertWhenWithdrawTooMuch() public {
        bank.deposit{value: 1 ether}();
        vm.expectRevert(); // expecting a revert
        bank.withdraw(2 ether);
    }
}
