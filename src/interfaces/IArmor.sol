//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IArmor {
    // asumming all of them are raised to power 5
    function damage(uint256 tokenID) external returns (uint256);
    function health(uint256 tokenID) external returns (uint256);
    function attachedCharacter(uint256 tokenID) external returns (uint256);
    function getOwnerByIndex(uint256 tokenID) external view returns (address);
}
