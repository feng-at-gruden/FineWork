<template>
    <v-menu v-model="dialog" :close-on-content-click="false" max-width="300" nudge-bottom="50" offset-x nudge-left="155" attach="#hearder-search-btn">
        <v-card>
            <v-list>
                <v-list-tile avatar>
                    <v-list-tile-avatar>
                        <v-icon big>filter_none</v-icon>
                    </v-list-tile-avatar>
                    <v-list-tile-content>
                        <v-list-tile-title>任务过滤器</v-list-tile-title>
                        <v-list-tile-sub-title>选择需要显示的任务类型</v-list-tile-sub-title>
                    </v-list-tile-content>
                    <v-list-tile-action>
                        <v-icon small>done_all</v-icon>
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
                    <v-list-tile-action>
                        <v-checkbox v-model="myFilter.ShowOriginalPlan" label="显示原计划"></v-checkbox>
                    </v-list-tile-action>
                </v-list-tile>
                <v-divider></v-divider>
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
            <v-card-actions>
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
    methods: {
        handleSaveClick() {
            this.dialog = false
            this.$emit('save', this.myFilter)
        }
    },
    mounted() {
        this.myFilter = localStorage.getItem("TaskFilter") ? JSON.parse(localStorage.getItem("TaskFilter")) : {TaskType: this.config.TaskStatus, ShowOriginalPlan: true}
    }
}

</script>
<style scoped>
.status-color-block {
    width: 20px;
    height: 20px;
    line-height: 10px;
    border: 1px solid #efefef;
    margin-right: 5px;
    float: left;
}
.plan{
	background: #9c9c9c;
}
.delayed{
	background: #f3550a;
}
.exceed{
	background: #f11b30;
}
.progress{
	background: rgb(241, 205, 0);
}
.status-color-text{
	margin: -1px 0 0 5px;
    float: left;
    font-size: 15px
}
</style>
