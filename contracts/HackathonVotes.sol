pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract HackathonVotes is ERC20 {
    uint public _totalSupply;

    constructor() ERC20("Hackathon Votes", "HV") public {
        _totalSupply = 100000;
    }

    function getRemainingVotes(address accountOwner) public returns (uint256) {
        return balanceOf(accountOwner);
    }
}