// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Keccak2Target} from "../src/Keccak2Target.sol";

contract DeployKeccak2Target is Script {
    function run() external returns (Keccak2Target) {
        vm.startBroadcast();
        Keccak2Target target = new Keccak2Target(8967850079341);
        vm.stopBroadcast();
        return target;
    }
}
