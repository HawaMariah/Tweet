// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DeployTwitter} from "../script/DeployTwitter.s.sol";
import {Twitter} from "../src/Twitter.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TwitterTest is Test {
    Twitter twitter; //state variable is declared to store the deployed contract instance
    address user = makeAddr("user");
    address owner = makeAddr("owner");

    error OwnableUnauthorizedAccount(address account);

    function setUp() public {
        //setup is special function runs before each test
        vm.prank(owner);
        twitter = new Twitter(); //deploy a new contract instances to ensure each test starts with a fresh contract instance
    }

    function testCreateTweet() public {
        vm.prank(user);
        //  1: Define the tweet content
        string memory tweetContent = "Hello, Web3!";

        //  2: Call the createTweet function
        twitter.createTweet(tweetContent);

        //  3: Retrieve the created tweet
        Twitter.Tweet[] memory tweet = twitter.getAllTweets(user);

        //  4: Validate the tweet content
        assertEq(tweet[0].content, tweetContent);

        //  5: Validate the tweet author
        assertEq(tweet[0].author, user);

        //  6: Ensure the tweet starts with 0 likes
        assertEq(tweet[0].likes, 0);
    }

    function testOwnerChangeTweetLength() public {
        vm.prank(owner);
        twitter.changeTweetLength(400);
        assertEq(twitter.MAX_TWEET_LENGTH(), 400);
    }

    function testNonOwnerCantChangeTweetLength() public {
        vm.prank(user); //simulate a non-owner calling the functiom
        vm.expectRevert(abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, user));
        twitter.changeTweetLength(400);
    }
}
