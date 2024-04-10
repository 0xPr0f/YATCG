//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface ICharacter {
    // asumming all of them are raised to power 5
    function damage(uint256 tokenID) external returns (uint256);
    function health(uint256 tokenID) external returns (uint256);
    function attachedArmor(uint256 tokenID) external returns (uint256);
    function attachedWeapon(uint256 tokenID) external returns (uint256);
    function attachedArmor_Weapon(
        uint256 tokenID
    ) external returns (uint256, uint256);
    function getOwnerByIndex(uint256 tokenID) external view returns (address);
}
