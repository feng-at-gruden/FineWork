<template>
    <v-dialog v-model="dialog" lazy persistent :content-class="dialogCss" transition="scale-transition">
        <v-card min-height="100%">
            <v-card-title class="grey lighten-4 py-3 title">
                添加系统用户
            </v-card-title>
            <v-form lazy-validation ref="createUserForm">
                <v-container fluid class="report-dialog-container">
                    <v-layout wrap>
                        <v-flex xs12 md12>
                            <v-icon class="my-icon">launch</v-icon><span class="title"> 添加</span>
                        </v-flex>
                        
                        
                        <v-flex xs12 md12 style="margin-top: -10px;">
                            <v-divider></v-divider>
                        </v-flex>
                        <v-flex xs12 md12 style="margin-top: 0px;">
                            <v-textarea label="工作汇报" :counter="100" required outline hint="请输入当天工作进展情况"></v-textarea>
                        </v-flex>
                        
                        
                        <v-flex xs12 sm12>
                            <v-layout justify-center pa-2 style="margin-bottom:20px;">
                                <v-card-actions bottom>
                                    <v-spacer></v-spacer>
                                    <v-btn @click="handleCancelClick">取消</v-btn>
                                    <v-btn color="primary" @click="handleSaveClick" :loading="loading">保存</v-btn>
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
    name: 'CreateUserDialog',
    props: ['open'],
    data() {
        return {
            config,
            util,
            snackbar: false,
            snackbarMessage: '',
            snackbarColor: '',
            loading:false,
        }
    },
    computed: {
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        },
        dialogCss() {
            return this.util.IsPC() ? 'create-user-dialog' : 'create-user-dialog-mobile'
        },
    },
    methods: {
        handleCancelClick() {
            this.$refs.createUserForm.reset()
            this.dialog = false
        },
        handleSaveClick() {
            
        },
        showSnackbar(msg, color) {
            this.snackbarMessage = msg
            this.snackbarColor = color
            this.snackbar = true
        },
    },
    watch: {
        
    },

}

</script>
<style scoped>

</style>