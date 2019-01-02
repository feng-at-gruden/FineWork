import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
	state: {
		identity: {
			userName: '',
			token: ''
		}
	},
	mutations: {
		userLogin(state, msg) {
			state.identity = msg;
		},
		userLogout(state) {
			state.identity = null;
		}
	}
})

export default store
