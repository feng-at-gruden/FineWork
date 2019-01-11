<template>
	<v-layout justify-center fill-height align-center>
		<ProjectPlanGantt :plan="plan"></ProjectPlanGantt>
		<ProjectInfoDialog :project="project" :open="openProjectInfoDialog" @dialogClose="handleProjectInfoDialogClose"></ProjectInfoDialog>
		<ProjectTimeline :timeline="timeline" :open="openProjectTimeline" @dialogClose="handleTimelineDialogClose"></ProjectTimeline>
		<v-snackbar v-model="snackbar">
			{{snackbarMessage}}
			<v-btn :color="snackbarColor" flat @click="snackbar = false">
				确定
			</v-btn>
		</v-snackbar>
	</v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import ProjectPlanGantt from '../gantt/ProjectPlanGantt'
import ProjectInfoDialog from '../ui/ProjectInfoDialog'
import ProjectTimeline from '../ui/ProjectTimeline'

//import '../../../static/gantt/dhtmlxgantt.js?v=6.0.2'
//import '../../../static/gantt/ext/dhtmlxgantt_marker.js?v=6.0.2'
//import myGantt from '../../assets/js/Gantt.js'

export default {
	extends: BasePage,
	name: 'ProjectDetail',
	components: { ProjectPlanGantt, ProjectInfoDialog, ProjectTimeline },
	data() {
		return {
			openProjectInfoDialog: false,
			openProjectTimeline: false,
			snackbar: false,
			snackbarMessage: '',
			snackbarColor: '',
			project: {},
			timeline: [],
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
			switch (v.text) {
				case '项目信息':
					this.openProjectInfoDialog = true
					break;
				case '时间轴':
					this.openProjectTimeline = true
					break;
				case '删除项目':
					this.openProjectInfoDialog = true
					break;
			}
		}
	},
	methods: {
		loadProjectDetail() {
			// Call Ajax
			this.$http.get(this.config.API_URL + '/project/plan', { emulateJSON: true }).then(function(res) {
				this.plan = JSON.parse(res.bodyText)
				this.$store.commit('loading', false)
			}, function(res) {
				this.showSnackbar('项目信息加载失败!', 'error')
			})
		},
		handleProjectInfoDialogClose() {
			this.openProjectInfoDialog = false
			this.$store.commit('optionMenuClick', {})
		},
		handleTimelineDialogClose() {
			this.openProjectTimeline = false
			this.$store.commit('optionMenuClick', {})
		},
		showSnackbar(msg, color) {
			this.snackbarMessage = msg
			this.snackbarColor = color
			this.snackbar = true
		},
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
