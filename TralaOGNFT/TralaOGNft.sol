// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TralaOgNft is ERC721URIStorage, Ownable {
    uint256 private _maxTokenId;
    string private _tokenURI;

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    event SetTokenURI(string preURI, string setURI);

    constructor(
        string memory tokenURI,
        address initialOwner
    ) ERC721("TRALA OG NFT", "TON") Ownable(initialOwner) {
        _maxTokenId = 2222;
        _tokenURI = tokenURI;
    }

    function safeMultiMint(uint count) public onlyOwner {
        uint256 tokenId;
        for (uint i = 0; i < count; i++) {
            _tokenIdCounter.increment();
            tokenId = _tokenIdCounter.current();
            require(tokenId <= _maxTokenId, "Minting is over");
            _safeMint(msg.sender, tokenId);
            _setTokenURI(tokenId, _tokenURI);
        }
    }

    function setTokenURI(string memory tokenURI) public onlyOwner {
        string memory preURI = _tokenURI;
        _tokenURI = tokenURI;
        emit SetTokenURI(preURI, _tokenURI);
    }
}
