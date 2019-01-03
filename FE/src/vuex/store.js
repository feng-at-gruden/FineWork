import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
	state: {
		drawer: true,
		identity: {
			userName: '',
			token: ''
		}
	},
	mutations: {
		openDrawer(state, v) {
			state.drawer = v
		},
		userLogin(state, msg) {
			state.identity = msg;
		},
		userLogout(state) {
			state.identity = {};
		}
	}
})

export default store
