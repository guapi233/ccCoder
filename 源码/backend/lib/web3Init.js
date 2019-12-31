const Web3 = require("web3")
const abi = require("../contract/simple.json")

let web3 = new Web3(new Web3.providers.HttpProvider("http://cuiyongjie.com"))

// web3.eth.getAccounts().then(res => {
//   console.log(res)
// })

console.log(web3.eth.accounts.privateKeyToAccount("0x87298f54e966ccda5d33c48d43ed0ded5a43e4b0c0047d990b4ab3bda5107cc4"))

// let contract = new web3.eth.Contract(abi["abi"], "0x2e7afda85ef8f61afddbf20c70caba917cac4410", {from: "0xCf1c5bA07C1090B274E05e2f4b665290Cc5fbe90"})

// contract.methods.changeName("崔啊啊").send({from: "0xC4C94EA58B84236fC70bf5D0A43673283716f8dA"}).then(res => {
//   console.log(res)

  // contract.methods.name().call({from: "0xC4C94EA58B84236fC70bf5D0A43673283716f8dA"}).then(r => {
  //   console.log(r)
  // })
// })

// web3.eth.personal.unlockAccount("0x2e7afda85ef8f61afddbf20c70caba917cac4410", "0x87298f54e966ccda5d33c48d43ed0ded5a43e4b0c0047d990b4ab3bda5107cc4", 6000000000)
// .then(console.log('Account unlocked!'));

// web3.eth.getAccounts().then(res => {
//   console.log(res)
// })