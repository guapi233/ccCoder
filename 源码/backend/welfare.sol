pragma solidity ^0.4.0;
// import "./string"
import "github.com/Arachnid/solidity-stringutils/strings.sol";

contract Welfare {
  using strings for *;
  // 全局变量
  uint public projectCount = 1;
  mapping(uint => project) projectMap;
  address master;

  constructor () public {
    master = msg.sender;
  }

  // 公益项目
  struct project {
    uint id;
    string name;  // 项目名
    string avatar; // 展示图片
    address sender;  // 发起人
    string sort;  // 项目类别
    uint goalMoney;  // 目标金额
    uint receivedMoney;  // 收到的金额
    string createTime;  // 创建时间
    string state;  // 当前状态
    string detail;  // 详细信息
    uint progressId;  // 进程id
    mapping (uint => progress) progressMap;  // 对应进程
  }

  struct progress {
    string sketch;  // 描述
    string picture;  // 图片hash
  }

  // 创建项目
  function addProject (string _name, string _avatar, string _sort,
    uint _goalMoney, uint _receivedMoney, string _createTime, string _state,
    string _detail) public returns (bool) {

      // 初始化
      projectMap[projectCount] = project(projectCount, _name, _avatar, msg.sender, _sort, _goalMoney, _receivedMoney, _createTime, _state, _detail, 1);
      projectMap[projectCount].progressMap[projectMap[projectCount].progressId] = progress("项目启动。", "null");
      projectCount++;
      
      return true;
  }

  // 获取项目信息
  function getProject (uint _id) public view returns (string, string, string, uint, uint, string, string, uint) {
    project memory temp = projectMap[_id];

    return (temp.name, temp.avatar, temp.sort, temp.goalMoney, temp.receivedMoney, temp.createTime, temp.state, temp.progressId);
  }

  // 获取项目进度
  function getProgress (uint _id) public view returns (string) {
    string memory res = "";
    string memory line1 = "---";
    string memory line2 = "\r\n";

    for (uint i=projectMap[_id].progressId; i>0; i--) {
      string memory temp1 = projectMap[_id].progressMap[i].sketch;
      string memory temp2 = projectMap[_id].progressMap[i].picture;
      
      res = res.toSlice().concat(temp1.toSlice());
      res = res.toSlice().concat(line1.toSlice());
      res = res.toSlice().concat(temp2.toSlice());
      res = res.toSlice().concat(line2.toSlice());
    }

    return res;
  }

  // 更新项目进度
  function updateProgress (uint _id, string _sketch, string _picture) public returns (bool) {
    projectMap[_id].progressId++;
    projectMap[_id].progressMap[projectMap[_id].progressId] = progress(_sketch, _picture);

    return true;
  }
}


// "崔永杰", "头像", "垃圾", 500, 0, "8Ian", "进行中...", "细节"