// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {TheLostTreasureFactory} from "../src/TheLostTreasureFactory.sol";

contract DeployTheLostTreasureFactory is Script {
    function run() external returns (TheLostTreasureFactory) {
        vm.startBroadcast();
        TheLostTreasureFactory factory = new TheLostTreasureFactory();
        vm.stopBroadcast();
        return factory;
    }
}
