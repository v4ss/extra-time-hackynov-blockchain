// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Keccak2Target.sol";

error Keccak2__NotOwner();
error Keccak2__InvalidHash();

contract Keccak2 {
    address private s_owner;
    Keccak2Target private s_targetContract =
        Keccak2Target(0x6Bb436f76fa0d3BC02EdEAB425594B350dd4Ed2B);

    constructor() {
        s_owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != s_owner) revert Keccak2__NotOwner();
        _;
    }

    function changeOwner(uint256 secretNumber) external {
        bytes32 hash = s_targetContract.getHashNumber();
        if (hash != keccak256(abi.encode(secretNumber)))
            revert Keccak2__InvalidHash();

        s_owner = msg.sender;
    }

    function getOwner() external view returns (address) {
        return s_owner;
    }

    function getSecret() external view onlyOwner returns (string memory) {
        return "Find the secret key";
    }
}
