//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract DataTypes {
    /*
    Solidity Value Types:
    uint,
    int,
    boolean,
    bytes,
    address,
    enum
    */

    //  Unsigned integer variable
    uint public uint_var = 10;
    // usecase:
    function setAge(uint256 _yourAge)public returns (uint) {
        return uint_var = _yourAge;
    }

    // Integer variable
    int public int_temp = -6;
    // usecase:
    function getTemperature()public view returns(int){
        return int_temp;
    }

    // Boolean variable
    bool public myBool = false;
    // usecase
    modifier adultsOnly() {
        if(uint_var > 18) myBool = true;
        require(myBool, "Adults only");
        _;
    }

    // Bytes variable
    bytes public coolBytes = "0x02e";
    function testBytes(string memory _someString) public adultsOnly returns(bool) {
        bytes memory b = abi.encodePacked(_someString);
        bytes memory myB = coolBytes;
        return keccak256(abi.encodePacked(b)) == keccak256(abi.encodePacked(myB));
    }

    // Defining an enum
    enum my_enum {
        geeks_,
        _for,
        _geeks
    }

    // usecase
    function Enum() public pure returns (my_enum) {
        return my_enum._geeks;
    }
}