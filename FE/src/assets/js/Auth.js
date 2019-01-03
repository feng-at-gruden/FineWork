import sotre from '../../vuex/store'
import router from '../../router/'

export default {
	logout() {
		console.log('user logout')
		window.app.$store.commit('userLogout')
		router.replace('/login')
	},
	login(username, password) {
		//TODO call ajax
		var url = window.app.$route.query['returnUrl']
		window.app.$store.commit('userLogin', {
			userName: 'Feng Guo',
			token: '123123'
		})
		if(url)
			router.push(url)
		else
			router.push('/')
	},
	checkIsLogin() {
		if(!window.app.$store.state.identity.token)
		{
			return false
		}
		return true
	}
}
