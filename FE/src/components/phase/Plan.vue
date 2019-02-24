<template>
    <v-layout justify-center fill-height align-center>
        <!--阶段计划甘特图-->
        <PhasePlanGantt :plan="plan" :editable="editPlan" :deleteId="taskToDelete" @onBeforeCreateTask="handleOnGanttBeforeCreateTask" @onTaskUpdate="handleOnGanttTaskUpdate" @onOpenEditBox="handleOnGanttOpenEditBox" @onTaskDblClick="handleOnGanttTaskDblClick" @onOpenTaskWorkLog="handleOpenTaskWorkLog"></PhasePlanGantt>
        <!--添加计划对话框-->
        <CreateTaskDialog :newTask="newTask" :open="openCreateTaskDialog" :unit="'任务计划'" @close="openCreateTaskDialog = false" @save="handleOnCreateTaskSave"></CreateTaskDialog>
        <!--编辑计划对话框-->
        <EditTaskDialog :taskToEdit="taskToEdit" :open="openEditTaskDialog" :unit="'任务计划'" @close="openEditTaskDialog = false" @save="handleOnEditTaskSave" @delete="handleOnDeleteTask"></EditTaskDialog>
        <!--删除阶段确认对话框-->
        <DeletePhaseDialog :open="openDeletePhaseDialog" @close="openDeletePhaseDialog = false" @delete="handleOnPhaseDeleted"></DeletePhaseDialog>
        <!--甘特图显示设置框-->
        <TaskFilterDialog :open="openTaskFilter" @close="openTaskFilter = false" @save="handleTaskFilterUpdate"></TaskFilterDialog>
        <WorklogCalendar :open="openWorklogCalendar" :task="worklogTask" @close="openWorklogCalendar=false"></WorklogCalendar>
        <!--消息提示框-->
        <v-snackbar v-model="snackbar" :color="snackbarColor" :timeout="3000" multi-line vertical bottom right>
            {{snackbarMessage}}
            <v-btn dark flat @click="snackbar = false">确定</v-btn>
        </v-snackbar>
    </v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import PhasePlanGantt from '../gantt/PhasePlanGantt'
import CreateTaskDialog from '../ui/CreateTaskDialog'
import EditTaskDialog from '../ui/EditTaskDialog'
import DeletePhaseDialog from '../ui/DeletePhaseDialog'
import TaskFilterDialog from '../ui/TaskFilterDialog'
import WorklogCalendar from '../ui/WorklogCalendar'

