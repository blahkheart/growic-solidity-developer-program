//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract ContractA {
    address immutable public owner;
    uint256 FEE;

    constructor (uint256 _fee) {
        owner = msg.sender;
        FEE = _fee;
    }
}

contract ContractB is ContractA{
    address bOwner;
    
    constructor(address _owner) ContractA(20){
        bOwner = _owner;
    }

    function getOwner()public view returns(address owner){
        owner = bOwner;
    }
}