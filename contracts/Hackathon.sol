pragma solidity >=0.4.22 <0.9.0;

import "./DaoUtils.sol";

contract Hackathon is DaoUtils {

    struct Project {
        uint pid;
        string name;
        string description;
        uint votes;
    }

    mapping(address=>uint) voters;
    uint private startTime;
    uint private endTime;
    mapping (uint => Project) public pidToProject;
    uint[] private projectList = new uint[](0);

    constructor() {
        startTime = block.timestamp;
        endTime = block.timestamp + 16 hours;
    }

    function setStartTime(uint timestamp) external onlyOwner {
        startTime = timestamp;
    }

    function setEndTime(uint timestamp) external onlyOwner {
        endTime = timestamp;
    }

    function getStartTime() external view returns(uint) {
        return startTime;
    }

    function getEndTime() external view returns(uint) {
        return endTime;
    }


    //register new projects
    function addProject(string memory _name, string memory _description) external {
        uint pid = generatePID(_name);
        require(pidToProject[pid].pid == 0);
        pidToProject[pid] = Project(pid, _name, _description, 0);
        projectList.push(pid);
    }

    function getProjects() external returns(Project[] memory){
        Project[] memory projs = new Project[](projectList.length);
        for (uint i = 0; i < projectList.length; i++) {
            uint id = projectList[i];
            Project storage proj = pidToProject[id];
            projs[i] = proj;
        }
        return projs;
    }

    function castVote(uint _pid) external {
        if(!(voters[msg.sender] > 0)) {
            voters[msg.sender] = _pid;
            pidToProject[_pid].votes++;
        }
    }
}