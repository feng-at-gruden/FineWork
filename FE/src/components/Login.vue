<template>
	<v-app>
		<v-content class="login-container">
			<v-container fluid>
				<v-layout row wrap align-start justify-center>
					<v-flex lg12 class="login-gap" v-if="!isMobile"></v-flex>
					<v-flex sm12 offset-lg1 v-if="!isMobile">
						<h1 class="login-h1">{{appName}}</h1>
					</v-flex>
					<v-flex sm12 offset-lg1 v-else>
						<h1 class="login-h1-mobile">{{appName}}</h1>
					</v-flex>
					<v-flex lg12 class="login-gap" v-if="!isMobile"></v-flex>
					<v-flex xs11 sm8 md5 lg4 offset-lg4>
						<v-card class="elevation-12 login-box">
							<v-toolbar color="primary">
								<v-toolbar-title>{{title}}</v-toolbar-title>
								<v-spacer></v-spacer>
								<v-tooltip bottom>
									<v-btn icon large target="_blank" slot="activator">
										<v-icon large>code</v-icon>
									</v-btn>
									<span>Help</span>
								</v-tooltip>
							</v-toolbar>
							<v-card-text>
								<v-form v-model="formValid" ref="loginForm" lazy-validation>
									<v-text-field v-model="username" prepend-icon="person" required :rules="nameRules" name="login" label="Login" type="text"></v-text-field>
									<v-text-field v-model="password" prepend-icon="lock" required :rules="passwordRules" name="password" label="Password" autocomplete="off" id="password" type="password"></v-text-field>
								</v-form>
							</v-card-text>
							<v-card-actions class="pa-3">
								<v-spacer></v-spacer>
								<v-btn color="primary" block @click="handleLoginClick" :loading="logining">登 录</v-btn>
								<v-spacer></v-spacer>
							</v-card-actions>
						</v-card>
						<v-alert :value="alert" type="error" icon="warning" dismissible transition="slide-y-transition">
							{{errorMsg}}
						</v-alert>
					</v-flex>
				</v-layout>
			</v-container>
		</v-content>
		<v-footer dark class="footer fixed login-footer">{{copyright}}</v-footer>
		<v-fade-transition mode="in-out">
			<div class="wallpaper" v-if="!wallpaper" transition="fade-transition"></div>
		</v-fade-transition>
		<v-fade-transition mode="in-out">
			<div class="wallpaper2" v-if="wallpaper" transition="fade-transition"></div>
		</v-fade-transition>
	</v-app>
</template>
<script>
import BasePage from '../assets/js/BasePage'

export default {
	extends: BasePage,
	name: 'Login',
	props: [],
	data() {
		return {
			username: '',
			password: '',
			alert: false,
			errorMsg: '',
			logining: false,
			formValid: true,
			picIndex: 0,
			wallpaper: 0,
			timer: null,
			nameRules: [
				v => !!v || '请输入用户',
			],
			passwordRules: [
				v => !!v || '密码不能为空',
			],
		}
	},
	computed: {
		isMobile() {
			return !this.util.IsPC()
		},
	},
	methods: {
		handleLoginClick() {
			if (this.$refs.loginForm.validate()) {
				this.alert = false
				this.logining = true
				this.auth.login(this.username, this.password,
					() => {
						this.logining = false
					},
					(msg) => {
						this.errorMsg = msg
						this.alert = true
						this.logining = false
					})
			}
		},
		loadWallpaper() {
			//TODO. call API and set ref class
			this.picIndex++
			this.wallpaper = this.picIndex % 2			
		}
	},
	created() {
		document.body.parentNode.style.overflowY = "hidden";
		this.timer = setInterval(this.loadWallpaper, 10000);
	},
	beforeDestroy() {
		document.body.parentNode.style.overflowY = "auto";
		clearInterval(this.timer)
		this.timer = null
	}
}
//https://cn.bing.com/HPImageArchive.aspx?format=js&idx=4&n=1&nc=1361089515117&FORM=HYLH1

</script>
<style scoped>
body {
	overflow: hidden;
}

.login-h1 {
	margin-top: 10px;
	margin-bottom: 20px;
	color: black;
	font-family: KaiTi;
	font-size: 3.2em;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.login-h1-mobile {
	font-size: 2.5em;
	text-align: center;
	margin-bottom: 30px;
	margin-top: 10px;
}

.login-container {
	position: relative;
	z-index: 1;
	width: 100%;
	height: auto;
}

.login-footer {
	z-index: 1;
	position: relative;
	bottom: 0px;
	width: 100%;
	padding-right: 35px;
}

.wallpaper,
.wallpaper2 {
	position: absolute;
	top: 0px;
	bottom: 0px;
	width: 100%;
	height: 100%;
	background: url('https://cn.bing.com/az/hprichbg/rb/OceanDrive_EN-CN5355005673_1920x1080.jpg');
}

.wallpaper2 {
	background: url('https://cn.bing.com/az/hprichbg/rb/GoldenEagle_EN-CN5621882775_1920x1080.jpg');
}

.login-gap {
	height: 60px;
}

.login-box {
	margin-bottom: 20px;
}

</style>
