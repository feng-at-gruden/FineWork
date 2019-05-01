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
						<v-card class="elevation-12 login-box" @keydown.enter="login">
							<v-toolbar color="primary" dark>
								<v-toolbar-title>{{title}}</v-toolbar-title>
								<v-spacer></v-spacer>
								<v-tooltip bottom>
									<v-btn icon slot="activator">
										<v-icon>access_time</v-icon>
									</v-btn>
									<span>{{currentTime}}</span>
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
								<v-btn color="primary" block large @click="login" :loading="logining"> <v-icon dark class="login-button-icon">cloud_upload</v-icon>登 录</v-btn>
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
		<div v-if="!showDynamicBG">
			<transition name="fade">
				<div class="wallpaper1" ref="wallpaper1" v-show="wallpaperIndex" transition="fade-transition"></div>
			</transition>
			<transition name="fade">
				<div class="wallpaper2" ref="wallpaper2" v-show="!wallpaperIndex" transition="fade-transition"></div>
			</transition>
		</div>
		<div class="slideshow" v-else>
			<div class="slideshow-image" style="" ref="BG1"></div>
			<div class="slideshow-image" style="" ref="BG2"></div>
			<div class="slideshow-image" style="" ref="BG3"></div>
			<div class="slideshow-image" style="" ref="BG4"></div>
		</div>
	</v-app>
</template>
<script>
import BasePage from '../assets/js/BasePage'

const TIMER = 20000
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
			wallpaperIndex: 1,
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
		currentTime() {
			return this.util.dateFormat('yyyy年M月d日 h:mm',new Date())
		},
		showDynamicBG() {
			return !this.util.IsPC()
		}
	},
	methods: {
		login() {
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
			if(this.picIndex>=this.config.WALLPAPERS.length)
			{
				this.picIndex = 0
			}
			var c = this.config.WALLPAPERS[this.picIndex]
			if(!this.showDynamicBG){
				if(!this.wallpaperIndex){
					this.$refs.wallpaper1.style.backgroundImage = 'url(' + c + ')'
				}else{								
					this.$refs.wallpaper2.style.backgroundImage = 'url(' + c + ')'
				}
				this.picIndex++
				this.wallpaperIndex = this.picIndex % 2
			}else{
				this.picIndex += 4
				if(this.picIndex>this.config.WALLPAPERS.length-4)
				{
					this.picIndex = 0
				}
				this.$refs.BG1.style.backgroundImage = 'url(' + this.config.WALLPAPERS[this.picIndex] + ')'
				this.$refs.BG2.style.backgroundImage = 'url(' + this.config.WALLPAPERS[this.picIndex+1] + ')'
				this.$refs.BG3.style.backgroundImage = 'url(' + this.config.WALLPAPERS[this.picIndex+2] + ')'
				this.$refs.BG4.style.backgroundImage = 'url(' + this.config.WALLPAPERS[this.picIndex+3] + ')'
			}
		}
	},
	created() {
		document.body.parentNode.style.overflowY = "hidden";
		this.timer = setInterval(this.loadWallpaper, TIMER);
	},
	beforeDestroy() {
		document.body.parentNode.style.overflowY = "auto";
		clearInterval(this.timer)
		this.timer = null
	},
	mounted() {
		if(!this.showDynamicBG){
			this.picIndex = Math.ceil(Math.random()*this.config.WALLPAPERS.length-1)
			var c = this.config.WALLPAPERS[this.picIndex-1]
			this.$refs.wallpaper1.style.backgroundImage = 'url(' + c + ')'
		}else{
			this.picIndex = Math.ceil(Math.random()*this.config.WALLPAPERS.length-4)
			this.$refs.BG1.style.backgroundImage = 'url(' + this.config.WALLPAPERS[this.picIndex] + ')'
			this.$refs.BG2.style.backgroundImage = 'url(' + this.config.WALLPAPERS[this.picIndex+1] + ')'
			this.$refs.BG3.style.backgroundImage = 'url(' + this.config.WALLPAPERS[this.picIndex+2] + ')'
			this.$refs.BG4.style.backgroundImage = 'url(' + this.config.WALLPAPERS[this.picIndex+3] + ')'
		}
	}
}

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


.wallpaper2 {
	position: absolute;
	top: 0px;
	bottom: 0px;
	width: 100%;
	height: 100%;
	background-size: 100% 100%;
    background-repeat: no-repeat;
    transform:rotateY(180deg);
	-ms-transform:rotateY(180deg); 	/* IE 9 */
	-moz-transform:rotateY(180deg); 	/* Firefox */
	-webkit-transform:rotateY(180deg); /* Safari 和 Chrome */
	-o-transform:rotateY(180deg); 
}
.wallpaper1 {
	background: url('https://cn.bing.com/az/hprichbg/rb/PlatteRiver_EN-CN2505500515_1920x1080.jpg');
	position: absolute;
	top: 0px;
	bottom: 0px;
	width: 100%;
	height: 100%;
	background-size: 100% 100%;
    background-repeat: no-repeat;
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
	opacity: 0.85;
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
.login-button-icon{
	margin-right: 5px;
}
</style>
