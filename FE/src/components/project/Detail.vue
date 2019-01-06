<template>
	<v-layout justify-center fill-height align-center>
		<ProjectPlanGantt :plan="plan"></ProjectPlanGantt>		
	</v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import ProjectPlanGantt from '../gantt/ProjectPlanGantt'
//import '../../../static/gantt/dhtmlxgantt.js?v=6.0.2'
//import '../../../static/gantt/ext/dhtmlxgantt_marker.js?v=6.0.2'
//import myGantt from '../../assets/js/Gantt.js'

export default {
	extends: BasePage,
	name: 'ProjectDetail',
	components: { ProjectPlanGantt },
	data() {
		return {
			plan: { data: [], links: [] },
			mainContainerCSS: 'main-container-gantt'
		}
	},
	methods: {
		loadProjectDetail() {
			// Call Ajax
			this.$http.get(this.config.API_URL + '/project/plan', { emulateJSON: true }).then(function(res) {
				console.log('Loaded project detail');
				this.plan = JSON.parse(res.bodyText)
				this.$store.commit('loading', false)
			}, function(res) {

			})
		}
	},
	created() {
		this.loadProjectDetail()
	}
}

</script>
<style scoped>
.m-footer {
	display: none;
	border: 10px solid #f00;
}
</style>
