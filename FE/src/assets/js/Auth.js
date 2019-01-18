import sotre from '../../vuex/store'
import router from '../../router/'
import config from './Config'

export default {
	logout() {
		window.app.$store.commit('userLogout')
		router.push('/login')
	},
	login(username, password, callback) {
		var url = window.app.$route.query['returnUrl']
		const user = { username, password }
		window.app.$http.post(config.API_URL + '/token', user, {
			emulateJSON: true,
			headers: {
				'Content-Type': 'application/json',
				'x-requested-with':'123123123',
				'auth' :'123'
			}
		}).then(function(res) {
			var json = JSON.parse(res.bodyText)
			var token = json.oken
			var identity = { username, token }
			console.log(identity)
			window.app.$store.commit('userLogin', identity)
			if (url)
				router.push(url)
			else
				router.push('/')
		}, function(res) {
			callback(JSON.parse(res.bodyText).Message)
		});
	},
	checkIsLogin(state) {
		if (!state.identity.token) {
			return true
		}
		return true
	}
}
