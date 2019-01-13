<template>
	<v-layout justify-center fill-height align-center>
		<!--项目计划甘特图-->
		<ProjectPlanGantt :plan="plan" :newTask="newTaskToGantt" :editable="editPlan" @onBeforeCreateTask="handleBeforekCreateTask" @onTaskUpdate="handleOnTaskUpdate" @onOpenEditBox="handleOnOpenEditBox"></ProjectPlanGantt>
		<!--项目信息对话框-->
		<ProjectInfoDialog :project="project" :open="openProjectInfoDialog" @dialogClose="handleProjectInfoDialogClose"></ProjectInfoDialog>
		<!--项目时间线对话框-->
		<ProjectTimeline :timeline="timeline" :open="openProjectTimeline" @dialogClose="handleTimelineDialogClose"></ProjectTimeline>
		<!--添加阶段计划对话框-->
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

export default {
	extends: BasePage,
	name: 'ProjectPlan',
	components: { ProjectPlanGantt, ProjectInfoDialog, ProjectTimeline, CreateTaskDialog },
	data() {
		return {
			openProjectInfoDialog: false,
			openProjectTimeline: false,
			openCreateTaskDialog: false,
			snackbar: false,
			snackbarMessage: '',
			snackbarColor: '',
			project: {},
			timeline: [],
			plan: {data:[], lilnks:[]},
			newTask: {
				start_date: new Date().toISOString().substr(0, 10),
				end_date: new Date().toISOString().substr(0, 10),
			},
			newTaskToGantt: null,
			mainContainerCSS: 'main-container-gantt',
			fackIndex: 2019,
		}
	},
	computed: {
		selectedOptionMenu() {
			return this.$store.state.selectedOptionMenu
		},
		editPlan:{
			get(){return this.$store.state.editPlan},
			set(v){this.$store.commit('editPlan', v)}
		},
		loading:{
			get(){return this.$store.state.loading},
			set(v){this.$store.commit('loading', v)}	
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
					this.editPlan = true
					break
				case '退出编辑模式':
					//TODO 加载项目原计划（含当前进度信息）
					this.showSnackbar('已退出项目计划编辑模式', 'info')					
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
				this.loading = false
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
		handleCreatePlanDialogClose() {
			this.openCreateTaskDialog = false
		},
		handleBeforekCreateTask(pid) {
			//获取父节点ID
			//console.log('handleBeforekCreateTask Pid - ', pid);
			this.newTask.parent = pid
			this.openCreateTaskDialog = true
		},
		handleOnCreateTask(task) {
			//TODO Call API, and get task ID
			
			//Update gantt
			if (true) {				
				this.newTaskToGantt = {
					id:this.fackIndex++, 
					start_date: this.util.dateFormat('d/M/yyyy',this.util.stringToDate(task.start_date)), 
					parent:task.parent, 
					text:task.text, 
					duration: this.util.dateDifference(this.util.stringToDate(task.end_date), this.util.stringToDate(task.start_date))}
			}
			//Clear newTask for CreateTaskDialog
			this.newTask = {
				start_date: new Date().toISOString().substr(0, 10),
				end_date: new Date().toISOString().substr(0, 10),				
			}
		},
		handleOnTaskUpdate(task) {
			console.log('handleOnTaskUpdate - ', task);
		},
		handleOnOpenEditBox(task){
			console.log('handleOnOpenEditBox - ', task);
		},
		showSnackbar(msg, color) {
			this.snackbarMessage = msg
			this.snackbarColor = color
			this.snackbar = true
		},
	},
	created() {
		this.loading = true
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
