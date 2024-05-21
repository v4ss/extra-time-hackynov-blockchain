// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {StorageFactory} from "../src/StorageFactory.sol";

contract DeployStorageFactory is Script {
    function run() external returns (StorageFactory) {
        vm.startBroadcast();
        StorageFactory factory = new StorageFactory();
        vm.stopBroadcast();
        return factory;
    }
}
