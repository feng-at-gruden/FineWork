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
//https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&nc=1361089515117&FORM=HYLH1
//单数反转
//wget --no-cookie --no-check-certificate
const WALLPAPERS = [
'https://cn.bing.com/th?id=OHR.RavenWolf_ZH-CN4544068603_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.KomondorKennel_ZH-CN6009722858_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/GoldenEagle_EN-CN5621882775_1920x1080.jpg',	//egale
'https://cn.bing.com/az/hprichbg/rb/HoaryMarmot_ZH-CN7175843832_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/GoldfinchSnow_EN-CN6193065571_1920x1080.jpg',	//bird
'https://cn.bing.com/az/hprichbg/rb/LaDigue_EN-CN5418321345_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/UpHellyAa_EN-CN4575576413_1920x1080.jpg',
'https://cn.bing.com/sa/simg/hpb/NorthMale_EN-US8782628354_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.GBBC_ZH-CN4481989355_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.LoisachKochelsee_ZH-CN5859866695_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.Punakaiki_ZH-CN6944508336_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.lantern19_ZH-CN7846752344_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/HolocaustMemorial_EN-CN3092493021_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/KukeriCostume_EN-CN6866832286_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/BodegasYsios_EN-CN6930432309_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/OceanDrive_EN-CN5355005673_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/BM1759_EN-CN5095819877_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/Snowkiters_EN-CN6799323123_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/UKSomerset_EN-CN3755440952_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/NapoleonsHat_EN-CN7390815343_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/RainierDawn_EN-CN2623942425_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/VietnamStairs_EN-CN3105923263_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/FortRajgad_EN-CN7910178011_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/WinterLynx_EN-CN6283951646_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/MinnewankaBoathouse_ZH-CN0548323518_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/JapanCrane_EN-CN4265943819_1920x1080.jpg',
'https://cn.bing.com/az/hprichbg/rb/UFOMuseum_EN-CN3265083079_1920x1080.jpg',
'https://cn.bing.com/th?id=OHR.BathBach_ZH-CN4601637280_1920x1080.jpg',
]
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
		currentTime() {
			return this.util.dateFormat('yyyy年M月d日 h:mm',new Date())
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
		this.timer = setInterval(this.loadWallpaper, TIMER);
	},
	beforeDestroy() {
		document.body.parentNode.style.overflowY = "auto";
		clearInterval(this.timer)
		this.timer = null
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
	background: url('https://cn.bing.com/th?id=OHR.lantern19_ZH-CN7846752344_1920x1080.jpg');
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
