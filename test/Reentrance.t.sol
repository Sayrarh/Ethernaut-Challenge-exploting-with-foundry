// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Reentrance.sol";

contract ReentranceTest is Test{
    Reentrance instance;

    address player = mkaddr("player");

    function setUp() public {
       
    }

   

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }

}