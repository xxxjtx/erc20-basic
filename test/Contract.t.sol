// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ERC20.sol";

contract ContractTest is Test {
    ERC20 testERC;
    address owner = address(31337);
    address bob = address(0x1234);
    address alice = address(0x1235);

    function setUp() public {
        vm.startPrank(owner);
        testERC = new ERC20("DREAM", "DRM", 1000 ether);
        testERC.transfer(bob, 10 ether);
        testERC.transfer(alice , 1 ether);
        vm.stopPrank();
    }

    function testMetadataName() public {
        assertEq("DREAM", testERC.name());
    }

    function testMetadataSymbol() public {
        assertEq("DRM", testERC.symbol());
    }

    function testBalanceOf() public {
        assertEq(testERC.balanceOf(bob), 10 ether);
        assertEq(testERC.balanceOf(alice), 1 ether);
    }

    function testValidTransfer() public {
        vm.prank(bob);
        assertTrue(testERC.transfer(alice, 1 ether));
        assertEq(testERC.balanceOf(bob), 9 ether);
        assertEq(testERC.balanceOf(alice), 2 ether);
    }

    function testInvalidTransfer() public {
    }
}
