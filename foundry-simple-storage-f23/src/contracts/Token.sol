// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


// Here the interface works rules works same as the java interface.
interface IGreeter {
    function greet() external view returns (string memory);
}

// Abstracts can be partially define the function 
abstract contract AbstractGreeter {
    function greet() public view virtual returns (string memory);
}

contract Greeter is AbstractGreeter, IGreeter {
    string public greeting;

    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    function greet() public view override(AbstractGreeter, IGreeter) returns (string memory) {
        return greeting;
    }
}
