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
		identity: null,
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
		userLogin(state, v) {
			state.identity = v;
			localStorage.setItem("Identity", JSON.stringify(v))
		},
		userLogout(state) {
			state.identity = null;
			localStorage.removeItem("Token")
        	localStorage.removeItem("Identity")
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
