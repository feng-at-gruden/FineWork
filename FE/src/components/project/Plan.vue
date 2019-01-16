<template>
	<v-layout justify-center fill-height align-center>
		<!--项目计划甘特图-->
		<ProjectPlanGantt :plan="plan" :editable="editPlan" :deleteId="taskToDelete" @onBeforeCreateTask="handleOnGanttBeforeCreateTask" @onTaskUpdate="handleOnGanttTaskUpdate" @onOpenEditBox="handleOnGanttOpenEditBox" @onTaskDblClick="handleOnGanttTaskDbClick"></ProjectPlanGantt>
		<!--项目信息对话框-->
		<ProjectInfoDialog :project="project" :open="openProjectInfoDialog" @close="openProjectInfoDialog = false"></ProjectInfoDialog>
		<!--项目时间线对话框-->
		<ProjectTimeline :timeline="timeline" :open="openProjectTimeline" @close="openProjectTimeline = false"></ProjectTimeline>
		<!--添加阶段计划对话框-->
		<CreateTaskDialog :newTask="newTask" :open="openCreateTaskDialog" :unit="'阶段计划'" @close="openCreateTaskDialog = false" @save="handleOnCreateTaskSave"></CreateTaskDialog>
		<!--编辑阶段计划对话框-->
		<EditTaskDialog :taskToEdit="taskToEdit" :open="openEditTaskDialog" :unit="'阶段计划'" @close="openEditTaskDialog = false" @save="handleOnEditTaskSave" @delete="handleOnDeleteTask"></EditTaskDialog>
		<!--删除项目确认对话框-->
		<DeleteProjectDialog :open="openDeleteProjectDialog"  @close="openDeleteProjectDialog = false" @delete="handleOnDeleteProject"></DeleteProjectDialog>
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
import EditTaskDialog from '../ui/EditTaskDialog'
import DeleteProjectDialog from '../ui/DeleteProjectDialog'

