// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TrackerTarget.sol";

error Tracker__NotOwner();
error Tracker__InvalidHash();

contract Tracker {
    address private s_owner;
    TrackerTarget private s_targetContract =
        TrackerTarget(0xcAb4B050bcf9f4b2f048eB3619eD5354d451b3cc);

    constructor() {
        s_owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != s_owner) revert Tracker__NotOwner();
        _;
    }

    function changeOwner(uint256 secretNumber) external {
        bytes32 hash = s_targetContract.getHash();
        if (hash != keccak256(abi.encode(secretNumber)))
            revert Tracker__InvalidHash();

        s_owner = msg.sender;
    }

    function getOwner() external view returns (address) {
        return s_owner;
    }

    function getSecret() external view onlyOwner returns (string memory) {
        return "Find the secret key";
    }
}
