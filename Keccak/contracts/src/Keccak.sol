// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

error Keccak__InvalidHash();

contract Keccak {
    address private s_owner;

    constructor() {
        s_owner = msg.sender;
    }

    function changeOwner(bytes32 hash) public {
        if (hash != keccak256(abi.encodePacked(msg.sender)))
            revert Keccak__InvalidHash();

        s_owner = msg.sender;
    }

    function getOwner() public view returns (address) {
        return s_owner;
    }
}
