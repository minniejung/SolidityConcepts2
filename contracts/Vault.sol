// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    address public owner = msg.sender;
    uint256 public sentValue;
    uint256 public timestamp;
    uint256 public gasUsed;

    function deposit() public payable {
        require(msg.value > 0, "Must send some ether.");
        sentValue = msg.value;
        timestamp = block.timestamp;
    }

    function getCaller() public view returns (address) {
        return msg.sender;
    }

    function getOrigin() public view returns (address) {
        return tx.origin;
    }

    function getBlockDetails()
        public
        view
        returns (uint256, uint256, uint256, address)
    {
        return (block.number, block.prevrandao, block.gaslimit, msg.sender);
    }

    function trackGasUsage() public {
        uint256 initialGas = gasleft();
        uint256 res = 0;

        for (uint i = 0; i < 100; i++) {
            res += i;
        }

        uint256 finalGas = gasleft();
        gasUsed = initialGas - finalGas;
    }

    function generateHash(string memory _data) public pure returns (bytes32) {
        return keccak256(abi.encodePacked((_data)));
    }
}
