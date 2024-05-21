// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Keccak.sol";

error KeccakFactory__NotHacked();

contract KeccakFactory {
    struct Instance {
        address instanceAddress;
        bool submited;
    }

    mapping(address => Instance) private s_instances;

    function createInstance() external {
        Keccak instance = new Keccak();
        s_instances[msg.sender].instanceAddress = address(instance);
        s_instances[msg.sender].submited = false;
    }

    function verifyInstance() external {
        if (!s_instances[msg.sender].submited) {
            Keccak instance = Keccak(getMyInstance());
            if (instance.getOwner() != msg.sender) {
                revert KeccakFactory__NotHacked();
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
