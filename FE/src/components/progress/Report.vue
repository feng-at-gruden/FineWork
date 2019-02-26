<template>
    <v-layout row wrap>
        <v-flex lg12 md12>
            <v-card class="task-filter-box">
                <v-form lazy-validation ref="searchTaskForm">
                    <v-layout wrap row>
                        <v-flex xs12 md6 pa-3>
                            <v-autocomplete v-model="selectedProject" :items="allProjects" @input="handleProjectChange" item-text="Name" item-value="Id" label="选择项目" hide-no-data>
                                <template slot="item" slot-scope="data">
                                    <template v-if="typeof data.item !== 'object'">
                                        <v-list-tile-content v-text="data.item"></v-list-tile-content>
                                    </template>
                                    <template v-else>
                                        <v-list-tile-content class="search-result-project-name">
                                            <v-list-tile-title v-html="data.item.Name"></v-list-tile-title>
                                        </v-list-tile-content>
                                    </template>
                                </template>
                            </v-autocomplete>
                        </v-flex>
                        <v-flex xs12 md6 pa-3>
                            <v-select :items="projectPhases" label="项目阶段" item-text="Name" item-value="Id" v-model="selectedPhaseId" @input="handlePhaseChange"></v-select>
                        </v-flex>
                        <v-flex xs12 md8 pa-3 class="keyword" style="margin-top: -10px;">
                            <v-text-field v-model="keyword" label="任务关键字" append-icon="search" @keydown.enter="handleSearchClick"></v-text-field>
                        </v-flex>
                        <v-flex xs12 md4 pa-3 class="keyword button-box">
                            <v-btn @click="handleResetClick">清空</v-btn>
                            <v-btn color="primary" @click="handleSearchClick">查找</v-btn>
                        </v-flex>
                    </v-layout>
                </v-form>
            </v-card>
        </v-flex>
        <v-flex xs12 style="padding-top:25px;">
            <v-tabs v-model="taskStatus" color="grey lighten-3" slider-color="primary">
                <v-tab :key="-1" ripple>
                    全部
                </v-tab>
                <v-tab v-for="n in config.TaskStatus.length" :key="n-1" ripple>
                    {{config.TaskStatus[n-1]}}
                </v-tab>
            </v-tabs>
            <v-data-table :headers="headers" :items="filteredTasks" class="elevation-1">
                <template slot="items" slot-scope="props">
                    <td class="text-no-wrap task-name" @click="openWorkDialog(props.item)">{{ props.item.text }} <span class="task-exceed-small" v-if="props.item.exceed && props.item.status!=config.TaskStatus[3]">已逾期</span></td>
                    <td class="text-xs-center text-no-wrap task-date">{{ props.item.start_date.split('T')[0] }} 至 {{ props.item.end_date.split('T')[0] }}</td>
                    <td class="text-xs-center">{{ props.item.duration }}天</td>
                    <td class="text-xs-center text-no-wrap task-date">{{ props.item.actual_start? props.item.actual_start.split('T')[0] : '' }}</td>
                    <td class="text-xs-center text-no-wrap task-date">{{ props.item.actual_end? props.item.actual_end.split('T')[0] : '' }}</td>
                    <td :class="[{'task-exceed': props.item.exceed&&props.item.status!=config.TaskStatus[3]}, 'text-xs-center']">{{ props.item.status }}</td>
                    <td class="text-xs-center">
                        <v-progress-linear color="success" height="5" :value="util.accMul(props.item.progress,100)" style="width: 65%"></v-progress-linear><span class="progress-value">{{util.accMul(props.item.progress,100)}}%</span>
                    </td>
                </template>
            </v-data-table>
        </v-flex>
        <!--任务进度汇报对话框-->
        <ProgressReportDialog :task="seletedTask" :open="openProgressReportDialog" @close="openProgressReportDialog=false" @cancel="onReportDialogCancel"></ProgressReportDialog>
    </v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import ProgressReportDialog from './ProgressReportDialog'

