<template>
	<v-layout justify-center fill-height align-center>
		<ProjectPlanGantt :plan="plan"></ProjectPlanGantt>
		<ProjectInfoDialog :open="openProjectInfoDialog" @dialogClose="handleDialogClose"></ProjectInfoDialog>

		<v-snackbar v-model="snackbar">
			licked
			<v-btn color="pink" flat @click="snackbar = false">
				Close
			</v-btn>
		</v-snackbar>
	</v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import ProjectPlanGantt from '../gantt/ProjectPlanGantt'
import ProjectInfoDialog from '../ui/ProjectInfoDialog'

//import '../../../static/gantt/dhtmlxgantt.js?v=6.0.2'
//import '../../../static/gantt/ext/dhtmlxgantt_marker.js?v=6.0.2'
//import myGantt from '../../assets/js/Gantt.js'

export default {
	extends: BasePage,
	name: 'ProjectDetail',
	components: { ProjectPlanGantt, ProjectInfoDialog },
	data() {
		return {
			snackbar:false,
			openProjectInfoDialog:false,
			plan: { data: [], links: [] },
			mainContainerCSS: 'main-container-gantt'
		}
	},
	computed: {
		selectedOptionMenu() {
			return this.$store.state.selectedOptionMenu
		}
	},
	watch: {
		selectedOptionMenu(v) {
			//this.snackbar = true
			switch (v.text) {
				case '项目信息':
					this.openProjectInfoDialog = true
					console.log('项目信息')
					break;
				case '时间轴':
					this.openProjectInfoDialog = true
					console.log('时间轴')
					break;
				case '删除项目':
					this.openProjectInfoDialog = true
					console.log('删除项目')
					break;
				default:
					// statements_def
					break;
			}
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
		},
		handleDialogClose(){
			this.openProjectInfoDialog = false
			this.$store.commit('optionMenuClick', {})
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
