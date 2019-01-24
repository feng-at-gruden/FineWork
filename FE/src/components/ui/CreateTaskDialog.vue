<template>
    <v-dialog v-model="dialog" lazy transition="scale-transition" width="720">
        <v-card>
            <v-card-title class="grey lighten-4 py-4 title">
                添加{{unitName}}
            </v-card-title>
            <v-form v-model="formValid" lazy-validation ref="createTaskForm">
                <v-container fluid>
                    <v-layout wrap>
                        <v-flex xs8 md8>
                            <v-text-field v-model="task.text" :counter="25" :label="unitLabel" :rules="nameRules" required  append-icon="business"></v-text-field>
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
                        
                        <v-flex>
                            <v-layout align-end justify-center row fill-height>
                                    <v-spacer></v-spacer>
                                    <v-btn @click="dialog = false">取消</v-btn>
                                    <v-btn color="primary" @click="handleSaveClick" :disabled="!formValid">确定</v-btn>
                            </v-layout>
                        </v-flex>
                    </v-layout>
                </v-container>
            </v-form>
        </v-card>
    </v-dialog>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import config from '../../assets/js/Config'
export default {
    extends: BasePage,
    name: 'CreateTaskDialog',
    props: ['open', 'newTask', 'unit'],
    data() {
        return {
            config,            
            formValid: true,
            dateMenu1: false,
            dateMenu2: false,
            nameRules: [
                v => !!v || '请输入'+this.unitName+'名称',
                v => (v && v.length <= 25) || '最多输入25个字符'
            ],
        }
    },
    computed:{
        task(){
            return this.$props.newTask
        },
        unitName(){
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
            if (this.$refs.createTaskForm.validate()){
                //this.formValid = true
                this.dialog = false                
                this.$emit('save', this.task)
            }            
        }
    },
}

</script>
<style>
</style>
