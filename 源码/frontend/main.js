import Vue from 'vue'
import App from './App'
import config from "./config.js"
import web3Init from "tools/web3Init.js"

Vue.config.productionTip = false

App.mpType = 'app'

Vue.prototype.$web3 = web3Init()[0]
Vue.prototype.$contract = web3Init()[1]
Vue.prototype.$config = config

// 对uni上的异步方法做处理
Vue.prototype.uniAsync = new Proxy({}, {
	get(target, name) {
		return (obj) => new Promise((resolve, reject) => {
			uni[name]({
				...obj,
				success: ret => {
					console.log("我成功", ret)
					resolve(ret)
				},
				fail: err => {
					reject(err)
				}
			})
		})
	}
})

const app = new Vue({
	...App
})
app.$mount()