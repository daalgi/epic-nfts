// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    // Arrays, each with their own theme of random words.
    string[] firstWords = [
        "Fat", 
        "Buddy", 
        "Sticky", 
        "Old", 
        "Texas", 
        "Boney", 
        "Toothless", 
        "Skinny", 
        "Sleepy"
    ];
    string[] secondWords = [
        "Bones", 
        "Money", 
        "Harp", 
        "Legs", 
        "Eyes", 
        "Lemon", 
        "Killer", 
        "Hips", 
        "Lips", 
        "Fingers"
    ];
    string[] thirdWords = [
        "Jackson", 
        "Hopkins", 
        "Lee", 
        "Davis", 
        "Washington", 
        "Green", 
        "White", 
        "Brown"
    ];
    
    constructor() ERC721 ("SquareNFT", "SQUARE") {
        console.log("My NFT contract created");
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256((abi.encodePacked(input))));
    }

    function pickRandomWord(uint256 tokenId, string[] memory wordList) private pure returns (string memory) {
        uint256 rand = random(string(
            abi.encodePacked(wordList[0], Strings.toString(tokenId))
        ));
        rand = rand % wordList.length;
        return wordList[rand];
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        // Dynamic word generation
        string memory first = pickRandomWord(newItemId, firstWords);
        string memory second = pickRandomWord(newItemId, secondWords);
        string memory third = pickRandomWord(newItemId, thirdWords);
        string memory combinedWord = string(
            abi.encodePacked(first, second, third)
        );

        // Concatenate svg all together
        string memory svg = string(
            abi.encodePacked(baseSvg, first, second, third, "</text></svg>")
        );

        // Generate the JSON metadata
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name":"',
                        combinedWord,
                        '","description":"Randomly generated Blues name", "image":"data:image/svg+xml;base64,',
                        Base64.encode(bytes(svg)),
                        '"}'
                    )
                )
            )
        );

        // Prepend "data:application/json;base64,"
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(svg);
        console.log("--------------------\n");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, svg);
        console.log("Minted NFT with ID %s", newItemId);
        _tokenIds.increment();        
    }
}