pragma solidity ^0.8.13;

contract CharacterCard {
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
    struct Stats {
        Lore lore;
        Class class;
        Power power;
    }

    mapping(uint256 => Stats) public stats;
    mapping(uint256 => Lore) public lore;
}
