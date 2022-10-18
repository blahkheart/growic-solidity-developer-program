//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract Student {
    address public owner;
    mapping(address => bool) registeredStudents;
    mapping(address => StudentInfo) studentDetails;

    struct StudentInfo {
        address studentID;
        uint256 percentage;
        uint256 totalMarks;
    }

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Not Owner");
        _;
    }

    /*
     * @Dev register a new student
     * @Param _studentID: student's ETH address
     * @Param _percentage: student's percentage score
     * @Param _totalMarks: student's total score
     */
    function register(
        address _studentID,
        uint256 _percentage,
        uint256 _totalMarks
    ) public onlyOwner {
        require(registeredStudents[_studentID] == false, "Registered");
        StudentInfo memory _studentInfo;
        _studentInfo.studentID = _studentID;
        _studentInfo.percentage = _percentage;
        _studentInfo.totalMarks = _totalMarks;
        studentDetails[_studentID] = _studentInfo;
        registeredStudents[_studentID] = true;
    }

    /*
     * @Dev get details of a student
     * @Param _studentID: student's ETH address
     */
    function getStudentDetails(address _studentID)
        public
        view
        returns (StudentInfo memory student)
    {
        student = studentDetails[_studentID];
    }
}
