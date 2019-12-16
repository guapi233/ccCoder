pragma solidity ^0.4.0;

contract zhongchou {
    // 捐赠者对象
    struct funder {
        address funderAddress;  // 捐赠者地址
        uint toMoney;  // 捐赠者捐赠的金钱
    }

    // 受益人的对象
    struct needer {
        address neederAddress;  // 受益人地址
        uint goal;  // 筹资目标
        uint amount;  // 当前筹集到的钱
        uint funderID;  // 捐赠者的ID（该项目有多少人捐献）
        mapping(uint => funder) map;  // 映射：将捐赠者的ID与捐赠者绑定在一起
    }

    uint neederCount; // 筹资项目的数量
    mapping(uint => needer) neederMap;  // 映射：将筹资ID与筹资项目绑定到一起

    /** 新建筹资项目
      * @param _neederAddress  筹资者地址
      * @param _goal  需求资金
     */
    function newNeeder(address _neederAddress, uint _goal) public {
        // 将项目ID++，并与项目本身绑定
        neederCount++;
        neederMap[neederCount] = needer(_neederAddress, _goal, 0, 0);
    }

    /**  捐献
      *  @param _neederID  筹资项目ID
    */
    function contribute(uint _neederID) public payable{
        // 通过筹资ID，获取筹资项目本身
        needer storage _needer = neederMap[_neederID];
        // 向项目捐款 （①筹资项目资金增加，②筹资项目捐献人数量增加，③在该项目上建立该捐献人的索引）
        _needer.amount += msg.value;
        _needer.funderID++;
        _needer.map[_needer.funderID] = funder(msg.sender, msg.value);
    }

    /**  判断筹资项目是否完成
      *  @param _neederID  筹资项目ID
     */
    function isComplete(uint _neederID) public payable{
      needer storage _needer = neederMap[_neederID];

      if (_needer.amount >= _needer.goal) {
        _needer.neederAddress.transfer(_needer.amount);
      }
    }

    /**  测试函数 （以第一个筹资项目为准）
      *  @return ① 筹资项目的筹资目标，②筹资项目当前的进展，③筹资项目的捐献人数量
     */
    function test() public view returns(uint, uint, uint) {
      return (neederMap[1].goal, neederMap[1].amount, neederMap[1].funderID);
    }
}