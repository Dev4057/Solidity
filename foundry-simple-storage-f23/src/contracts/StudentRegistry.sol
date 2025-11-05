// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


contract StudentRegistry{


/*First kaam apka yeh hai ki decide your state variable  */
    struct Student{
        uint256 id;
        string name;
        uint8 grade ;
    }



    Student[]public students;


    mapping(uint=>uint) public idToIndex;   // Which Student is stored on which index 
    uint public nextId; 


    function addStudent(string calldata name , uint8 grade  )external {
        students.push(Student(nextId,name,grade)); // Student array ke andar push karo. 
        idToIndex[nextId]=students.length-1; // Matlab ek student rahega toh index uska 0 rahega. 
        nextId++;// and id ek se badhegi. 
    }

    function getStudent(uint id )external view returns (Student memory)  { // Abb yaha pe hum jab get student krte hai at that time you have to use return and also from which function you are going to use that value for that use view returns etc.
    uint idx= idToIndex[id];
    return students[idx];
    }

    function updateGrade(uint id, uint8 newGrade)external {

        uint idx= idToIndex[id];  // pehle on idToIndex se hum vo id ka idx dhundege and then student array ke andar jaakar vo particular student ka grade change karege 
        students[idx].grade=newGrade;
    }


}
