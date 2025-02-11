// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Twitter} from "../src/Twitter.sol";

contract DeployTwitter is Script {
    function run() external {
        vm.startBroadcast();
        new Twitter();
        vm.stopBroadcast();
    }
}
