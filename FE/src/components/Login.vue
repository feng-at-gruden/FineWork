<template>
	<v-app>
		<v-content class="login-container">
			<v-container fluid>
				<v-layout row wrap align-start justify-center>
					<v-flex lg12 class="login-gap1" v-if="!isMobile"></v-flex>
					<v-flex sm12 offset-lg1 v-if="!isMobile">
						<h1 class="login-h1">{{appName}}</h1>
					</v-flex>
					<v-flex sm12 offset-lg1 v-else>
						<h1 class="login-h1-mobile">{{appName}}</h1>
					</v-flex>
					<v-flex lg12 class="login-gap2" v-if="!isMobile"></v-flex>
					<v-flex xs11 sm8 md5 lg4 offset-lg5>
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
								<v-btn color="primary" block large @click="handleLoginClick" :loading="logining">登 录</v-btn>
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
		<transition name="fade">
			<div class="wallpaper1" ref="wallpaper1" v-show="!wallpaper" transition="fade-transition"></div>
		</transition>
		<transition name="fade">
			<div class="wallpaper2" ref="wallpaper2" v-show="wallpaper" transition="fade-transition"></div>
		</transition>
	</v-app>
</template>
<script>
import BasePage from '../assets/js/BasePage'

const WALLPAPERS = [
'https://cn.bing.com/az/hprichbg/rb/BodegasYsios_EN-CN6930432309_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/GoldfinchSnow_EN-CN6193065571_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/OceanDrive_EN-CN5355005673_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/GoldenEagle_EN-CN5621882775_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/BM1759_EN-CN5095819877_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/LaDigue_EN-CN5418321345_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/UKSomerset_EN-CN3755440952_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/SaguenayIceFishing_EN-CN3465347871_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/Snowkiters_EN-CN6799323123_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/NapoleonsHat_EN-CN7390815343_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/VietnamStairs_EN-CN3105923263_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/RainierDawn_EN-CN2623942425_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/SnowyOwlVideo_EN-CN1604085380_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/TwilightHarbin_EN-CN7355954569_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/DivingEmperors_EN-CN9511022538_1920x1080.jpg'
]
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
			if(this.picIndex>=WALLPAPERS.length)
			{
				this.picIndex = 0
			}
			var c = WALLPAPERS[this.picIndex]
			if(this.wallpaper){
				this.$refs.wallpaper1.style.backgroundImage = 'url(' + c + ')'
			}else{								
				this.$refs.wallpaper2.style.backgroundImage = 'url(' + c + ')'
			}
			this.picIndex++
			this.wallpaper = this.picIndex % 2
		}
	},
	created() {
		document.body.parentNode.style.overflowY = "hidden";
		this.timer = setInterval(this.loadWallpaper, 20000);
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
	font-size: 3.5em;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-shadow: 2px 2px 2px #fff;
}

.login-h1-mobile {
	font-size: 2.5em;
	text-align: center;
	margin-bottom: 30px;
	margin-top: 10px;
	text-shadow: 2px 2px 2px #fff;
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
	opacity: 0.8;
}

.wallpaper1,
.wallpaper2 {
	position: absolute;
	top: 0px;
	bottom: 0px;
	width: 100%;
	height: 100%;
	background-size: 100% 100%;
    background-repeat: no-repeat;	
}
.wallpaper1 {
	background: url('https://cn.bing.com/az/hprichbg/rb/OceanDrive_EN-CN5355005673_1920x1080.jpg');
}

.login-gap1 {
	height: 10%;
}
.login-gap2{
	height: 10%;	
}
.login-box {
	margin-bottom: 20px;
	border-radius: 6px;
	opacity: 0.8;
	max-width: 450px;
}

.fade-enter-active, .fade-leave-active {
  transition-property: opacity;
  transition-duration: 0.6s;
}

.fade-enter-active {
  transition-delay: 0.6s;
}

.fade-enter, .fade-leave-active {
  opacity: 0.1
}
</style>
