// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {WriterFactory} from "../src/WriterFactory.sol";

contract DeployWriterFactory is Script {
    function run() external returns (WriterFactory) {
        vm.startBroadcast();
        WriterFactory factory = new WriterFactory();
        vm.stopBroadcast();
        return factory;
    }
}
