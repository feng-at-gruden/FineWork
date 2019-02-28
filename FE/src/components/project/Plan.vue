<template>
    <v-layout justify-center fill-height align-center>
        <!--项目计划甘特图-->
        <ProjectPlanGantt :plan="plan" :editable="editPlan" :deleteId="taskToDelete" @onBeforeCreateTask="handleOnGanttBeforeCreateTask" @onTaskUpdate="handleOnGanttTaskUpdate" @onOpenEditBox="handleOnGanttOpenEditBox" @onTaskDblClick="handleOnGanttTaskDblClick"></ProjectPlanGantt>
        <!--项目信息对话框-->
        <ProjectInfoDialog :project="detail" :open="openProjectInfoDialog" @close="openProjectInfoDialog = false" @update="handleOnProjectInfoUpdated"></ProjectInfoDialog>
        <!--项目时间线对话框-->
        <ProjectTimeline :timeline="timeline" :open="openProjectTimeline" @close="openProjectTimeline = false"></ProjectTimeline>
        <!--添加计划对话框-->
        <CreateTaskDialog :newTask="newTask" :open="openCreateTaskDialog" :unit="'项目阶段'" @close="openCreateTaskDialog = false" @save="handleOnCreateTaskSave"></CreateTaskDialog>
        <!--编辑计划对话框-->
        <EditTaskDialog :taskToEdit="taskToEdit" :open="openEditTaskDialog" :unit="'项目阶段'" @close="openEditTaskDialog = false" @save="handleOnEditTaskSave" @delete="handleOnDeleteTask"></EditTaskDialog>
        <!--删除项目确认对话框-->
        <DeleteProjectDialog :open="openDeleteProjectDialog" @close="openDeleteProjectDialog = false" @delete="handleOnProjectDeleted"></DeleteProjectDialog>
        <!--项目统计信息对话框 -->
        <ProjectStatisticsDialog :open="openProjectStatistics" @close="openProjectStatistics = false" :projectId="projectId"></ProjectStatisticsDialog>
        <v-snackbar v-model="snackbar" :color="snackbarColor" :timeout="3000" multi-line vertical bottom right>
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
import ProjectStatisticsDialog from './ProjectStatisticsDialog'