export default {
    extends: BasePage,
    name: 'ProgressPlan',
    props: [],
    components: { ProgressReportDialog },
    data() {
        return {
            taskStatus: 0,
            project: {},
            projectPhases: [],
            selectedPhaseId: 0,
            tasks: [],
            filteredTasks: [],
            keyword: '',
            seletedTask: {},
            headers: [{
                    text: '施工任务',
                    align: 'left',
                    sortable: false,
                    value: 'text'
                },
                { text: '计划工期', value: 'start_date', align: 'center' },
                { text: '计划工时', value: 'duration', align: 'center' },
                { text: '开工日期', value: 'actual_start', align: 'center' },
                { text: '完工日期', value: 'actual_end', align: 'center' },
                { text: '状态', value: 'status', align: 'center' },
                { text: '施工进度', value: 'progress', align: 'center' }
            ],
            dateToStr: gantt.date.date_to_str("%Y-%m-%d"),
            openProgressReportDialog: false,
        }
    },
    computed: {
        allProjects() {
            var result = []
            var all = this.$store.state.allProjects
            if (all.length) {
                for (var i = 0; i < this.config.ProjectStatus.length - 2; i++) {
                    var s = this.config.ProjectStatus[i]
                    if (all.filter(t => t.Status == s.value).length) {
                        result.push({ header: s.text })
                        result = result.concat(all.filter(t => t.Status == s.value))
                        result.push({ divider: true })
                    }
                }
                if (result.length)
                    result.pop()
            } else {
                // Call Ajax
                this.$http.get(this.config.API_URL + '/Project/List').then(function(res) {
                    this.$store.commit('updateAllProjects', JSON.parse(res.bodyText))
                })
            }
            return result
        },
    },
    methods: {
        handleProjectChange() {
            this.loadProjectPhases()
        },
        handlePhaseChange() {
            if (this.selectedPhaseId) {
                this.loadPhaseTasks()
            }
        },
        handleResetClick() {
            this.keyword = ''
            this.updateFilteredTasks()
        },
        handleSearchClick() {
        	this.updateFilteredTasks()
        },
        openWorkDialog(item) {
            this.seletedTask = item
            this.openProgressReportDialog = true
        },
        onReportDialogCancel(taskCopy) {
            //Reset
            for (var i = 0; i < this.filteredTasks.length; i++) {
                if (this.filteredTasks[i].id == taskCopy.id) {
                    this.filteredTasks[i].progress = taskCopy.progress
                    this.filteredTasks[i].status = taskCopy.status
                    this.filteredTasks[i].actual_start = taskCopy.actual_start
                    break
                }
            }
        },
        loadProjectPhases() {
            // Call Ajax
            this.tasks = []
            this.filteredTasks = []
            this.projectPhases = []

            if (!this.selectedProject) {
                return
            }
            this.loading = true
            this.$http.get(this.config.API_URL + '/Project/RawPlan/?id=' + this.selectedProject).then(function(res) {
                var json = JSON.parse(res.bodyText)
                this.project = json
                var phases = [];
                for (var i = 0; i < this.project.data.length; i++) {
                    phases.push({ Name: this.project.data[i].text, Id: this.project.data[i].id })
                }
                this.$store.commit('updateProjectPhases', phases)
                this.projectPhases = phases
                this.subTitle = this.project.name
                this.loading = false
            })
        },
        loadPhaseTasks() {
            // Call Ajax
            this.loading = true
            this.$http.get(this.config.API_URL + '/Phase/RawPlan/?id=' + this.selectedPhaseId).then(function(res) {
                var json = JSON.parse(res.bodyText)
                //json = this.refineTaskDate(json)
                this.loading = false
                this.tasks = json.data.filter(m => m.type != 'project')
                this.updateFilteredTasks()
            })
        },
        refineTaskDate(json){
            for(var i=0;i<json.data.length;i++){
                if(json.data[i].last_date){
                    json.data[i].last_date = json.data[i].last_date.split('T')[0]
                }
            }
            return json
        },
        updateFilteredTasks() {
            if (this.tasks) {
                var k = this.keyword.trim().toLowerCase()
                if (k == "") {
                    if (this.taskStatus == 0)
                        this.filteredTasks = this.tasks
                    else
                        this.filteredTasks = this.tasks.filter(t => t.status == this.config.TaskStatus[this.taskStatus - 1])
                    return
                }
                if (this.taskStatus == 0)
                    this.filteredTasks = this.tasks.filter(t => t.text.toLowerCase().indexOf(k) >= 0 || (t.description != null && t.description.toLowerCase().indexOf(k) >= 0))
                else
                    this.filteredTasks = this.tasks.filter(t => t.status == this.config.TaskStatus[this.taskStatus - 1] && (t.text.toLowerCase().indexOf(k) >= 0 || (t.description != null && t.description.toLowerCase().indexOf(k) >= 0)))
            }
        }
    },
    watch: {
        taskStatus(v, ov) {
            this.updateFilteredTasks()
        }
    },
    mounted() {
        this.loadProjectPhases()
    }
}

</script>
<style scoped>
.search-result-project-name {
    padding-left: 12px;
}

.task-filter-box .v-text-field {
    padding-top: 0px !important;
    padding-bottom: 0px !important;
}

.keyword {
    padding-top: 0px !important;
}

.button-box {
    text-align: right;
    margin-top: -10px;
}

.progress-value {
    float: right;
    margin-top: -24px;
    font-size: 10px;
    -webkit-transform: scale(0.85);
    font-style: italic;
}

.task-name{
    cursor: pointer;
}

.task-date {
    font-style: italic;
}

.task-exceed {
    color: red;
}

.task-exceed-small {
    font-size: 10px;
    -webkit-transform: scale(0.75);
    font-style: italic;
    color: red;
}

</style>
