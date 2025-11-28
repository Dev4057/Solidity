// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../src/week1/SimpleStorage.sol";

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
 *