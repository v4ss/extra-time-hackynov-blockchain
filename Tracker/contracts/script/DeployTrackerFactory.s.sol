// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {TrackerFactory} from "../src/TrackerFactory.sol";

contract DeployTrackerFactory is Script {
    function run() external returns (TrackerFactory) {
        vm.startBroadcast();
        TrackerFactory factory = new TrackerFactory();
        vm.stopBroadcast();
        return factory;
    }
}
