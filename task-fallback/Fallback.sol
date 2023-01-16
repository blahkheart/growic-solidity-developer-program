//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract UserBalance {
    mapping(address => uint256) balances;
    address owner;
    error AmountTooSmall();
    error MakeADepositFirst();
    uint256 constant FEE = 5;
    event FundsDeposited(address user, uint256 indexed amount);
    event ProfileUpdated(address indexed user);

    constructor() {
        owner = msg.sender;
    }

    ///////////////////Modifier///////////////////
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    modifier haveDeposit() {
        if (balances[msg.sender] == 0) {
            revert MakeADepositFirst();
        }
        _;
    }
    modifier isAmountLessThanFee(uint _amount) {
        if (_amount < FEE) {
            revert AmountTooSmall();
        }
        _;
    }

    ///////////////Fallback////////////////////
    fallback() external payable {}

    /*
     * @Dev deposit a new student
     * @Param _amount: deposit amount
     */
    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    function addFund(
        uint256 _amount
    ) public haveDeposit isAmountLessThanFee(_amount) {
        balances[msg.sender] += _amount;
    }

    function withdraw() public onlyOwner {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success);
    }

    /*
     * @Dev get balance of caller
     */
    function checkBalance() public view returns (uint256 _balance) {
        _balance = balances[msg.sender];
    }

    ///////////////////Structs///////////////////
    struct UserDetails {
        string name;
        uint256 age;
    }

    mapping(address => UserDetails) userDetails;

    /*
     * @Dev set user details
     * @Param name
     * @Param age
     */
    function setUserDetails(string calldata name, uint256 age) public {
        userDetails[msg.sender] = UserDetails({name: name, age: age});
        emit ProfileUpdated(msg.sender);
    }

    /*
     * @Dev get user details
     */
    function getUserDetail()
        public
        view
        returns (UserDetails memory _userDetails)
    {
        _userDetails = userDetails[msg.sender];
    }

    ///////////////Receive////////////////////
    receive() external payable{}
}
