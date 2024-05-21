// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionHouse {

  mapping(address => uint) private bid;
  address private topBidder;
  bool private bidState;
  address private organizer;

  constructor() {
    topBidder = msg.sender;
    bid[msg.sender] = 1000 * (1 ether);
    bidState = true;
    organizer = address(this);
  }

  modifier onlyOrganizer {
    require(msg.sender == organizer, "Vous n'etes pas les organisateurs de la vente aux encheres");
    _;
  }

  modifier onlyTopBidder {
        require(
            msg.sender == topBidder && bidState == false,
            "Tu n'es pas le gagnant de l'enchere"
        );
        _;
    }

  function makeABid() public payable {
    require(msg.value < 0.0001 ether);
    bid[msg.sender] += msg.value;
    if(bid[msg.sender] > bid[topBidder]) {
      topBidder = msg.sender;
    }
  }

  function changeBidState(bool state) public onlyOrganizer {
    bidState = state;
  }

  function getBidAmount() public view returns (uint) {
    return bid[msg.sender];
  }

  function getPrize() public onlyTopBidder {
    payable(topBidder).transfer(address(this).balance);

  }

  function getTopBidder() public view returns (address) {
    return topBidder;
  }

  function getOrganizer() public view returns (address) {
    return organizer;
  }

  function getBidState() public view returns (bool) {
    return bidState;
  }

    function getTopBid() public view returns (uint) {
    return bid[topBidder];
  }


  receive() external payable {
    require(msg.value > 0 && bid[msg.sender] > 0);
    topBidder = msg.sender;
    bidState = false;
  }
}
