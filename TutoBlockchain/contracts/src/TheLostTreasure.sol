// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error TheLostTreasure__InvalidPosition();

contract TheLostTreasure {
    string[] private s_chestMap = [
        "devant",
        "devant",
        "droite",
        "devant",
        "gauche",
        "gauche",
        "derriere",
        "gauche",
        "devant",
        "devant",
        "gauche",
        "gauche",
        "derriere",
        "derriere"
    ];
    string[] private s_submarinePosition;

    function goForward() public {
        s_submarinePosition.push("devant");
    }

    function goBackward() public {
        s_submarinePosition.push("derriere");
    }

    function goLeft() public {
        s_submarinePosition.push("gauche");
    }

    function goRight() public {
        s_submarinePosition.push("droite");
    }

    function undoMoving() public {
        s_submarinePosition.pop();
    }

    function resetPosition() public {
        delete s_submarinePosition;
    }

    function getSubmarinePosition() public view returns (string[] memory) {
        return s_submarinePosition;
    }

    function getChestPosition() public view returns (string[] memory) {
        return s_chestMap;
    }
}
