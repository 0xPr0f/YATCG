//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract CharacterCard is ERC721, ERC721Enumerable, ERC721URIStorage {
    constructor() ERC721("Character Cards", "CC") {}
    uint256 private _tokenIdCounter;

    enum Class {
        mage,
        swordsman,
        priest,
        king,
        demon,
        god
    }
    struct Lore {
        string name;
        string tittle;
        string description_story;
    }
    // the unit 8 should be in 10 ** 5, where for level, it is 10000000 = 100.00000, where level 100 is max
    //and all other smaller numbers build up to make the level
    struct Power {
        uint8 baseHealth;
        uint8 baseAttack;
        // level is same as ex for characters, doesnt define much of a character but how strong they are
        // certain characters are minted with 1 - 10level and cap out at 100 (* 10 ** 5)
        uint8 level;
    }
    struct Equipments {
        uint256 WeaponId;
        uint256 ArmorId;
    }
    struct Stats {
        Lore lore;
        Class class;
        Power power;
    }

    mapping(uint256 => Stats) public stats;
    mapping(uint256 => Lore) public lore;
    mapping(uint256 => Equipments) public equipments;

    function mint(address to, string memory uri) public returns (uint256) {
        _tokenIdCounter++;
        _safeMint(to, _tokenIdCounter);
        _setTokenURI(_tokenIdCounter, uri);
        return _tokenIdCounter;
    }
    function returnTokenId() external view returns (uint) {
        return _tokenIdCounter;
    }

    /**
     * @dev Function to burn a character card.
     * @param _tokenId ID of the character card to be burned.
     * @return The ID of the burned character card.
     */
    function burn(uint256 _tokenId) public returns (uint256) {
        _burn(_tokenId);
        return _tokenId;
    }
    function attachWeapon(uint256 weapon_tokenID) external returns (bool) {
        // check if the user is card owner and weapon owner
    }
    function detachWeapon() external returns (bool) {
        // check if the user is the card owner but not the weapon owner
    }

    function attachArmor(uint256 armor_tokenID) external returns (bool) {
        // check if the user is card owner and weapon owner
    }
    function detachArmor() external returns (bool) {
        // check if the user is the card owner but not the weapon owner
    }

    function damage() public view returns (uint256) {
        //  return
    }

    function attachedArmorID(uint256 tokenId) public view returns (uint256) {
        return equipments[tokenId].ArmorId;
    }
    function attachedWeaponID(uint256 tokenId) public view returns (uint256) {
        return equipments[tokenId].WeaponId;
    }
    // No armor or card can be the 0 id, but when an armor or card is reset, it id given 0
    function isAttachedArmor(uint256 tokenId) external view returns (bool) {
        return attachedArmorID(tokenId) != 0 ? true : false;
    }
    function isAttachedWeapon(uint256 tokenId) external view returns (bool) {
        return attachedWeaponID(tokenId) != 0 ? true : false;
    }

    /**
     * @dev Function to set the token URI.
     * @param _tokenId ID of the token.
     * @param _tokenURI URI of the token.
     */
    function setTokenURI(uint _tokenId, string memory _tokenURI) external {
        _setTokenURI(_tokenId, _tokenURI);
    }

    /**
     * @dev Function to get the token ID of an owner by index.
     * @param owner Address of the owner.
     * @param index Index of the token.
     * @return The token ID.
     */
    function _tokenOfOwnerByIndex(
        address owner,
        uint index
    ) external view returns (uint) {
        return super.tokenOfOwnerByIndex(owner, index);
    }

    /**
     * @dev Function to get the token ID by index.
     * @param index Index of the token.
     * @return The token ID.
     */
    function _tokenByIndex(uint index) public view returns (uint) {
        return super.tokenByIndex(index);
    }

    /**
     * @dev Function to get the owner of a token by index.
     * @param index Index of the token.
     * @return The owner address.
     */
    function _getOwnerByIndex(uint index) public view returns (uint256) {
        return super.tokenOfOwnerByIndex(address(msg.sender), index);
    }

    /**
     * @dev Function to get the owner of a token by index.
     * @param index Index of the token.
     * @return The owner address.
     */
    function getOwnerByIndex(uint256 index) public view returns (address) {
        uint256 tokenId = tokenByIndex(index);
        address owner = ownerOf(tokenId);
        return owner;
    }

    /**
     * @dev Function to return all token IDs owned by an address.
     * @param _address Address of the owner.
     * @return An array containing all token IDs owned by the address.
     */
    function returnAllOwnerTokenId(
        address _address
    ) external view returns (uint[] memory) {
        uint balance = balanceOf(_address);
        uint[] memory _token = new uint[](balance); // Initialize dynamic array in memory
        for (uint i = 0; i < balance; ++i) {
            _token[i] = tokenOfOwnerByIndex(_address, i);
        }
        return _token;
    }

    // The following functions are overrides required by Solidity.

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(
        address account,
        uint128 value
    ) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
