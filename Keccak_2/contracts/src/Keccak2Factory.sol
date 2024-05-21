// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Keccak2.sol";

error Keccak2Factory__NotHacked();

contract Keccak2Factory {
    struct Instance {
        address instanceAddress;
        bool submited;
    }

    mapping(address => Instance) private s_instances;

    function createInstance() external {
        Keccak2 instance = new Keccak2();
        s_instances[msg.sender].instanceAddress = address(instance);
        s_instances[msg.sender].submited = false;
    }

    function verifyInstance() external {
        if (!s_instances[msg.sender].submited) {
            Keccak2 instance = Keccak2(getMyInstance());
            if (instance.getOwner() != msg.sender) {
                revert Keccak2Factory__NotHacked();
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
