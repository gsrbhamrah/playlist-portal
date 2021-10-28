// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract PlaylistPortal {
    uint256 totalPlists;

    uint256 private seed;

    event NewPlist(address indexed from, uint256 timestamp, string message);

    struct Plist {
        address sharer;
        string message;
        uint256 timestamp;
    }

    Plist[] plists;

    mapping(address => uint256) public lastSharedAt;

    constructor() payable {
        console.log("This here is a smart contract!");
    }

    // function plist below will share a playlist
    function plist(string memory _message) public {
        require(
            lastSharedAt[msg.sender] + 5 minutes < block.timestamp,
            "Wait 5m"
        );

        lastSharedAt[msg.sender] = block.timestamp;

        totalPlists += 1;
        console.log("%s has shared a playlist!", msg.sender);

        plists.push(Plist(msg.sender, _message, block.timestamp));

        uint256 randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %s", randomNumber);

        seed = randomNumber;

        if (randomNumber < 50) {
            console.log("%s won!", msg.sender);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    emit NewPlist(msg.sender, block.timestamp, _message);
}

    function getAllPlists() public view returns (Plist[] memory) {
        return plists;
    }

    function getTotalPlists() public view returns (uint256) {
        console.log("We have %d total playlists!", totalPlists);
        return totalPlists;
    }
}