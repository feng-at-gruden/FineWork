<template>
    <v-dialog v-model="dialog" lazy persistent :content-class="dialogCss" transition="slide-x-reverse-transition">
        <v-card min-height="100%">
            <v-card-title class="grey lighten-4 py-3 title">
                任务进度汇报
            </v-card-title>
            <v-form lazy-validation ref="taskProgressForm">
                <v-container fluid class="report-dialog-container">
                    <v-layout wrap>
                        <v-flex xs12 md12>
                            <v-icon class="my-icon">launch</v-icon><span class="title">{{myTask.text}}</span>
                        </v-flex>
                        <v-flex xs12 md12 style="margin-top: -5px;">
                            <v-divider></v-divider>
                        </v-flex>
                        <v-flex xs12 md12 style="margin-top: 0px;">
                            <v-layout>
                                <v-icon class="my-icon">check_box</v-icon><label class="my-label text-no-wrap">状态:</label>
                                <v-radio-group v-model="myTask.status" row class="report-status-radio">
                                    <v-radio v-for="item in config.TaskStatus" :label="item" :value="item" :key="item" @change="handleStatusRadioChange"></v-radio>
                                </v-radio-group>
                            </v-layout>
                        </v-flex>
                        <v-flex xs12 md8 style="margin-top: -20px;">
                            <v-icon class="my-icon">date_range</v-icon><label class="my-label text-no-wrap">计划周期:</label><span class="task-date text-no-wrap">{{planStartDate}} 至 {{planEndDate}}</span>
                        </v-flex>
                        <v-flex xs12 md4 style="margin-top: -20px;">
                            <v-icon class="my-icon">timelapse</v-icon><label class="my-label">工时:</label><span class="task-date">{{myTask.duration}}天</span>
                        </v-flex>
                        <v-flex xs12 md7 style="margin-top: -5px;">
                            <v-icon class="my-icon">trending_up</v-icon><label class="my-label">施工进度:<span class="task-exceed-small" v-if="myTask.exceed">(已逾期)</span></label>
                            <div>
                                <v-progress-linear :color="progressCss" height="5" :value="todayProgress" style="width: 68%"></v-progress-linear><span class="progress-value">{{todayProgress}}%</span>
                            </div>
                        </v-flex>
                        <v-flex xs12 md12 style="margin-top: -10px;">
                            <v-divider></v-divider>
                        </v-flex>
                        <v-flex xs12 md12 style="margin-top: 0px;">
                            <v-textarea label="工作汇报" v-model="worklog" outline hint="请输入当天工作进展情况"></v-textarea>
                        </v-flex>
                        <v-flex xs12 md12 style="margin-top: -15px;">
                            <label class="my-label text-no-wrap">今日进度:</label>
                            <v-slider v-model="todayProgress" thumb-label append-icon="swap_horiz" style="margin-top: -5px;"></v-slider>
                        </v-flex>
                        <v-flex xs12 md6 style="margin-top: -15px;">
                            <v-menu :close-on-content-click="false" v-model="dateMenu1" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                <v-text-field slot="activator" v-model="actualStartDate" label="开工日期" prepend-icon="event" readonly></v-text-field>
                                <v-date-picker v-model="actualStartDate" @input="dateMenu1 = false" :disabled="myTask.status!=config.TaskStatus[0]"></v-date-picker>
                            </v-menu>
                        </v-flex>
                        <v-flex xs12 md6 style="margin-top: -15px;">
                            <v-menu :close-on-content-click="false" v-model="dateMenu2" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                <v-text-field slot="activator" v-model="signDate" label="汇报日期" prepend-icon="event" readonly></v-text-field>
                                <v-date-picker v-model="signDate" :min="actualStartDate" @input="dateMenu2 = false"></v-date-picker>
                            </v-menu>
                        </v-flex>
                        <v-flex xs12 sm12>
                            <v-layout justify-center pa-2 style="margin-bottom:20px;">
                                <v-card-actions bottom>
                                    <v-spacer></v-spacer>
                                    <v-btn @click="handleCancelClick">取消</v-btn>
                                    <v-btn color="primary" @click="handleSaveClick" :loading="loading" :disabled="taskCopy.status==config.TaskStatus[3]">提交</v-btn>
                                    <v-spacer></v-spacer>
                                </v-card-actions>
                            </v-layout>
                        </v-flex>
                    </v-layout>
                </v-container>
            </v-form>
        </v-card>
        <v-snackbar v-model="snackbar" :color="snackbarColor" multi-line vertical bottom right>
            {{snackbarMessage}}
            <v-btn dark flat @click="snackbar = false">确定</v-btn>
        </v-snackbar>
    </v-dialog>
