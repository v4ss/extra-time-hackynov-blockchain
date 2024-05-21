// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error Storage__InvalidSecretNumber();

contract Storage {
    address private s_owner;
    uint128 private s_mySuperValue;
    uint16 private s_myLittleValue;
    string private s_message =
        "Fouillez dans les abysses, vous trouverez peut etre quelques chose ...";
    uint256 private s_secretNumber = 6037859961005;

    constructor() {
        s_owner = msg.sender;
    }

    function changeOwner(uint256 secretNumber) external {
        if (secretNumber != s_secretNumber)
            revert Storage__InvalidSecretNumber();

        s_owner = msg.sender;
    }

    function getOwner() external view returns (address) {
        return s_owner;
    }
}
