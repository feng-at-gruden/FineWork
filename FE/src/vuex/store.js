import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
	state: {
		drawer: true,
		loading: false,
		editPlan: false,
		selectedOptionMenu:null,
		openProjects:[],
		selectedProject:null,
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
		editPlan(state, v) {
			state.editPlan = v
		},
		userLogin(state, msg) {
			state.identity = msg;
		},
		userLogout(state) {
			state.identity = {};
		},
		optionMenuClick(state,v){			
			state.selectedOptionMenu = v		
		},
		updateOpenProjects(state, v) {
			state.openProjects = v
		},
		updateSelectedPorject(state, v) {
			state.selectedProject = v
		},
	}
})

export default store
