//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.4;

contract Tweet {
	// data structure of a single tweet
    struct Tweet {
		uint timestamp;
		string tweetString;
	}
	// "dict" of all tweets of specific tag
	mapping (string => Tweet[]) public _tweetWithTag;
	mapping (uint => Tweet) _tweets;

	// total number of tweets in the above _tweets mapping
	uint public _numberOfTweets;
	// constructor
	constructor () {
		_numberOfTweets = 0;
		// _adminAddress = msg.sender;
	}

	// create new tweet with Tag
	function tweetWithTag(string memory tweetString, string memory hashTag) public returns (int) {
		if (bytes(tweetString).length + bytes(hashTag).length > 160 ) {
			return -1;
		}
		if (bytes(hashTag).length > 0 && bytes(tweetString).length > 0 ) {
			return -1;
		}
		Tweet memory t = Tweet(block.timestamp,tweetString);
		_tweetWithTag[hashTag].push(t);
		_tweets[_numberOfTweets] = t;
		_numberOfTweets++;
		return 0; // success
	}

	//create tweet
	function tweet(string memory tweetString) public returns (int) {
		if (bytes(tweetString).length > 160 || bytes(tweetString).length == 0) {
			// tweet contains more than 160 bytes
			return -1;
		}
		_tweets[_numberOfTweets].timestamp = block.timestamp;
		_tweets[_numberOfTweets].tweetString = tweetString;
		_numberOfTweets++;
		return 0; // success
	}
	
	function getTweetsWithTag(string memory hashTag) public view returns (Tweet[] memory) {
		// returns
		return _tweetWithTag[hashTag];
	}

	function getTweet(uint tweetId) public view returns (string memory tweetString, uint timestamp) {
		// returns two values
		tweetString = _tweets[tweetId].tweetString;
		timestamp = _tweets[tweetId].timestamp;
	}
	
	function getLatestTweet()  public view returns (string memory tweetString, uint timestamp, uint numberOfTweets) {
		// returns three values
		tweetString = _tweets[_numberOfTweets - 1].tweetString;
		timestamp = _tweets[_numberOfTweets - 1].timestamp;
		numberOfTweets = _numberOfTweets;
	}

	function getNumberOfTweets()  public view returns (uint numberOfTweets) {
		return _numberOfTweets;
	}
}
