
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import"@openzeppelin/contracts/access/Ownable.sol";

contract Twitter is Ownable{

uint16 public MAX_TWEET_LENGTH = 280;

    struct Tweet{
     uint256 id;
     address author;
     string content;
     uint256 timestamp;
     uint256 likes;
    }
mapping (address => Tweet[] ) public tweets;

event TweetCreated(uint256 id, address author, string content, uint256 timestamp);
event TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount );
event TweetUnliked(address unliker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);

constructor() Ownable(msg.sender) {}

function changeTweetLength(uint16 newTweetLength)public onlyOwner {
MAX_TWEET_LENGTH = newTweetLength;
}

function   getTotalLikes(address _author) external view returns (uint){
    uint totalLikes;
    for(uint i = 0; i < tweets[_author].length; i++){
totalLikes += tweets[_author][i].likes;
    }
    return totalLikes;
}

// allows users to create a new tweet
function createTweet(string memory _tweet) public{
    //ensures tweet doesnt exceed max length
    require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long" );

Tweet memory newTweet = Tweet({
    id: tweets[msg.sender].length,
    author: msg.sender,
    content: _tweet,// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import"@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract Twitter is Ownable{

uint16 public MAX_TWEET_LENGTH = 280;

    struct Tweet{
     uint256 id;
     address author;
     string content;
     uint256 timestamp;
     uint256 likes;
    }
mapping (address => Tweet[] ) public tweets;

event TweetCreated(uint256 id, address author, string content, uint256 timestamp);
event TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount );
event TweetUnliked(address unliker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);

constructor() Ownable(msg.sender) {
    console.log("Contract deployed by:", msg.sender);
}

function changeTweetLength(uint16 newTweetLength)public onlyOwner {
    console.log("Changing tweet length to:", newTweetLength);
    MAX_TWEET_LENGTH = newTweetLength;
}

function   getTotalLikes(address _author) external view returns (uint){
    uint totalLikes;
    for(uint i = 0; i < tweets[_author].length; i++){
        totalLikes += tweets[_author][i].likes;
    }
    console.log("Total likes for author:", _author, "is:", totalLikes);
    return totalLikes;
}

// allows users to create a new tweet
function createTweet(string memory _tweet) public{
    //ensures tweet doesnt exceed max length
    require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long" );

    console.log("Creating new tweet:", _tweet, "by author:", msg.sender);
    Tweet memory newTweet = Tweet({
        id: tweets[msg.sender].length,
        author: msg.sender,
        content: _tweet,
        timestamp: block.timestamp,
        likes: 0
    });

    tweets[msg.sender].push(newTweet);
    console.log("Tweet created with id:", newTweet.id);
    emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
}

//allows users to like a specific tweet
function likeTweet(address author, uint256 id)external{
    //increments like count of the tweet
    require( tweets[author][id].id == id,"TWEET DOES NOT EXIST" );
    console.log("Liking tweet with id:", id, "by author:", author);
    tweets[author][id].likes++;

    console.log("Tweet liked. New like count:", tweets[author][id].likes);
    emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
}

//allows users to unlike a specific tweet
function unlikeTweet(address author, uint256 id)external{
    //decrements like count of the tweet, ensures user has at leats one like before decrementing
    require( tweets[author][id].id == id,"TWEET DOES NOT EXIST" );
    require( tweets[author][id].likes > 0,"THERE ARE NO LIKES" );
    console.log("Unliking tweet with id:", id, "by author:", author);
    tweets[author][id].likes--;

    console.log("Tweet unliked. New like count:", tweets[author][id].likes);
    emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
}

//retrieves a specific tweet
function getTweet(  uint _i) public view returns(Tweet memory){
    console.log("Retrieving tweet with index:", _i, "by author:", msg.sender);
    return tweets [msg.sender][_i];
}

//fetches all tweets posted by a given address
function getAllTweets (address _owner) public view returns(Tweet[] memory){
    console.log("Retrieving all tweets by author:", _owner);
    return tweets[_owner];
}
}
    timestamp: block.timestamp,
    likes: 0
});

    tweets[msg.sender].push(newTweet);
    emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
}

//allows users to like a specific tweet
function likeTweet(address author, uint256 id)external{
    //increments like count of the tweet
    require( tweets[author][id].id == id,"TWEET DOES NOT EXIST" );
 tweets[author][id].likes++;

 emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
}

//allows users to unlike a specific tweet
function unlikeTweet(address author, uint256 id)external{
    //decrements like count of the tweet, ensures user has at leats one like before decrementing
    require( tweets[author][id].id == id,"TWEET DOES NOT EXIST" );
    require( tweets[author][id].likes > 0,"THERE ARE NO LIKES" );
 tweets[author][id].likes--;

 emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);

}

//retrieves a specific tweet
function getTweet(  uint _i) public view returns(Tweet memory){
    return tweets [msg.sender][_i];
}

//fetches all tweets posted by a given address
function getAllTweets (address _owner) public view returns(Tweet[] memory){
    return tweets[_owner];
}
} 