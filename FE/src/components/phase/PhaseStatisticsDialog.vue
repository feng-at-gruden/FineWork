<template>
    <v-dialog v-model="dialog" lazy content-class="half-right-dialog statistics-dialog" hide-overlay transition="slide-x-reverse-transition">
        <v-card>
            <v-list>
                <v-list-tile avatar>
                    <v-list-tile-avatar>
                        <v-icon large>timelapse</v-icon>
                    </v-list-tile-avatar>
                    <v-list-tile-content>
                        <v-list-tile-title><span>{{data.Name}}</span> - 阶段统计</v-list-tile-title>
                    </v-list-tile-content>
                    <v-list-tile-action>
                        <v-icon small>more_vert</v-icon>
                    </v-list-tile-action>
                </v-list-tile>
            </v-list>
            <v-divider></v-divider>
            <v-container class="statistics-container">
                <v-layout wrap>
                    <v-flex xs12 md12 style="color:#333; padding-bottom: 15px; font-size: 16px;">
                        <span style="float:right;color:#aaa; font-style: italic; font-size: 12px;margin: 5px 10px;">
                        计划{{data.Duration}}天
                        <span v-if="data.Status == config.TaskStatus[0] ">
                            尚未开工
                        </span>
                        <span v-else-if="data.Status == config.TaskStatus[1]">
                            截至目前已施工{{data.ActualDuration}}天
                        </span>
                        <span v-else-if="data.Status == config.TaskStatus[2]">
                            停工中
                        </span>
                        <span v-else-if="data.Status == config.TaskStatus[3]">
                            实际工期{{data.ActualDuration}}天
                        </span>
                        </span>
                    </v-flex>
                    <v-flex xs4 md3 class="task-count-container">
                        <label>任务总数</label>
                        <span class="task-count">{{data.TaskCount}}</span>
                        <v-progress-linear color="success" height="5" :value="progress(data.TaskCount)"></v-progress-linear>
                    </v-flex>
                    <v-flex xs4 md3 class="task-count-container">
                        <label>已完工</label>
                        <span class="task-count">{{data.FinishedCount}}</span>
                        <v-progress-linear color="success" height="5" :value="progress(data.FinishedCount)"></v-progress-linear>
                    </v-flex>
                    <v-flex xs4 md3 class="task-count-container">
                        <label>未完工</label>
                        <span class="task-count">{{data.UnfinishedCount}}</span>
                        <v-progress-linear color="info" height="5" :value="progress(data.UnfinishedCount)"></v-progress-linear>
                    </v-flex>
                    <v-flex xs4 md3 class="task-count-container">
                        <label>施工中</label>
                        <span class="task-count">{{data.WorkingCount}}</span>
                        <v-progress-linear color="grey" height="5" :value="progress(data.UnstartCount)"></v-progress-linear>
                    </v-flex>
                    <v-flex xs4 md3 class="task-count-container">
                        <label>提前完工</label>
                        <span class="task-count">{{data.FulfilAheadCount}}</span>
                        <v-progress-linear color="success" height="5" :value="progress(data.FulfilAheadCount)"></v-progress-linear>
                    </v-flex>
                    <v-flex xs4 md3 class="task-count-container">
                        <label>延期未开工</label>
                        <span class="task-count">{{data.DelayedCount}}</span>
                        <v-progress-linear color="error" height="5" :value="progress(data.DelayedCount)"></v-progress-linear>
                    </v-flex>
                    <v-flex xs4 md3 class="task-count-container">
                        <label>逾期未完工</label>
                        <span class="task-count">{{data.ExceededCount}}</span>
                        <v-progress-linear color="error" height="5" :value="progress(data.ExceededCount)"></v-progress-linear>
                    </v-flex>
                    <v-flex xs4 md3 class="task-count-container">
                        <label>停工中</label>
                        <span class="task-count">{{data.PendingCount}}</span>
                        <v-progress-linear color="error" height="5" :value="progress(data.PendingCount)"></v-progress-linear>
                    </v-flex>
                </v-layout>
            </v-container>
            <div class="text-xs-center">
                <v-progress-circular :rotate="-90" :size="100" :width="15" :value="finishedProgress" color="primary">
                    {{ finishedProgress }}%
                </v-progress-circular>
                <v-card-actions class="pa-4">
                    <v-spacer></v-spacer>
                    <v-btn @click="dialog = false" :loading="loading">关闭</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </div>
        </v-card>
    </v-dialog>
</template>
<script>
import config from '../../assets/js/Config'
import util from '../../assets/js/Util'
export default {
    name: 'PhaseStatisticsDialog',
    props: ['open'],
    data() {
        return {
            config,
            util,
            data: {},
            interval: {},
            loading: false,
            finishedProgress: 0,
            wait: 0,
        }
    },
    computed: {
        phaseId() {
            return this.$route.params.id
        },
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        }
    },
    watch: {
        dialog(v, ov) {
            if (v) {
                this.finishedProgress = 0
                this.loadPhaseStatistics()
            } else {

            }
        }
    },
    methods: {
        loadPhaseStatistics() {
            this.loading = true
            this.$http.get(this.config.API_URL + '/Phase/Statistics?id=' + this.phaseId)
                .then(function(res) {
                    this.data = JSON.parse(res.bodyText)
                    this.loading = false
                    this.finishedProgress = Math.floor(this.progress(this.data.FinishedCount))
                })
        },
        progress(value) {
            if (value > 0 && this.data.TaskCount > 0)
                return this.util.accMul(value / this.data.TaskCount, 100)
            else
                return 0
        },
    },
}

</script>
<style scoped>
.statistics-container {
    color: #9c9c9c;
    padding-top: 0px !important;
}

.task-count-container {
    max-width: 104px;
    padding: 0 15px 0 15px;
}

.task-count {
    font-family: fantasy;
    font-size: 40px;
    display: block;
    line-height: 40px;
    color: #333;
}

.task-count-container .v-progress-linear {
    margin: 10px 0 20px 0;
}

</style>
