// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {FightooFactory} from "../src/FightooFactory.sol";

contract DeployFightooFactory is Script {
    function run() external returns (FightooFactory) {
        vm.startBroadcast();
        FightooFactory factory = new FightooFactory();
        vm.stopBroadcast();
        return factory;
    }
}
