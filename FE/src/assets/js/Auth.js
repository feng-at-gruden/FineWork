import sotre from '../../vuex/store'
import router from '../../router/'
import config from './Config'

export default {
	logout() {
        localStorage.removeItem("token")
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
            localStorage.setItem("token",token)
			var identity = {username, token }
			window.app.$store.commit('userLogin', identity)			
			if (url)
				router.replace(url)
			else
				router.replace('/')
            successCallback()
		}, function(res) {
			failedCallback(JSON.parse(res.bodyText).Message)			
		});
	},
	checkIsLogin(state) {        
		if (!state.identity.token) {
            var token = localStorage.getItem("token")
            if(token){
                // var identity = {username:'', token }
                // window.app.$store.commit('userLogin', identity) 
                return true
            }else{                
    			return false
            }       
		}
		return true
	}
}
