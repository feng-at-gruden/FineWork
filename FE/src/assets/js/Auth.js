import sotre from '../../vuex/store'
import router from '../../router/'

const API_URL = "http://127.0.0.1:3000"

export default {
	logout() {
		console.log('user logout')
		window.app.$store.commit('userLogout')
		router.replace('/login')
	},
	login(username, password, callback) {
		//TODO call ajax
		var url = window.app.$route.query['returnUrl']
		const user = { username, password }
		console.log(username, password);
		window.app.$http.post(API_URL + '/login', user, { emulateJSON: true }).then(function(res) {
			console.log('User login');
			window.app.$store.commit('userLogin', {
				userName: user.username,
				token: '123123'
			})
			if (url)
				router.push(url)
			else
				router.push('/')
		}, function(res) {
			callback(JSON.parse(res.bodyText).error)
		});
	},
	checkIsLogin() {
		if (!window.app.$store.state.identity.token) {
			return false
		}
		return true
	}
}