export default {
	extends: BasePage,
	name: 'ProjectPlan',
	components: { ProjectPlanGantt, ProjectInfoDialog, ProjectTimeline, CreateTaskDialog, EditTaskDialog, DeleteProjectDialog },
	data() {
		return {
			openProjectInfoDialog: false,
			openProjectTimeline: false,
			openCreateTaskDialog: false,
			openEditTaskDialog: false,
			openDeleteProjectDialog: false,
			snackbar: false,
			snackbarMessage: '',
			snackbarColor: '',
			project: {},
			timeline: [],
			plan: { data: [], lilnks: [] },
			newTask: {
				start_date: new Date().toISOString().substr(0, 10),
				end_date: new Date().toISOString().substr(0, 10),
			},
			taskToEdit: {},
			taskToDelete: 0,
			mainContainerCSS: 'main-container-gantt',
			fackIndex: 2019,
		}
	},
	computed: {
		selectedOptionMenu() {
			return this.$store.state.selectedOptionMenu
		},
		editPlan: {
			get() { return this.$store.state.editPlan },
			set(v) { this.$store.commit('editPlan', v) }
		},
		loading: {
			get() { return this.$store.state.loading },
			set(v) { this.$store.commit('loading', v) }
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
					this.loadRawPlan()
					this.showSnackbar('已进入项目计划编辑模式，您可以通过拖拽、双击等方式进行计划调整。', 'info')
					this.drawer = false
					this.editPlan = true
					break
				case '退出编辑模式':
					//TODO 加载项目原计划（含当前进度信息）
					this.loadDetailedPlan()
					this.showSnackbar('您已退出项目计划编辑模式', 'info')
					this.editPlan = false
					break
				case '删除整个项目':				
					this.openDeleteProjectDialog = true
					break
			}
		}
	},
	methods: {
		loadDetailedPlan() {
			// Call Ajax
			this.$http.get(this.config.API_URL + '/project/plan/detail', { emulateJSON: true }).then(function(res) {
				this.plan = JSON.parse(res.bodyText)
				this.loading = false
			}, function(res) {
				this.showSnackbar('项目信息加载失败!', 'error')
			})
		},
		loadRawPlan() {
			// Call Ajax
			this.$http.get(this.config.API_URL + '/project/plan/raw', { emulateJSON: true }).then(function(res) {
				this.plan = JSON.parse(res.bodyText)
				this.loading = false
			}, function(res) {
				this.showSnackbar('项目信息加载失败!', 'error')
			})
		},
		handleOnGanttBeforeCreateTask(pid) {
			//获取父节点ID
			this.newTask.parent = pid
			this.openCreateTaskDialog = true
			//替换成项目开始日期或者父任务开始日期
			//限制时间MAX/MIN不能超过或者低于父节点计划
			//父节点为空则，设置为项目开始日期
			var strToDate = gantt.date.str_to_date("%d-%m-%Y")
			var dateToStr = gantt.date.date_to_str("%Y-%m-%d")
			if (pid > 0) {
				var pTask = this.plan.data.filter(t => t.id == pid)[0]
				this.newTask.start_date = dateToStr(pTask.start_date)
				this.newTask.end_date = this.newTask.start_date
				this.newTask.min_date = this.newTask.start_date
				this.newTask.max_date = dateToStr(pTask.end_date)
			} else {
				this.newTask.start_date = dateToStr(strToDate(this.plan.start_date))
				this.newTask.end_date = this.newTask.start_date
				this.newTask.min_date = this.newTask.start_date
				this.newTask.max_date = dateToStr(strToDate(this.plan.end_date))
			}
		},
		handleOnGanttOpenEditBox(task) {
			//填充UI data
			var dateToStr = gantt.date.date_to_str("%Y-%m-%d")
			var strToDate = gantt.date.str_to_date("%d-%m-%Y")
			this.taskToEdit = {
				id: task.id,
				text: task.text,
				duration: task.duration,
				parent: task.parent,
				start_date: dateToStr(task.start_date),
				end_date: dateToStr(task.end_date),
				status: task.status,
				open: true,
				description: task.description,
			}
			if (task.parent > 0) {
				var pTask = this.plan.data.filter(t => t.id == task.parent)[0]
				this.taskToEdit.min_date = dateToStr(pTask.start_date)
				this.taskToEdit.max_date = dateToStr(pTask.end_date)
			} else {
				this.taskToEdit.min_date = dateToStr(strToDate(this.plan.start_date))
				this.taskToEdit.max_date = dateToStr(strToDate(this.plan.end_date))
			}
			this.openEditTaskDialog = true
		},
		handleOnGanttTaskUpdate(task) {
			//TODO Call API save to BE

			//Update VUE data
			for (var i = 0; i < this.plan.data.length; i++) {
				if (task.id == this.plan.data[i].id) {
					this.plan.data[i] = task
				}
			}
		},
		handleOnGanttTaskDbClick(id) {			
			var child = this.plan.data.filter(t=>t.parent==id)
			if(child.length>0)
			{
				this.$route.push('/Phase/' + id + '/Plan')
			}
		},
		handleOnCreateTaskSave(task) {
			//新建任务窗口SAVE按钮点击
			//BUG FIX，新建的任务再编辑会不生效， 因为新增的task id在原Project里找不到，建议Create返回结果为全部数据。

			//TODO Call API, and get task ID

			//Update gantt
			if (true) {
				var newTaskToGantt = {
					id: this.fackIndex++,
					start_date: this.util.dateFormat('d/M/yyyy', this.util.stringToDate(task.start_date)),
					parent: task.parent,
					status: task.status,
					opne: task.open,
					description: task.description,
					text: task.text,
					duration: this.util.dateDifference(this.util.stringToDate(task.end_date), this.util.stringToDate(task.start_date))
				}
				this.plan.data.push(newTaskToGantt)
				this.plan = Object.assign({}, this.plan) //Force to refresh to Gantt component
			}
			//Clear newTask for CreateTaskDialog
			this.newTask = {
				start_date: new Date().toISOString().substr(0, 10),
				end_date: new Date().toISOString().substr(0, 10),
			}
		},
		handleOnEditTaskSave(task) {
			//任务编辑窗口SAVE按钮点击

			//TODO CAlL API

			//Update to Gantt

			if (true) {
				for (var i = 0; i < this.plan.data.length; i++) {
					if (task.id == this.plan.data[i].id) {
						var editTaskToGantt = {
							id: task.id,
							start_date: this.util.dateFormat('d/M/yyyy', this.util.stringToDate(task.start_date)),
							parent: task.parent,
							text: task.text,
							duration: task.duration,
							description: task.description,
							open: task.open,
							status: task.status,
						}
						this.plan.data[i] = editTaskToGantt
					}
				}
				this.plan = Object.assign({}, this.plan) //Force to refresh to Gantt component
			}
		},
		handleOnDeleteTask(task) {
			//删除任务

			//TODO Call API

			//Update to Gantt
			if (true) {
				var ids = this.findNodeChildren(task.id, this.plan.data)
				this.plan.data = this.plan.data.filter(t => ids.indexOf(t.id) == -1)
				//console.log(this.plan.data);
				//this.plan = Object.assign({}, this.plan) //Not work
				this.taskToDelete = task.id
			}
		},
		handleOnDeleteProject(id){
			console.log('delete project');
			//TODO Call API
		},
		findNodeChildren(id, data) {
			var result = []
			for (var i = 0; i < data.length; i++) {
				if (data[i].id == id) {
					result.push(data[i].id)
				} else if (data[i].parent == id) {
					result = result.concat(this.findNodeChildren(data[i].id, data))
				}
			}
			return result
		},
		showSnackbar(msg, color) {
			this.snackbarMessage = msg
			this.snackbarColor = color
			this.snackbar = true
		},
	},
	created() {
		this.loading = true
		this.loadDetailedPlan()
	},
	beforeDestroy() {
		this.editPlan = false
	}
}
/* [Gantt event get task info] -> [Generate UI data for dialog] -> [Dialog save event, save to API, update Gantto props] -> [Gantt watch and update UI]  */
//TODO, 项目整体移动

</script>
<style scoped>
.m-footer {
	display: none;
	border: 10px solid #f00;
}

</style>
