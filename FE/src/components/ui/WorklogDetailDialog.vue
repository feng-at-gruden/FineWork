<template>
    <v-dialog v-model="dialog" max-width="540">
        <v-card>
            <v-card-title class="grey lighten-3 title">
                工作汇报  
                <v-icon>announcement</v-icon>
            </v-card-title>
            <v-card-text>
                <div class="worklog-text" v-html="myWorklog.text"></div>
                
                <div style="float: right; display: block; margin-top: -23px;">
                    <div class="worklog-tip" v-if="statusUpdate!=''">
                        <v-icon class="my-work-icon">check_box</v-icon> {{statusUpdate}}
                    </div>
                    <div class="worklog-tip" v-if="progressUpdate!=''">
                        <v-icon class="my-work-icon">trending_up</v-icon> {{progressUpdate}}
                    </div>
                </div>
                <v-divider></v-divider>
                <br style="clear: both; line-height: 0px; height: 0px;" />
                <div style="float: right; display: block;">
                    <div class="worklog-tip">
                        汇报人: {{myWorklog.created_by}}
                    </div>
                </div>
                <br style="clear: both; line-height: 0px; height: 0px;" />
            </v-card-text>
            <v-card-actions class="pa-3" style="padding-top: 0px !important;">
                <v-spacer></v-spacer>
                <v-btn @click="dialog = false">关闭</v-btn>
                <v-spacer></v-spacer>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>
<script>
export default {
    name: 'WorklogDetailDialog',
    props: ['open', 'worklog'],
    data() {
        return {

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
        myWorklog() {
            return this.$props.worklog
        },
        progressUpdate() {
            var s = ''
            if (this.myWorklog.details && this.myWorklog.details != null) {
                var t = this.myWorklog.details.split('#')
                if (t[0] != t[1])
                    s += '进度: ' + t[0].replace('.00','') + ' → ' + t[1].replace('.00','')
                else
                    s += '进度: ' + t[1].replace('.00','')
            }
            return s
        },
        statusUpdate() {
            var s = ''
            if (this.myWorklog.details && this.myWorklog.details != null) {
                var t = this.myWorklog.details.split('#')
                if (t[2] != t[3])
                    s += '状态: ' + t[2] + ' → ' + t[3]
                else
                    s += '状态: ' + t[3]
            }
            return s
        }
    },
    methods: {

    }
}

</script>
<style scoped>
.worklog-text {
    margin-bottom: 40px;
    min-height: 100px;
}
.worklog-tip {
    font-size: 12px;
    text-align: left;
    float: right;
    margin-right: 10px;
    font-style: italic;
}
.my-work-icon {
    margin: 5px 0px 0 0;
    font-size: 15px;
}

</style>
