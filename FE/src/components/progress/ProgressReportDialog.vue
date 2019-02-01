<template>
    <v-dialog v-model="dialog" lazy content-class="half-right-dialog" hide-overlay transition="slide-x-reverse-transition">
        <v-card min-height="100%">
            <v-card-title class="grey lighten-4 py-4 title">
                任务进度汇报
            </v-card-title>
            <v-form lazy-validation ref="taskProgressForm">
                <v-container fluid style="max-width: 600px;">
                    <v-layout wrap>
                        <v-flex xs12 md6>
                            任务名称: {{myTask.text}}
                        </v-flex>
                        <v-flex xs12 md6>
                            任务描述: {{myTask.text}}
                        </v-flex>
                        <v-flex xs12 md6>
                            计划周期: {{myTask.text}}
                        </v-flex>
                        <v-flex xs12 md6>
                            计划工时: {{myTask.text}}
                        </v-flex>
                        <v-flex xs12 md6>
                            开工日期: {{myTask.text}}
                        </v-flex>
                        <v-flex xs12 md6>
                            工作进度: {{myTask.text}}
                        </v-flex>
                        <v-flex xs12 md6>
                            工作汇报: {{myTask.text}}
                        </v-flex>
                        <v-flex xs12 md6>
                            汇报日期: {{myTask.text}}
                        </v-flex>
                    </v-layout>
                </v-container>
            </v-form>
        </v-card>
    </v-dialog>
</template>
<script>
export default {
    name: 'ProgressReportDialog',
    props: ['task','open'],
    computed: {
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        },
        myTask(){
            return this.$props.task
        }
    },
    methods: {

    }
}

</script>
<style>
</style>
