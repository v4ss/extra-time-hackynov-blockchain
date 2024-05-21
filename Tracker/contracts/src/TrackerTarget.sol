// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrackerTarget {
    address private s_owner;
    bytes32 private s_secretHash;

    constructor() {
        s_owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == s_owner, "Pas owner du contrat sry :(");
        _;
    }

    function updateHash(uint256 number) external onlyOwner {
        s_secretHash = keccak256(abi.encode(number));
    }

    function getHash() external view returns (bytes32) {
        return s_secretHash;
    }
}
