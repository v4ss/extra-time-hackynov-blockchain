// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFallback {
    function contribute() external payable;
}

contract HNParticipantContract {
    IFallback fallbackChallenge;

    constructor(address _fallbackChallengeAddress) {
        fallbackChallenge = IFallback(_fallbackChallengeAddress);
    }

    function Contribution() public payable {
        contribute{value: 0.001}();
    }

    function retrieveFlag() public view returns (string memory) {}
}
