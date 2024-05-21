// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Keccak2Target {
    uint256 private s_secretNumber;

    constructor(uint256 _secretNumber) {
        s_secretNumber = _secretNumber;
    }

    function getHashNumber() external view returns (bytes32) {
        return keccak256(abi.encode(s_secretNumber));
    }
}
