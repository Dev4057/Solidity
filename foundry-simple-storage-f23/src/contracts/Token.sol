// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IGreeter {
    function greet() external view returns (string memory);
}

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