export default {
    extends: BasePage,
    name: 'ProjectPlan',
    components: { ProjectPlanGantt, ProjectInfoDialog, ProjectTimeline, CreateTaskDialog, EditTaskDialog, DeleteProjectDialog, ProjectStatisticsDialog },
    data() {
        return {
            openProjectInfoDialog: false,
            openProjectTimeline: false,
            openCreateTaskDialog: false,
            openEditTaskDialog: false,
            openDeleteProjectDialog: false,
            openProjectStatistics: false,
            snackbar: false,
            snackbarMessage: '',
            snackbarColor: '',
            timeline: [],
            plan: { data: [], links: [] },
            detail: {},
            newTask: {
                start_date: new Date().toISOString().substr(0, 10),
                end_date: new Date().toISOString().substr(0, 10),
                status: '未开工',
                text:''
            },
            taskToEdit: {},
            taskToDelete: 0,
            mainContainerCSS: 'main-container-gantt',
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
        projectId() {
            return parseInt(this.$route.params.id)
        },
    },
    watch: {
        selectedOptionMenu(v) {
            switch (v.text) {
                case '项目信息':
                    this.openProjectDetailDialog()
                    break
                case '项目统计':
                    this.openProjectStatistics = true
                    break
                case '时间轴':
                    this.openProjectTimeline = true
                    break
                case '阶段调整':
                    this.loadRawPlan()
                    this.showSnackbar('您已进入编辑模式，可通过拖拽、双击等方式进行计划调整。', 'info')
                    this.drawer = false
                    this.editPlan = true
                    break
                case '退出编辑':
                    this.loadDetailedPlan()
                    this.showSnackbar('已退出项目计划编辑模式', 'info')
                    this.editPlan = false
                    break
                case '删除项目':
                    this.openDeleteProjectDialog = true
                    break
            }
        },
        '$route'(v, ov) {
            if (this.editPlan)
                this.editPlan = false
            this.loadDetailedPlan()
        }
    },
    methods: {
        loadDetailedPlan() {
            // Call Ajax
            this.loading = true
            this.$http.get(this.config.API_URL + '/Project/DetailedPlan/?id=' + this.projectId).then(function(res) {
                var json = JSON.parse(res.bodyText)
                var dateToStr = gantt.date.date_to_str("%d-%m-%Y")
                if (json.data) {
                    //日期格式转换
                    for (var i = 0; i < json.data.length; i++) {
                        json.data[i].start_date = json.data[i].start_date ? dateToStr(new Date(Date.parse(json.data[i].start_date.split('T')[0]))) : dateToStr(new Date())
                        json.data[i].end_date = json.data[i].end_date ? dateToStr(new Date(Date.parse(json.data[i].end_date.split('T')[0]))) : dateToStr(new Date())
                    }
                }
                json.start_date = dateToStr(new Date(Date.parse(json.start_date.split('T')[0])))
                json.end_date = dateToStr(new Date(Date.parse(json.end_date.split('T')[0])))
                this.plan = json
                this.subTitle = this.plan.name
                this.loading = false
                this.updateProjectPhases()
            }, function(res) {
                this.showSnackbar('项目计划信息加载失败!', 'error')
            })
        },
        loadRawPlan() {
            // Call Ajax
            this.loading = true
            this.$http.get(this.config.API_URL + '/Project/RawPlan/?id=' + this.projectId).then(function(res) {
                var json = JSON.parse(res.bodyText)
                //日期格式转换
                var dateToStr = gantt.date.date_to_str("%d-%m-%Y")
                if (json.data) {
                    //日期格式转换
                    for (var i = 0; i < json.data.length; i++) {
                        json.data[i].start_date = json.data[i].start_date ? dateToStr(new Date(Date.parse(json.data[i].start_date.split('T')[0]))) : dateToStr(new Date())
                        json.data[i].end_date = json.data[i].end_date ? dateToStr(new Date(Date.parse(json.data[i].end_date.split('T')[0]))) : dateToStr(new Date())
                    }
                }
                json.start_date = dateToStr(new Date(Date.parse(json.start_date.split('T')[0])))
                json.end_date = dateToStr(new Date(Date.parse(json.end_date.split('T')[0])))
                this.plan = json
                this.subTitle = this.plan.name
                this.loading = false
                this.updateProjectPhases()
            }, function(res) {
                this.showSnackbar('项目计划信息加载失败!', 'error')
            })
        },
        openProjectDetailDialog() {
            this.loadProjectDetail(() => { this.openProjectInfoDialog = true })
        },
        loadProjectDetail(callback) {
            this.loading = true
            this.$http.get(this.config.API_URL + '/Project/' + this.projectId).then(function(res) {
                this.detail = JSON.parse(res.bodyText)
                this.detail.StartDate = this.detail.StartDate.split('T')[0]
                this.detail.EndDate = this.detail.EndDate.split('T')[0]
                this.loading = false
                callback()
            }, function(res) {
                this.loading = false
                this.showSnackbar('项目信息加载失败!', 'error')
            })
        },
        handleOnProjectInfoUpdated(v) {
            this.showSnackbar("项目信息更新成功", 'success')
            //Update open project dorpdown
            this.$http.get(this.config.API_URL + '/Project/List').then(function(res) {
                this.$store.commit('updateAllProjects', JSON.parse(res.bodyText))
            })
            if (this.editPlan) {
                this.loadRawPlan()
            } else {
                this.loadDetailedPlan()
            }
        },
        handleOnProjectDeleted() {
            this.showSnackbar("项目已删除", 'success')
            this.openDeleteProjectDialog = false
            setTimeout(() => (this.$router.replace('/Project/List')), 2000)
        },
        handleOnGanttBeforeCreateTask(pid) {
            //获取父节点ID
            //console.log(pid);
            this.newTask =  {
                status: '未开工',
                text:'',
                description:'',
            },
            this.newTask.parent = pid
            //替换成项目开始日期或者父任务开始日期
            //限制时间MAX/MIN不能超过或者低于父节点计划
            //父节点为空则，设置为项目开始日期
            var strToDate = gantt.date.str_to_date("%d-%m-%Y")
            var dateToStr = gantt.date.date_to_str("%Y-%m-%d")
            if (pid > 0) {
                var pTask = this.plan.data.filter(t => t.id == pid)[0]
                this.newTask.start_date = dateToStr(pTask.start_date)
                this.newTask.end_date = dateToStr(new Date(strToDate(pTask.start_date).getTime() + 1000*60*60*24*1))
                this.newTask.min_date = this.newTask.start_date
                this.newTask.max_date = dateToStr(pTask.end_date)
            } else {
                this.newTask.start_date = dateToStr(strToDate(this.plan.start_date))
                this.newTask.end_date =  dateToStr(new Date(strToDate(this.plan.start_date).getTime() + 1000*60*60*24*1))
                this.newTask.min_date = this.newTask.start_date
                this.newTask.max_date = dateToStr(strToDate(this.plan.end_date))
            }
            this.openCreateTaskDialog = true
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
            //Call API save to BE
            this.loading = true
            this.$http.put(this.config.API_URL + '/Phase/' + task.id, task).then(function(res) {
                var json = JSON.parse(res.bodyText)
                this.loading = false
                if (json.Success) {
                    //this.showSnackbar(json.Message, 'success')
                    //Update VUE data
                    for (var i = 0; i < this.plan.data.length; i++) {
                        if (task.id == this.plan.data[i].id) {
                            this.plan.data[i] = task
                        }
                    }
                }
            }, function(res) {
                var json = JSON.parse(res.bodyText)
                this.loading = false
                if (!json.Success) {
                    this.showSnackbar(json.Message, 'error')
                }
            });
        },
        handleOnGanttTaskDblClick(id) {
            //进入阶段详情页
            if (this.util.IsPC()){
                var task = this.plan.data.filter(t => t.id == id)[0]
                //var child = this.plan.data.filter(t=>t.parent==id)
                if (task && !task.parent > 0) {
                    this.$router.push('/Phase/' + id)
                }
            }
        },
        handleOnCreateTaskSave(task) {
            //新建任务窗口SAVE按钮点击
            //BUG FIX，新建的任务再编辑会不生效， 因为新增的task id在原Project里找不到，建议Create返回结果为全部数据。

            //Call API, and get task ID
            this.loading = true
            if (!task.parent)
                task.parent = this.projectId
            if (task.start_date == task.end_date) {
                task.duration = 1
            }
            this.$http.post(this.config.API_URL + '/Phase', task).then(function(res) {
                var json = JSON.parse(res.bodyText)
                this.loading = false
                if (json.Success) {
                    this.showSnackbar(json.Message, 'success')
                    //Update gantt
                    var newId = json.Data.Id
                    var newTaskToGantt = {
                        id: newId,
                        start_date: this.util.dateFormat('d/M/yyyy', this.util.stringToDate(task.start_date)),
                        parent: 0, //项目阶段parent为空task.parent,
                        status: task.status,
                        open: task.open,
                        description: task.description,
                        text: task.text,
                        duration: this.util.dateDifference(this.util.stringToDate(task.end_date), this.util.stringToDate(task.start_date))
                    }
                    this.plan.data.push(newTaskToGantt)
                    this.plan = Object.assign({}, this.plan) //Force to refresh to Gantt component
                }
                //Clear newTask for CreateTaskDialog
            }, function(res) {
                var json = JSON.parse(res.bodyText)
                this.loading = false
                if (!json.Success) {
                    this.showSnackbar(json.Message, 'error')
                }
            });
        },
        handleOnEditTaskSave(task) {
            //任务编辑窗口SAVE按钮点击
            //CAlL API
            //console.log(task)
            if (task.start_date == task.end_date && task.duration == 0)
                task.duration = 1
            this.loading = true
            this.$http.put(this.config.API_URL + '/Phase/' + task.id, task).then(function(res) {
                var json = JSON.parse(res.bodyText)
                this.loading = false
                if (json.Success) {
                    this.showSnackbar(json.Message, 'success')
                    //Update to Gantt
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
            }, function(res) {
                var json = JSON.parse(res.bodyText)
                this.loading = false
                if (!json.Success) {
                    this.showSnackbar(json.Message, 'error')
                }
            });
        },
        handleOnDeleteTask(task) {
            //删除任务
            //Call API
            this.$http.delete(this.config.API_URL + '/Phase/' + task.id).then(function(res) {
                this.$emit('delete')
                var json = JSON.parse(res.bodyText)
                if (json.Success) {
                    this.showSnackbar(json.Message, 'success')
                }
            }, function(res) {
                var json = JSON.parse(res.bodyText)
                if (!json.Success) {
                    this.showSnackbar(json.Message, 'error')
                }
            })

            //Update to Gantt
            if (true) {
                var ids = this.findNodeChildren(task.id, this.plan.data)
                this.plan.data = this.plan.data.filter(t => ids.indexOf(t.id) == -1)
                //console.log(this.plan.data);
                //this.plan = Object.assign({}, this.plan) //Not work
                this.taskToDelete = task.id
            }
        },
        updateProjectPhases() {
            var phases = [];
            for(var i=0; i<this.plan.data.length; i++)
            {                
                phases.push({Name:this.plan.data[i].text, Id:this.plan.data[i].id})
            }
            this.$store.commit('updateProjectPhases', phases)
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
        this.loadDetailedPlan()
    },
    updated() {
        if (this.selectedProject != this.projectId) {
            this.selectedProject = this.projectId
        }
    },
    beforeDestroy() {
        this.editPlan = false
        this.plan = { data: [], links: [] }
    }
}
/* [Gantt event get task info] -> [Generate UI data for dialog] -> [Dialog save event, save to API, update Gantto props] -> [Gantt watch and update UI]  */

</script>
<style scoped>
.m-footer {
    display: none;
    border: 10px solid #f00;
}

</style>
