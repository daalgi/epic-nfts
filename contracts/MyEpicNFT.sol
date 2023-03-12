// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint16 NFT_NUM_MAX = 10000;
    uint256 TOKEN_PRICE = 70e15;

    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    // Arrays, each with their own theme of random words.
    string[] firstWords = [
        "Fat", 
        "Buddy", 
        "Sticky", 
        "Old", 
        "Broke", 
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
        "Brown",
        "Madison"
    ];
    
    event NewEpicNFTMinted(address sender, uint256 tokenId);

    constructor() ERC721 ("SquareNFT", "SQUARE") {
        console.log("My NFT contract created");
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256((abi.encodePacked(input))));
    }

    function pickRandomWord(uint256 tokenId, uint16 arrayId) private view returns (string memory) {
        string[] memory wordList;
        if (arrayId == 1) {
            wordList = firstWords;
        } else if (arrayId == 2) {
            wordList = secondWords;
        } else {
            wordList = thirdWords;
        }
        uint256 rand = random(string(
            abi.encodePacked(arrayId, Strings.toString(tokenId))
        ));
        rand = rand % wordList.length;
        return wordList[rand];
    }

    function makeAnEpicNFT() public payable {
        uint256 newItemId = _tokenIds.current();
        require(newItemId < NFT_NUM_MAX, "All the NFTs have been minted, no one left!");

        require(msg.value >= TOKEN_PRICE, "Not enough funds to mint!");

        // Dynamic word generation
        string memory first = pickRandomWord(newItemId, 1);
        string memory second = pickRandomWord(newItemId, 2);
        string memory third = pickRandomWord(newItemId, 3);
        string memory combinedWord = string(
            abi.encodePacked(first, second, third)
        );

        // Concatenate svg all together
        string memory svg = string(
            abi.encodePacked(baseSvg, combinedWord, "</text></svg>")
        );

        // Generate the JSON metadata
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        combinedWord,
                        '", "description": "Randomly generated Blues name", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
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
        console.log(combinedWord);
        console.log("\n--------------------");
        console.log(svg);
        console.log("--------------------\n");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, finalTokenUri);
        _tokenIds.increment();
        console.log("Minted NFT with ID %s", newItemId);
        emit NewEpicNFTMinted(msg.sender, newItemId);
    }
}