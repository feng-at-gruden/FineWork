<template>
	<v-layout justify-center fill-height align-center>
		<ProjectPlanGantt :plan="plan" :newTask="newTaskToGantt" :editable="editPlan" @onBeforeCreateTask="handleBeforekCreateTask"></ProjectPlanGantt>
		<ProjectInfoDialog :project="project" :open="openProjectInfoDialog" @dialogClose="handleProjectInfoDialogClose"></ProjectInfoDialog>
		<ProjectTimeline :timeline="timeline" :open="openProjectTimeline" @dialogClose="handleTimelineDialogClose"></ProjectTimeline>
		<CreateTaskDialog :newTask="newTask" :open="openCreateTaskDialog" @dialogClose="handleCreatePlanDialogClose" @onSaveClick="handleOnCreateTask"></CreateTaskDialog>
		<v-snackbar v-model="snackbar" :color="snackbarColor" multi-line vertical bottom right>
			{{snackbarMessage}}
			<v-btn dark flat @click="snackbar = false">确定</v-btn>
		</v-snackbar>
	</v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import ProjectPlanGantt from '../gantt/ProjectPlanGantt'
import ProjectInfoDialog from '../ui/ProjectInfoDialog'
import ProjectTimeline from '../ui/ProjectTimeline'
import CreateTaskDialog from '../ui/CreateTaskDialog'

//import '../../../static/gantt/dhtmlxgantt.js?v=6.0.2'
//import '../../../static/gantt/ext/dhtmlxgantt_marker.js?v=6.0.2'
//import myGantt from '../../assets/js/Gantt.js'

export default {
	extends: BasePage,
	name: 'ProjectPlan',
	components: { ProjectPlanGantt, ProjectInfoDialog, ProjectTimeline, CreateTaskDialog },
	data() {
		return {
			editPlan: false,
			openProjectInfoDialog: false,
			openProjectTimeline: false,
			openCreateTaskDialog: false,
			snackbar: false,
			snackbarMessage: '',
			snackbarColor: '',
			project: {},
			timeline: [],
			plan: { data: [], links: [] },			
			newTask:{
                start_date: new Date().toISOString().substr(0, 10),
                end_date: new Date().toISOString().substr(0, 10),
            },
            newTaskToGantt:null,
			mainContainerCSS: 'main-container-gantt',
			fackIndex:2019,
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
				case '工程项目信息':
					this.openProjectInfoDialog = true
					break
				case '项目时间轴':
					this.openProjectTimeline = true
					break
				case '项目计划调整':
					//TODO 加载项目原计划（不含当前进度信息）
					this.showSnackbar('已进入项目计划编辑模式，您可以通过拖拽、双击等方式进行计划调整。', 'info')
					this.$store.commit('openDrawer', false)
					this.$store.commit('editing', true)
					this.editPlan = true
					break
				case '退出编辑模式':
					//TODO 加载项目原计划（不含当前进度信息）
					this.showSnackbar('已退出项目计划编辑模式', 'info')
					this.$store.commit('editing', false)
					this.editPlan = false
					break
				case '删除本项目':
					this.openProjectInfoDialog = true
					break
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
		},
		handleTimelineDialogClose() {
			this.openProjectTimeline = false
		},
		handleCreatePlanDialogClose(){
			this.openCreateTaskDialog = false
		},
		handleBeforekCreateTask(pid) {			
			this.newTask.parent = pid						
			this.openCreateTaskDialog = true
		},
		handleOnCreateTask(task){
			console.log(task);
			//TODO Call API

			//Update gantt
			if(true){
				this.newTask.id = this.fackIndex++//todo get id from API
				this.newTask.start_date= '02-04-2018'                
				this.newTask.duration = 10
				this.newTaskToGantt = this.newTask
			}
			//Clear newTask
			this.newTask = {
                start_date: '02-04-2018',
                end_date: '02-04-2018',
                duration: 10,
            }
		},
		showSnackbar(msg, color) {
			this.snackbarMessage = msg
			this.snackbarColor = color
			this.snackbar = true
		},
	},
	created() {
		this.$store.commit('loading', true)
		this.loadProjectDetail()
	},
}

</script>
<style scoped>
.m-footer {
	display: none;
	border: 10px solid #f00;
}

</style>
