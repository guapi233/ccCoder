<template>
	<div class="box" @click="toucha">
		我是主页

		<div class="have">
			我包含：{{show}}
			<navigator url="./sort">公益分类</navigator>
			<navigator url="./shop">积分商城</navigator>
			<navigator url="./idle">闲置物捐赠</navigator>
		</div>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				show: null
			}
		},
		methods: {
			getName() {
				// this.show = this.$contract.name.call({from: "0x449775ef85c3f0edc1f5de6be8e58ac283239485"})
				return new Promise((res, rej) => {
					this.$contract.name.call((err, res)=> {
						console.log("我是res",err, res)
						this.show = res
					})
				})
			},
			toucha () {
				console.log("aa")
				// this.$contract.name.call({from: "0x449775ef85c3f0edc1f5de6be8e58ac283239485"})
				this.$contract.name.call({from: "0x449775ef85c3f0edc1f5de6be8e58ac283239485"}, (e, i) => {
					console.log(e, i)
				})
			},
			changeName () {
				return new Promise((res, rej) => {
					this.$contract.changeName("Mob2000", {from: "0x449775ef85c3f0edc1f5de6be8e58ac283239485"}, (e, i) => {
						if (e) rej(e)
						else res(i)
					})
				})
			}
			
		},
		onLoad() {
			let user = null
			console.log(this.$web3.eth)
			// this.$web3.eth.getAccounts(async (e, i) => {
			// 	user = i[0]
				
			// 	await this.changeName()
				
			// 	this.getName()
			// })
			
			this.show = this.$contract["address"]
	
		}
	}
</script>

<style>
	.box {
		width: 750rpx;
		height: 750rpx;
	}
</style>
