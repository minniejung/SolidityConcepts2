// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vault} from "./Vault.sol";

contract Bank is Vault {
    event Withdrawn(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(owner == msg.sender, "Only the owner can call withdraw.");
        _;
    }
    function withdraw(uint256 _amount) public onlyOwner {
        require(_amount <= sentValue, "Insufficient balance in Vault.");
        sentValue -= _amount;

        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Withdraw failed");

        emit Withdrawn(msg.sender, _amount);
    }
}
