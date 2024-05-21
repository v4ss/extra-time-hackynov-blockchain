// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {KeccakFactory} from "../src/KeccakFactory.sol";

contract DeployKeccakFactory is Script {
    function run() external returns (KeccakFactory) {
        vm.startBroadcast();
        KeccakFactory factory = new KeccakFactory();
        vm.stopBroadcast();
        return factory;
    }
}
