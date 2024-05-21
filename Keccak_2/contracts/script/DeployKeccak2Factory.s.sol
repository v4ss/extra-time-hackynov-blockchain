// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Keccak2Factory} from "../src/Keccak2Factory.sol";

contract DeployKeccak2Factory is Script {
    function run() external returns (Keccak2Factory) {
        vm.startBroadcast();
        Keccak2Factory keccak2 = new Keccak2Factory();
        vm.stopBroadcast();

        return keccak2;
    }
}
