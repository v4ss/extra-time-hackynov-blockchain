// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract KeccakSolution {
    // Call this function to calculate the hash who permits you to become owner
    // Get the hash and call the function changeOwner() with it
    function getHash() public view returns (bytes32) {
        bytes32 hash = keccak256(abi.encodePacked(msg.sender));
        return hash;
    }
}
