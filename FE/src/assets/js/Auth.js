import sotre from '../../vuex/store'
import router from '../../router/'
import config from './Config'

export default {
	logout() {
		window.app.$store.commit('userLogout')
		router.push('/login')
	},
	login(username, password, successCallback, failedCallback) {        
		var url = window.app.$route.query['returnUrl']        
		const user = { username, password }
		window.app.$http.post(config.API_URL + '/Token', user, {
			emulateJSON: true,			
		}).then(function(res) {
			var token = JSON.parse(res.bodyText).Token
			localStorage.setItem("Token",token)
			//Get account info and save identity to local
			this.$http.get(config.API_URL + '/Account/AccountInfo').then(function(res) {
                var identity = JSON.parse(res.bodyText)
                window.app.$store.commit('userLogin', identity)	
            }, function(res){
            	failedCallback('获取用户信息失败')
            })
			if (url){
				router.replace(url)            
            }else{
				router.replace('/')                
            }
            successCallback()            
		}, function(res) {
			failedCallback(JSON.parse(res.bodyText).Message)			
		});
	},
	checkIsLogin(state) {        
        var token = localStorage.getItem("Token")
        if(token){
            // var identity = {username:'', token }
            // window.app.$store.commit('userLogin', identity) 
            return true
        }else{                
			return false
        }
	},
	checkPermission(permission, identity){
		if(!permission || permission=='')
			return true
		if(identity.Permissions){
			for(var i=0; i<identity.Permissions.length;i++){
				if(identity.Permissions[i].indexOf(permission)>=0){
					return true
				}
			}
			return false
		}else{
			return false
		}
	}
}