export default {
    extends: BasePage,
    name: 'PhasePlan',
    components: { PhasePlanGantt, CreateTaskDialog, EditTaskDialog, DeletePhaseDialog, TaskFilterDialog, WorklogCalendar },
    data() {
        return {
            openCreateTaskDialog: false,
            openEditTaskDialog: false,
            openDeletePhaseDialog: false,
            openTaskFilter: false,
            openWorklogCalendar: false,
            snackbar: false,
            snackbarMessage: '',
            snackbarColor: '',
            timeline: [],
            plan: { data: [], links: [] },
            noFilteredPlan: { data: [], links: [] },
            taskGanttFilter: {},
            newTask: {
                start_date: new Date().toISOString().substr(0, 10),
                end_date: new Date().toISOString().substr(0, 10),
                status: '未开工'
            },
            taskToEdit: {},
            taskToDelete: 0,
            worklogTask: {},
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
        phaseId() {
            return this.$route.params.id
        },
        displaySubTitle() {
            var dateToStr = gantt.date.date_to_str("%M%d日")
            var strToDate = gantt.date.str_to_date("%d-%m-%Y")
            return this.plan.name + '(' + dateToStr(strToDate(this.plan.start_date)) + " - " + dateToStr(strToDate(this.plan.end_date)) + ')'
        },
    },
    watch: {
        selectedOptionMenu(v) {
            switch (v.text) {
                case '显示选项':
                    if(this.editPlan){
                        this.showSnackbar('请先退出编辑模式。', 'info')
                    }else{
                        this.openTaskFilter = true
                    }
                    break
                case '阶段统计':
                    //TODO
                    break
                case '计划调整':
                    this.loadRawPlan()
                    this.showSnackbar('您已进入编辑模式，可通过拖拽、双击等方式进行任务编辑。', 'info')
                    this.drawer = false
                    this.editPlan = true
                    break
                case '退出编辑':
                    this.loadDetailedPlan()
                    this.showSnackbar('已退出编辑模式', 'info')
                    this.editPlan = false
                    break
                case '删除阶段':
                    this.openDeletePhaseDialog = true
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
            this.$http.get(this.config.API_URL + '/Phase/DetailPlan/?id=' + this.phaseId).then(function(res) {
                var json = JSON.parse(res.bodyText)
                this.noFilteredPlan = this.refineTaskDate(json)
                this.updateFilteredTask()
                this.subTitle = this.displaySubTitle
                this.loading = false
                this.selectedPhase = parseInt(this.plan.id)
                if (!this.selectedProject && json.projectId) {
                    this.selectedProject = parseInt(json.projectId)
                }
                //Check
                var phases = this.$store.state.projectPhases
                if (!phases || phases.length == 0) {
                    this.$http.get(this.config.API_URL + '/Project/RawPlan/?id=' + this.selectedProject).then(function(res) {
                        var json = JSON.parse(res.bodyText)
                        var phases = [];
                        for (var i = 0; i < json.data.length; i++) {
                            phases.push({ Name: json.data[i].text, Id: json.data[i].id })
                        }
                        this.$store.commit('updateProjectPhases', phases)

                    })
                }

            }, function(res) {
                this.showSnackbar('阶段计划加载失败!', 'error')
            })
        },
        loadRawPlan() {
            // Call Ajax
            this.loading = true
            this.$http.get(this.config.API_URL + '/Phase/RawPlan/?id=' + this.phaseId).then(function(res) {
                var json = JSON.parse(res.bodyText)
                this.noFilteredPlan = this.refineTaskDate(json)
                this.updateFilteredTask()
                this.subTitle = this.displaySubTitle
                this.loading = false
                this.selectedPhase = parseInt(this.plan.id)
                if (!this.selectedProject && json.projectId)
                    this.selectedProject = parseInt(json.projectId)
            }, function(res) {
                this.showSnackbar('阶段计划加载失败!', 'error')
            })
        },
        handleOnPhaseDeleted() {
            this.showSnackbar("项目阶段已删除", 'success')
            this.openDeletePhaseDialog = false
            //Redirect to Project
            setTimeout(() => (this.$router.replace('/Project/' + this.selectedProject)), 2000)
        },
        handleOnGanttBeforeCreateTask(pid) {
            //获取父节点ID
            //console.log(pid);
            this.newTask.parent = pid
            this.openCreateTaskDialog = true
            //替换成项目开始日期或者父任务开始日期
            //限制时间MAX/MIN不能超过或者低于父节点计划
            //父节点为空则，设置为项目开始日期
            var strToDate = gantt.date.str_to_date("%d-%m-%Y")
            var dateToStr = gantt.date.date_to_str("%Y-%m-%d")
            this.newTask.status = this.config.TaskStatus[0]
            this.newTask.text = ''
            this.newTask.phaseId = this.phaseId
            if (pid > 0) {
                var pTask = this.plan.data.filter(t => t.id == pid)[0]
                this.newTask.start_date = dateToStr(pTask.start_date)
                this.newTask.end_date = dateToStr(new Date(strToDate(this.newTask.start_date).getTime() + 1000 * 60 * 60 * 24 * 1))
                this.newTask.min_date = this.newTask.start_date
                this.newTask.max_date = dateToStr(pTask.end_date)
                console.log(this.newTask)
            } else {
                this.newTask.start_date = dateToStr(strToDate(this.plan.start_date))
                this.newTask.end_date = dateToStr(new Date(strToDate(this.plan.start_date).getTime() + 1000 * 60 * 60 * 24 * 1))
                this.newTask.min_date = this.newTask.start_date
                this.newTask.max_date = dateToStr(strToDate(this.plan.end_date))
            }
        },
        handleOnGanttOpenEditBox(task) {
            if(task.status==this.config.TaskStatus[3])
                return
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
            this.$http.put(this.config.API_URL + '/Task/' + task.id, task).then(function(res) {
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
            //进入工作日志浏览页
            if (this.util.IsPC())
                this.openTaskWorkLog(id)
        },
        handleOpenTaskWorkLog(id) {
            this.openTaskWorkLog(id)
        },
        handleOnCreateTaskSave(task) {
            //新建任务窗口SAVE按钮点击
            //BUG FIX，新建的任务再编辑会不生效， 因为新增的task id在原Plan里找不到，

            //Call API, and get task ID
            this.loading = true
            if (task.start_date == task.end_date && task.duration == 0)
                task.duration = 1
            this.$http.post(this.config.API_URL + '/Task', task).then(function(res) {
                var json = JSON.parse(res.bodyText)
                this.loading = false
                if (json.Success) {
                    this.showSnackbar(json.Message, 'success')
                    //Update gantt
                    var newId = json.Data.Id
                    var newTaskToGantt = {
                        id: newId,
                        start_date: this.util.dateFormat('d/M/yyyy', this.util.stringToDate(task.start_date)),
                        parent: task.parent, //项目阶段parent为空task.parent,
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
                this.newTask = {
                    start_date: new Date().toISOString().substr(0, 10),
                    end_date: new Date().toISOString().substr(0, 10),
                }
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
            this.loading = true
            if (task.start_date == task.end_date && task.duration == 0)
                task.duration = 1
            this.$http.put(this.config.API_URL + '/Task/' + task.id, task).then(function(res) {
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
            this.$http.delete(this.config.API_URL + '/Task/' + task.id).then(function(res) {
                this.$emit('delete')
                var json = JSON.parse(res.bodyText)
                if (json.Success) {
                    this.showSnackbar(json.Message, 'success')
                    //Update to Gantt
                    var ids = this.findNodeChildren(task.id, this.plan.data)
                    this.plan.data = this.plan.data.filter(t => ids.indexOf(t.id) == -1)
                    //console.log(this.plan.data);
                    //this.plan = Object.assign({}, this.plan) //Not work
                    this.taskToDelete = task.id
                }
            }, function(res) {
                var json = JSON.parse(res.bodyText)
                if (!json.Success) {
                    this.showSnackbar(json.Message, 'error')
                }
            })
        },
        handleTaskFilterUpdate(filter) {
            localStorage.setItem("TaskFilter", JSON.stringify(filter))
            this.taskGanttFilter = filter
            this.updateFilteredTask()
        },
        openTaskWorkLog(id) {
            var t = this.plan.data.filter(t => t.id == id)[0]
            if (t.type != 'project') {
                this.worklogTask = t
                this.openWorklogCalendar = true
            }
        },
        updateFilteredTask() {
            var p = Object.assign({}, this.noFilteredPlan)
            p.data = p.data.filter(t => this.util.stringInArray(t.status, this.taskGanttFilter.TaskType))

            //Remove first and add later
            p.data = p.data.filter(t => t.type!='project')

            //Not display origial plan
            if(!this.taskGanttFilter.ShowOriginalPlan){
                p.data = p.data.filter(t => t.type!='plan')
            }
            if(!this.taskGanttFilter.ShowActualPlan){
                p.data = p.data.filter(t => t.type!='actual')
            }
            
            //Check parent if parent node is added
            var pp = Object.assign({}, p)
            for (var i = 0; i < p.data.length; i++) {
                this.addRecursiveParentNode(p.data[i], pp)
            }
            this.plan = pp
        },
        addRecursiveParentNode(node, originTree) {
            if (node.parent > 0 && originTree.data.filter(t => t.id == node.parent).length == 0) {
                var pnode = this.noFilteredPlan.data.filter(t => t.id == node.parent)[0]
                originTree.data.push(pnode)
                this.addRecursiveParentNode(pnode, originTree)
            }
        },
        refineTaskDate(json) {
            var dateToStr = gantt.date.date_to_str("%d-%m-%Y")
            //var denseDateFmt = gantt.date.date_to_str("%Y/%m/%d")
            //var denseDateFmtS = gantt.date.date_to_str("%m/%d")
            if (json.data) {
                //日期格式转换
                for (var i = 0; i < json.data.length; i++) {

                    //Force move 'project' node's start_date to a new field so that gantt can auto-calculate start date 
                    if(json.data[i].type=='project'){
                        //Force to empty start_date and add a new plan_start_date, so that gantt can calculate automatically
                        json.data[i].plan_start_date = json.data[i].start_date ? json.data[i].start_date.split('T')[0].replace(/-/g,'/') : ''
                        json.data[i].plan_end_date = json.data[i].end_date ? json.data[i].end_date.split('T')[0].replace(/-/g,'/') : ''
                        json.data[i].plan_duration = json.data[i].duration
                    }

                    json.data[i].start_date = json.data[i].start_date ? dateToStr(new Date(Date.parse(json.data[i].start_date.split('T')[0]))) : ''
                    json.data[i].end_date = json.data[i].end_date ? dateToStr(new Date(Date.parse(json.data[i].end_date.split('T')[0]))) : ''
                    json.data[i].actual_start = json.data[i].actual_start ? json.data[i].actual_start.split('T')[0].replace(/-/g,'/') : ''
                    json.data[i].actual_end = json.data[i].actual_end ? json.data[i].actual_end.split('T')[0].replace(/-/g,'/'): ''
                    json.data[i].last_update = json.data[i].last_update ? json.data[i].last_update.split('T')[0].replace(/-/g,'/'): ''
                    
                    if(json.data[i].type=='project'){
                        json.data[i].start_date = ''
                        json.data[i].end_date = ''
                        json.data[i].duration = 0
                        //console.log(json.data[i])
                    }
                }
            }
            json.start_date = dateToStr(new Date(Date.parse(json.start_date.split('T')[0])))
            json.end_date = dateToStr(new Date(Date.parse(json.end_date.split('T')[0])))
            return json
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
        this.taskGanttFilter = localStorage.getItem("TaskFilter") ? JSON.parse(localStorage.getItem("TaskFilter")) : {TaskType: this.config.TaskStatus, ShowOriginalPlan: true, ShowActualPlan: true}
    },
    beforeDestroy() {
        this.editPlan = false
        this.plan = { data: [], links: [] }
        this.rawPlan = { data: [], links: [] }
        this.selectedPhase = 0
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
