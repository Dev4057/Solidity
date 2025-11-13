// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

contract toDoList{

    struct Task {
        string content;
        bool pending;
    }

    mapping(address=>Task[]) private tasks;

    event TaskCreated(address indexed user, uint taskId, string content);
    event TaskExecuted(address indexed user, uint taskId);
    event TaskDeleted(address indexed user, uint taskId);

    function createTask(string memory _content) external {
        tasks[msg.sender].push(Task(_content,false));
        emit TaskCreated(msg.sender,tasks[msg.sender].length-1,_content);
    }


    function executeTask(uint _taskId)external {
        require(_taskId<tasks[msg.sender].length,"Invalid Task Id ");
        tasks[msg.sender][_taskId].pending=true;
        emit TaskExecuted(msg.sender,_taskId);
    }


    function getMyAllTask() external view returns (Task[] memory){
         return tasks[msg.sender];// Tu isko kaise bolega Tasks ka array for that particular message.sender jisne bhi  ye diya hai 
    }



    function deleteATask(uint _taskId)external {
         require(_taskId<tasks[msg.sender].length,"Invalid Task Id ");
         tasks[msg.sender][_taskId]= tasks[msg.sender][tasks[msg.sender].length-1];//// Move the last task into the deleted spot, then pop so that the task Id will get updated and then it will not be confused.
         tasks[msg.sender].pop();
         emit TaskDeleted(msg.sender,_taskId);
    }
}