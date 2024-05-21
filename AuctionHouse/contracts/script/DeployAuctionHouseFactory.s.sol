// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {AuctionHouseFactory} from "../src/AuctionHouseFactory.sol";

contract DeployAuctionHouseFactory is Script {
    function run() external returns (AuctionHouseFactory) {
        vm.startBroadcast();
        AuctionHouseFactory factory = new AuctionHouseFactory();
        vm.stopBroadcast();
        return factory;
    }
}
