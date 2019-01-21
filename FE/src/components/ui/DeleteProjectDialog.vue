<template>
    <v-dialog persistent v-model="dialog" content-class="top-right-dialog" max-width="290">
        <v-form lazy-validation ref="deleteForm">
            <v-card>
                <v-card-title class="grey lighten-3 title">
                    <v-icon>delete</v-icon>
                    <v-slide-y-reverse-transition mode="in-out"><span v-show="!deleteConfirm" style="position: absolute;left:40px;">删除确认</span></v-slide-y-reverse-transition>
                    <v-slide-y-transition mode="in-out"><span v-show="deleteConfirm" style="position: absolute;left:40px;">二次确认</span></v-slide-y-transition>
                </v-card-title>
                <v-card-text>
                    <span class="delete-project-desc">您确定要删除这个项目吗？删除后其相关任务及工作汇报都将被删除！</span>
                    <v-expand-transition mode="in-out">
                        <v-text-field class="delete-project-input" v-if="deleteConfirm" v-model="confirmText" :rules="nameRules" required placeholder="输入[确认]以删除"></v-text-field>
                    </v-expand-transition>
                </v-card-text>
                <v-card-actions class="pa-3" v-if="!deleteConfirm">
                    <v-spacer></v-spacer>
                    <v-btn @click="dialog = false">取消</v-btn>
                    <v-btn color="error" @click="deleteConfirm = true">删除</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
                <v-card-actions class="pa-3 " v-if="deleteConfirm">
                    <v-spacer></v-spacer>
                    <v-btn @click="deleteConfirm = false">返回</v-btn>
                    <v-btn color="error" @click="handleDeleteClick">删除</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-form>
    </v-dialog>
</template>
<script>
import config from '../../assets/js/Config'
export default {
    name: 'DeleteProjectDialog',
    props: ['open'],
    data() {
        return {
            config,
            deleteConfirm: false,
            confirmText: '',
            nameRules: [
                v => !!v || '请输入[确认]',
                v => (v && v == '确认') || '请输入[确认]'
            ],
        }
    },
    computed: {
        dialog: {
            get() { return this.$props.open },
            set(v) {
                if (!v) {
                    this.$emit('close')
                    this.confirmText = ''
                    this.deleteConfirm = false
                }
            }
        },
        projectId() {
            return this.$route.params.id
        },
    },
    methods: {
        handleDeleteClick() {
            if (this.$refs.deleteForm.validate()) {
                this.$http.delete(this.config.API_URL + '/Project/' + this.projectId).then(function(res) {
                    this.$emit('delete')
                }, function(res) {
                    
                })
            }
        }
    }
}

</script>
<style>
.top-right-dialog {
    width: 480px;
    right: 0;
    height: auto;
    position: fixed;
    overflow-y: auto;
    top: 65px;
    margin: 0;
}

.delete-project-confirm-btn {
    padding-top: 0px !important;
}
.delete-project-input{
    padding-top: 0px !important;
    margin-top: 0px !important;   
}
.delete-project-desc{
    padding-bottom: 15px;
    display: block;
}
</style>
