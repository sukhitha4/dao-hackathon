pragma solidity >=0.4.22 <0.9.0;

import "./Ownable.sol";

contract DaoUtils is Ownable {

    function generatePID(string memory _name) pure internal returns(uint) {
        return uint(keccak256(abi.encodePacked(_name)));
    }
}