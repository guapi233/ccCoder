import Web3 from "web3"
import config from "../config.js"
import contractCode from "../static/contract/simple.json"

/*
* @params web3 Web3构造函数
* @params blockIp 链条信息提供节点Ip
*/
export default function web3Init () {
	// if (typeof web3 != "undefined") {
	// 	res = new Web3(web3.currentProvider)
	// } else {
		let web3 = new Web3(new Web3.providers.HttpProvider(config.blockIp))
	// }
	// web3.setProvider(web3.currentProvider)
	
	// 初始化合约实例
	let abi= web3.eth.contract(contractCode["abi"])
	let contractInstance = abi.at(config.contractIp)
	
	
	return [web3, contractInstance]
}