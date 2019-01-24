<template>
    <div>
        <!-- 编辑Task对话框 -->
        <v-dialog v-model="dialog" lazy transition="scale-transition" width="720">
            <v-card>
                <v-card-title class="grey lighten-4 py-4 title">
                    编辑{{unitName}}
                </v-card-title>
                <v-form v-model="formValid" lazy-validation ref="taskForm">
                    <v-container fluid>
                        <v-layout wrap>
                            <v-flex xs8 md8>
                                <v-text-field v-model="task.text" :counter="25" :label="unitLabel" :rules="nameRules" required append-icon="business"></v-text-field>
                            </v-flex>
                            <v-flex xs4 md4>
                                <v-select v-model="task.status" :items="config.TaskStatus" label="计划状态"></v-select>
                            </v-flex>
                            <v-flex xs12 md12>
                                <v-text-field v-model="task.description" :counter="50" label="工作内容描述"></v-text-field>
                            </v-flex>
                            <v-flex xs6 md6>
                                <v-menu :close-on-content-click="false" v-model="dateMenu1" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                    <v-text-field slot="activator" v-model="task.start_date" label="开始日期" prepend-icon="event" readonly></v-text-field>
                                    <v-date-picker v-model="task.start_date" :min="task.min_date" :max="task.max_date" @input="dateMenu1 = false"></v-date-picker>
                                </v-menu>
                            </v-flex>
                            <v-flex xs6 md6>
                                <v-menu :close-on-content-click="false" v-model="dateMenu2" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                    <v-text-field slot="activator" v-model="task.end_date" label="结束日期" prepend-icon="event" readonly></v-text-field>
                                    <v-date-picker v-model="task.end_date" :min="task.min_date" :max="task.max_date" @input="dateMenu2 = false"></v-date-picker>
                                </v-menu>
                            </v-flex>
                            <v-flex xs12>
                                <v-layout xs12 justify-center row>
                                    <v-btn color="error" @click="deleteConfirm = true">删除<v-icon right dark>delete</v-icon>
                                    </v-btn>
                                    <v-spacer></v-spacer>
                                    <v-btn @click="dialog = false">取消</v-btn>
                                    <v-btn color="primary" @click="handleSaveClick" :disabled="!formValid">保存</v-btn>
                                </v-layout>
                            </v-flex>
                        </v-layout>
                    </v-container>
                </v-form>
            </v-card>
        </v-dialog>
        <!-- 删除Task确认对话框 -->
        <v-dialog persistent v-model="deleteConfirm" max-width="290">
            <v-card>
                <v-card-title class="grey lighten-3 title"><v-icon>delete</v-icon>删除确认</v-card-title>
                <v-card-text>您确定要删除这个{{unitName}}吗？删除后其相关任务及工作汇报都将被删除！</v-card-text>
                <v-card-actions class="pa-3">
                    <v-spacer></v-spacer>
                    <v-btn @click="deleteConfirm = false">取消</v-btn>
                    <v-btn color="error" @click="handleDeleteClick">删除</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </div>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import config from '../../assets/js/Config'
export default {
    extends: BasePage,
    name: 'EditTaskDialog',
    props: ['open', 'taskToEdit', 'unit'],
    data() {
        return {
            config,
            formValid: true,
            dateMenu1: false,
            dateMenu2: false,
            deleteConfirm: false,
            nameRules: [
                v => !!v || '请输入' + this.unitName + '名称',
                v => (v && v.length <= 25) || '最多输入25个字符'
            ],
        }
    },
    computed: {
        task() {
            return this.$props.taskToEdit
        },
        unitName() {
            return this.$props.unit
        },
        unitLabel(){
            return this.$props.unit + "名称"
        },
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        }
    },
    methods: {
        handleSaveClick() {
            if (this.$refs.taskForm.validate()) {
                this.formValid = true
                this.dialog = false
                this.task.duration = this.util.dateDifference(this.task.end_date, this.task.start_date)
                this.$emit('save', this.task)
            }
        },
        handleDeleteClick() {
            this.deleteConfirm = false
            this.dialog = false
            this.$emit('delete', this.task)
        },
    }
}
</script>
<style>
</style>
