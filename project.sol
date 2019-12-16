pragma solidity ^0.4.0;

contract Welfare {
  // 用户
  struct user {
    // 个人信息
    uint id;
    string name;  // 姓名
    string job;  // 工作
    string avatar;  // 头像
    string level; // 公益等级

    // 使用信息
    uint[] atWelfareProjects;  // 参与的项目名称
    mapping(uint => project) welfareInfo;  // 项目名称所对应的项目
   
    uint[] proofProjects;  // 证实过的项目
    mapping(uint => hotProject) proofInfo; // 项目名称所对应的的项目
    
    uint[] leisure;  // 捐献的闲置物
    mapping(uint => leisureProject) leisureInfo; // 项目名称所对应的的项目

    uint[] followCommunitys;  // 关注的社区
    mapping(uint => community);  // 社区名称所对应的社区
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
    uint[] comments;  // 项目中的评论

    address[] partaker; // 参与的人
    mapping(address => string) donate;  // 每个成员的捐款
    
    uint[] votings;  // 项目中的投票
    mapping(uint => voting) votingInfo;  // 所对应的投票信息

    uint[] progresses;  // 当前项目的进展情况
    mapping(uint => progress) progressInfo;  // 所对应的进展信息

    uint[] suggests;  // 参与者发起的提案
    mapping(uint => suggest) suggestInfo;  // 所对应的提案信息  
  }

  // 爱心项目
  struct hotProject {
    uint id;
    string name;  // 项目名
    string avatar; // 展示图片
    address sender;  // 发起人
    uint goalMoney;  // 目标金额
    uint receivedMoney;  // 收到的金额
    string createTime;  // 创建时间
    string state;  // 当前状态   
    uint[] comments;  // 项目中的评论

    address[] partaker; // 参与的人
    mapping(address => string) donate;  // 每个成员的捐款

    uint[] proofList;  // 证明列表
    mapping(uint => proof);  // 所对应的证明信息

    uint[] progresses;  // 当前项目的进展情况
    mapping(uint => progress) progressInfo;  // 所对应的进展信息
  }

  // 闲置物
  struct leisureProject {
    uint id;
    string name;  // 闲置物名称
    string avatar; // 展示图片
    address sender;  // 发起人
    string createTime;  // 发起时间
    string state;  // 状态
    address receiver;  // 接收人
    string sketch;  // 闲置物描述
  }

  // 社区
  struct community {
    uint id;
    string name;  // 社区名
    address builder;  // 创建人
    string createTime;  // 创建时间
    address member;  // 成员
    string sketch; // 社区描述
    string avatar; // 展示图片

    uint talks;  // 社区中的讨论
    mapping(uint => talk);  // 所对应的讨论信息
  }

  // 投票
  struct voting {
    uint id;
    string name;  // 投票名称
    string sketch;  // 投票描述
    string state;  // 投票状态
    address sender;  // 发起人
    string createTime;  // 创建时间
    string overTime;  // 截止时期

    address[] partaker;  // 成员
    mapping(address => fixed) weight;  // 成员的权重
    
    string[] options;  // 选项
    mapping(string => fixed) optionWeight;  // 各选项获得的权重
  }

  // 项目进展
  struct progress {
    uint id;
    string title;  // 进展标题
    string crateTime;  // 创建时间
  }

  // 公众提案 
  struct suggest {
    uint id;
    string title;  // 提案标题
    string sketch; // 提案描述
    string crateTime;  // 创建时间
    uint[] comments; // 评论信息
    uint supportCount;  // 获得支持数量
    uint oppositionCount;  // 反对数量
    string state;  // 状态
  }

  // 证明信息
  struct proof {
    uint id;
    string title;  // 证明标题
    string createTime;  // 创建时间
    address proofMan;  // 证明人
    string sketch;  // 证明信息
  }

  // 讨论信息
  struct talk {
    uint id;
    address sender;  // 发起者
    string sketch;  // 讨论内容
    string createTime;  // 创建时间
    uint supportCount;  // 支持数量
    uint oppositionCount;  // 反对数量
  }

  // 公共映射
  struct publicMap {
    mapping(address => user) userInfo;  // 用户地址对应的用户信息
    mapping(uint => comment) commentInfo;  // 评论id对应的评论信息
    mapping(uint => bool) isCanDo;  // 记录投票或者评论点踩等其它事件，防止多次操作
  }
}