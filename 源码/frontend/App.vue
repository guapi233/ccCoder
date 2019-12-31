<script>
	export default {
		onLaunch: async function() {	
			// 中间按键
			uni.onTabBarMidButtonTap(() => {
				console.log("哈哈")
			})
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style>
	/*每个页面公共css */
	.temp {
		display: flex;
		width: 750rpx;
		padding: 10rpx;
		box-sizing: border-box;
	}
	
	.item {
		padding: 10rpx;
	}
	
	navigator {
		color: #007AFF;
		padding: 10rpx;
	}
	
	.have {
		margin-top: 10rpx;
	}
</style>
