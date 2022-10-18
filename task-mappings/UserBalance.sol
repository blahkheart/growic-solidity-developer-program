//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract UserBalance {
    mapping(address => uint256) balances;

    constructor() {}

    /*
     * @Dev deposit a new student
     * @Param _amount: deposit amount
     */
    function deposit(uint256 _amount) public {
        balances[msg.sender] += _amount;
    }

    /*
     * @Dev get balance of caller
     */
    function checkBalance() public view returns (uint256 _balance) {
        _balance = balances[msg.sender];
    }
}
