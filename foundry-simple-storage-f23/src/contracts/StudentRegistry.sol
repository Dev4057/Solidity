// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


contract StudentRegistry{

    struct Student{
        uint256 id;
        string name;
        uint8 grade ;
    }

    Student[]public students;

    mapping(uint=>uint) public idToIndex;
    uint public nextId;            


    function addStudent(string calldata name , uint8 grade  )external {
        students.push(Student(nextId,name,grade));
        idToIndex[nextId]=students.length-1;
        nextId++;
    }

    function getStudent(uint id )external view returns (Student memory)  {
        uint idx= idToIndex[id];
        return students[idx];
    }

    function updateGrade(uint id, uint8 newGrade)external {

        uint idx= idToIndex[id];
        students[idx].grade=newGrade;
    }


}
