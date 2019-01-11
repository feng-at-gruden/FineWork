import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
	state: {
		drawer: true,
		loading: false,
		selectedOptionMenu:null,
		identity: {
			username: '',
			realname:'',
			token: ''
		}
	},
	mutations: {
		openDrawer(state, v) {
			state.drawer = v
		},
		loading(state, v) {
			state.loading = v
		},
		userLogin(state, msg) {
			state.identity = msg;
		},
		userLogout(state) {
			state.identity = {};
		},
		optionMenuClick(state,v){
			state.selectedOptionMenu = v
		}	
	}
})

export default store
