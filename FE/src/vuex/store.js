import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
	state: {
		drawer: true,
		loading: false,
		editPlan: false,
		selectedOptionMenu:null,
		allProjects:[],
		openProjects:[],
		selectedProject:null,
		projectPhases:[],
		selectedPhase:null,
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
		updateAllProjects(state, v) {
			state.allProjects = v
		},
		updateOpenProjects(state, v) {
			state.openProjects = v
		},
		updateSelectedPorject(state, v) {
			state.selectedProject = parseInt(v + '')
		},
		updateProjectPhases(state, v) {
			state.projectPhases = v
		},
		updateSelectedPhase(state, v) {
			state.selectedPhase = parseInt(v + '')
		},
	}
})

export default store
