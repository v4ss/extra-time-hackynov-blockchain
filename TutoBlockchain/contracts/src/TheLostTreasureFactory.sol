// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TheLostTreasure.sol";

error TheLostTreasureFactory__NotHacked();

contract TheLostTreasureFactory {
    struct Instance {
        address instanceAddress;
        bool submited;
    }

    mapping(address => Instance) private s_instances;

    function createInstance() external {
        TheLostTreasure instance = new TheLostTreasure();
        s_instances[msg.sender].instanceAddress = address(instance);
        s_instances[msg.sender].submited = false;
    }

    function verifyInstance() external {
        if (!s_instances[msg.sender].submited) {
            TheLostTreasure instance = TheLostTreasure(getMyInstance());
            if (
                keccak256(abi.encode(instance.getSubmarinePosition())) !=
                keccak256(abi.encode(instance.getChestPosition()))
            ) {
                revert TheLostTreasureFactory__NotHacked();
            } else {
                s_instances[msg.sender].submited = true;
            }
        }
    }

    function resetVerifState() external {
        if (s_instances[msg.sender].submited) {
            s_instances[msg.sender].submited = false;
        }
    }

    function goForward() external {
        TheLostTreasure instance = TheLostTreasure(getMyInstance());
        instance.goForward();
    }

    function goLeft() external {
        TheLostTreasure instance = TheLostTreasure(getMyInstance());
        instance.goLeft();
    }

    function goRight() external {
        TheLostTreasure instance = TheLostTreasure(getMyInstance());
        instance.goRight();
    }

    function goBackward() external {
        TheLostTreasure instance = TheLostTreasure(getMyInstance());
        instance.goBackward();
    }

    function resetPosition() external {
        TheLostTreasure instance = TheLostTreasure(getMyInstance());
        instance.resetPosition();
    }

    function undoMoving() external {
        TheLostTreasure instance = TheLostTreasure(getMyInstance());
        instance.undoMoving();
    }

    function getMyInstance() public view returns (address) {
        return s_instances[msg.sender].instanceAddress;
    }

    function getInstanceAddress(
        address userAddress
    ) external view returns (address) {
        return s_instances[userAddress].instanceAddress;
    }

    function getInstanceVerifState(
        address userAddress
    ) external view returns (bool) {
        return s_instances[userAddress].submited;
    }
}
