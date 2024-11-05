// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BankAccount {
    address public owner;
    uint256 private balance;

    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);

    constructor() {
        owner = msg.sender;
        balance = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(amount <= balance, "Insufficient funds");
        balance -= amount;
        payable(owner).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }
}









// student data

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentData {
    // Define a structure to hold student details
    struct Student {
        string name;
        uint256 age;
        string class;
        uint256 rollNumber;
    }

    // An array to hold all students
    Student[] public students;

    // Event to log student data when added
    event StudentAdded(string name, uint256 rollNumber);

    // Event to log Ether received in the fallback function
    event FallbackCalled(address sender, uint256 amount, string message);

    // Function to add a new student
    function addStudent(string memory _name, uint256 _age, string memory _class, uint256 _rollNumber) public {
        Student memory newStudent = Student({
            name: _name,
            age: _age,
            class: _class,
            rollNumber: _rollNumber
        });
        
        students.push(newStudent);

        // Emit an event to log the new student addition
        emit StudentAdded(_name, _rollNumber);
    }

    // Function to retrieve the total number of students
    function getTotalStudents() public view returns (uint256) {
        return students.length;
    }

    // Function to retrieve a student's details by index
    function getStudent(uint256 index) public view returns (string memory, uint256, string memory, uint256) {
        require(index < students.length, "Invalid index");
        Student memory student = students[index];
        return (student.name, student.age, student.class, student.rollNumber);
    }

    // Fallback function to handle unexpected calls or when there is data but no matching function
    fallback() external payable {
        // Emit an event to log the Ether received and a thank-you message
        emit FallbackCalled(msg.sender, msg.value, "Thank you for sending Ether!");
    }

    // Receive function to handle plain Ether transfers with no data
    receive() external payable {
        // Any Ether sent without data will be accepted here
    }

    // Function to check the balance of Ether in the contract
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}



