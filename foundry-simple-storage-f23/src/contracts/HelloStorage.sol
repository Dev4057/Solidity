// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract HelloStorage {
    string public message;

    constructor(string memory _message) {
        message = _message;
    }

    function setMessage(string calldata _message) external {
        message = _message;
    }

    function getMessage() external view returns (string memory) {
        return message;
    }
}