</template>
<script>
import config from '../../assets/js/Config'
import util from '../../assets/js/Util'
const dateToStr = gantt.date.date_to_str("%Y-%m-%d")
export default {
    name: 'ProgressReportDialog',
    props: ['task', 'open'],
    data() {
        return {
            config,
            util,
            dateMenu1: false,
            dateMenu2: false,
            worklog: '',
            taskCopy: {},
            snackbar: false,
            snackbarMessage: '',
            snackbarColor: '',
            signDate: '',
            actualStartDate: '',
            loading:false,
            oldProgress:-1,
        }
    },
    computed: {
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        },
        todayProgress: {
            get() {
                if (this.myTask.progress >= 0)
                    return this.util.accMul(this.myTask.progress, 100)
                else
                    return 0
            },
            set(v) {
                var vv = this.util.toDecimal(v / 100)
                this.myTask.progress = vv
            }
        },
        myTask: {
            get() { return this.$props.task },
            set(v) {}
        },
        planStartDate() {
            if (this.myTask.start_date)
                return this.myTask.start_date.split('T')[0]
            else
                return '-'
        },
        planEndDate() {
            if (this.myTask.end_date)
                return this.myTask.end_date.split('T')[0]
            else
                return '-'
        },
        dialogCss() {
            return this.util.IsPC() ? 'half-right-dialog' : 'half-right-dialog-mobile'
        },
        progressCss() {
            if (this.myTask.progress >= 1)
                return 'success'
            else if (this.myTask.exceed)
                return 'error'
            else if (this.myTask.status == this.config.TaskStatus[0])
                return 'grey darken-1'
            else
                return 'blue darken-2'
        }
    },
    methods: {
        handleCancelClick() {
            this.dialog = false
            this.$emit('cancel', this.taskCopy)
        },
        handleSaveClick() {
            var request = {
                created_date: this.signDate,
                start_date: this.actualStartDate,
                progress: this.myTask.progress,
                status: this.myTask.status,
                taskId: this.myTask.id,
                description: this.worklog
            }
            this.loading = true;
            this.$http.post(this.config.API_URL + '/Worklog', request).then(function(res) {
                var json = JSON.parse(res.bodyText)
                //update UI
                this.myTask.actual_start = this.actualStartDate
                if(this.myTask.status==this.config.TaskStatus[3])
                {
                    this.myTask.actual_end = this.signDate
                }
                this.loading = false;
                this.dialog = false
            }, function(res) {
                var json = JSON.parse(res.bodyText)
                this.showSnackbar(json.Message, 'error')
                this.loading = false;
            });
        },
        handleStatusRadioChange(v){
            if(v==config.TaskStatus[3]){
                //this.oldProgress = this.myTask.progress
                this.todayProgress = 100
            }else if(v==config.TaskStatus[0]){
                //this.oldProgress = this.myTask.progress
                this.todayProgress = 0
            }else{
                this.todayProgress = this.util.accMul(this.taskCopy.progress, 100)
            }

        },
        showSnackbar(msg, color) {
            this.snackbarMessage = msg
            this.snackbarColor = color
            this.snackbar = true
        },
    },
    watch: {
        myTask(v, ov) {
            if (v)
                this.taskCopy = this.util.objCopy(v)
        },
        dialog(v, ov) {
            if (v) {
                if (this.myTask)
                    this.taskCopy = this.util.objCopy(this.myTask)
                this.signDate = dateToStr(new Date())
                if (this.myTask.actual_start)
                    this.actualStartDate = this.myTask.actual_start.split('T')[0]
                else
                    this.actualStartDate = dateToStr(new Date())
                this.worklog = ''
                this.oldProgress = -1
            }
        }
    },

}

</script>
<style scoped>
.report-dialog-container {
    max-width: 660px;
    font-size: 15px;
    line-height: 35px;
    /*color: rgba(0,0,0,.54);*/
}

.my-label {
    padding-right: 10px;
    padding-top: 2px;
    color: #888;
}

.report-status-radio {
    font-size: 12px;
    margin-top: 5px;
    padding-top: 0px;
}

.my-icon {
    align-items: start;
    margin: 3px 5px 0 0;

}

.task-date {
    font-style: italic;
}

.progress-value {
    float: right;
    margin-top: -35px;
    margin-right: 50px;
    font-size: 15px;
    -webkit-transform: scale(0.75);
    font-style: italic;
}

.task-exceed-small {
    font-size: 12px;
    -webkit-transform: scale(0.75);
    font-style: italic;
    color: red;
}

</style>
