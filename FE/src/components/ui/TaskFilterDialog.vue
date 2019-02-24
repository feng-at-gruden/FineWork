<template>
    <v-menu v-model="dialog" :close-on-content-click="false" max-width="360" nudge-bottom="51" offset-x nudge-left="210" attach="#hearder-search-btn">
        <v-card>
            <v-list>
                <v-list-tile avatar>
                    <v-list-tile-avatar>
                        <v-icon big>filter_none</v-icon>
                    </v-list-tile-avatar>
                    <v-list-tile-content>
                        <v-list-tile-title>显示设置</v-list-tile-title>
                        <v-list-tile-sub-title>请选择需要显示的任务类型及方式</v-list-tile-sub-title>
                    </v-list-tile-content>
                    <v-list-tile-action>
                        <v-icon small>more_vert</v-icon>
                    </v-list-tile-action>
                </v-list-tile>
            </v-list>
            <v-divider></v-divider>
            <v-list>
                <v-list-tile v-for="(item, index) in config.TaskStatus" :key="index">
                    <v-list-tile-action>
                        <v-switch v-model="myFilter.TaskType" :color="filterColor[index]" :value="item"></v-switch>
                    </v-list-tile-action>
                    <v-list-tile-title>{{item}}</v-list-tile-title>
                </v-list-tile>
                <v-list-tile>
                    <v-list-tile-content>
                        <v-list-tile-sub-title class="plan-switcher">
                            <div class="plan-switcher-label">甘特图显示: </div>
                            <v-radio-group v-model="planSwitcher" row style="float: left;">
                                <v-radio label="计划" color="grey" :value="1"></v-radio>
                                <v-radio label="实际" color="grey" :value="2"></v-radio>
                                <v-radio label="全部" color="grey" :value="3"></v-radio>
                            </v-radio-group>
                        </v-list-tile-sub-title>
                    </v-list-tile-content>
                </v-list-tile>
                <v-divider style="margin-top: -10px;"></v-divider>
                <v-list-tile>
                    <v-list-tile-action>
                        <v-list-tile-title>
                            <div class="status-color-block plan"></div>
                            <div class="status-color-text">原计划</div>
                        </v-list-tile-title>
                    </v-list-tile-action>
                </v-list-tile>
                <v-list-tile>
                    <v-list-tile-action>
                        <v-list-tile-title>
                            <div class="status-color-block progress"></div>
                            <div class="status-color-text">任务进度</div>
                        </v-list-tile-title>
                    </v-list-tile-action>
                </v-list-tile>
                <v-list-tile>
                    <v-list-tile-action>
                        <v-list-tile-title>
                            <div class="status-color-block delayed"></div>
                            <div class="status-color-text">延期(未按计划开工)</div>
                        </v-list-tile-title>
                    </v-list-tile-action>
                </v-list-tile>
                <v-list-tile>
                    <v-list-tile-action>
                        <v-list-tile-title>
                            <div class="status-color-block exceed"></div>
                            <div class="status-color-text">逾期(未按计划完工)</div>
                        </v-list-tile-title>
                    </v-list-tile-action>
                </v-list-tile>
            </v-list>
            <v-card-actions style="margin-top: -15px;">
                <v-spacer></v-spacer>
                <v-btn flat @click="dialog = false">取消</v-btn>
                <v-btn color="primary" flat @click="handleSaveClick">确定</v-btn>
            </v-card-actions>
        </v-card>
    </v-menu>
</template>
<script>
import config from '../../assets/js/Config'
export default {
    name: 'TaskFilterDialog',
    props: ['open'],
    data() {
        return {
            config,
            planSwitcher: 3,
            myFilter: {},
            filterColor: ['#9c9c9c', '#3db9d3', '#b319b3', '#3c9445', ]
        }
    },
    computed: {
        dialog: {
            get() { return this.$props.open },
            set(v) {
                if (!v) {
                    this.$emit('close')
                }
            }
        },
    },
    watch: {
        planSwitcher(v, ov) {
            switch (v) {
                case 1:
                    this.myFilter.ShowOriginalPlan = true
                    this.myFilter.ShowActualPlan = false
                    break
                case 2:
                    this.myFilter.ShowOriginalPlan = false
                    this.myFilter.ShowActualPlan = true
                    break
                case 3:
                    this.myFilter.ShowOriginalPlan = true
                    this.myFilter.ShowActualPlan = true
                    break
            }

        },
        dialog(v, ov) {
            if (v) {
                if (this.myFilter.ShowOriginalPlan && this.myFilter.ShowActualPlan) {
                    this.planSwitcher = 3
                } else {
                    this.planSwitcher = this.myFilter.ShowOriginalPlan ? 1 : 2
                }
            }
        }
    },
    methods: {
        handleSaveClick() {
            this.dialog = false
            this.$emit('save', this.myFilter)
        }
    },
    mounted() {
        this.myFilter = localStorage.getItem("TaskFilter") ? JSON.parse(localStorage.getItem("TaskFilter")) : { TaskType: this.config.TaskStatus, ShowOriginalPlan: true, ShowActualPlan: true }
        if (this.myFilter.ShowOriginalPlan && this.myFilter.ShowActualPlan) {
            this.planSwitcher = 3
        } else {
            this.planSwitcher = this.myFilter.ShowOriginalPlan ? 1 : 2
        }
    }
}

</script>
<style scoped>
.status-color-block {
    width: 18px;
    height: 18px;
    line-height: 8px;
    border: 1px solid #efefef;
    margin-right: 5px;
    float: left;
}

.plan {
    background: #9c9c9c;
}

.delayed {
    background: #f3550a;
}

.exceed {
    background: #f11b30;
}

.progress {
    background: rgb(241, 205, 0);
}

.status-color-text {
    margin: -1px 0 0 5px;
    float: left;
    font-size: 14px
}

.plan-switcher{
    font-size: 14px;
}
.plan-switcher-label{
    float: left; 
    margin: 6px 8px 0 0; 
    color:rgba(0,0,0,.87);
    font-size: 14px;
}

</style>
