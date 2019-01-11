<template>
    <v-dialog v-model="dialogOpen" lazy content-class="half-right-dialog" hide-overlay transition="slide-x-reverse-transition">
        <v-card min-height="100%">
            <v-card-title class="grey lighten-4 py-4 title">
                <v-slide-y-transition mode="in-out"><span v-show="edit" style="position: absolute;">编辑项目信息</span></v-slide-y-transition>
                <v-slide-y-transition mode="in-out"><span v-show="!edit" style="position: absolute;">项目信息</span></v-slide-y-transition>
            </v-card-title>
            <v-form v-model="valid1" lazy-validation ref="editProjectForm">
                <v-container fluid>
                    <v-layout wrap>
                        <v-flex xs6 md6>
                            <v-text-field v-model="projectInfo.name" :counter="25" label="项目名称" :rules="nameRules" required :readonly="!editable" append-icon="business"></v-text-field>
                        </v-flex>
                        <v-flex xs3 md3>
                            <v-text-field v-model="projectInfo.no" :counter="10" mask="##########" label="项目编号"></v-text-field>
                        </v-flex>
                        <v-flex xs3 md3>
                            <v-select v-model="projectInfo.type" :items="config.ProjcetType" label="项目类型"></v-select>
                        </v-flex>
                        <v-flex xs6 md6>
                            <v-text-field v-model="projectInfo.description" :counter="50" label="项目简介"></v-text-field>
                        </v-flex>
                        <v-flex xs3 md3>
                            <v-text-field v-model="projectInfo.acreage" mask="##########" label="施工面积（㎡）"></v-text-field>
                        </v-flex>
                        <v-flex xs3 md3>
                            <v-text-field v-model="projectInfo.cost" mask="#######" label="工程造价(万元)" append-icon="attach_money"></v-text-field>
                        </v-flex>
                        <v-flex xs4 md4>
                            <v-text-field v-model="projectInfo.contractNo" label="施工合同编号"></v-text-field>
                        </v-flex>
                        <v-flex xs4 md4>
                            <v-text-field v-model="projectInfo.warrantNo" label="施工许可证号"></v-text-field>
                        </v-flex>
                        <v-flex xs4 md4>
                            <v-text-field v-model="projectInfo.backupNo" mask="##########" label="备案号"></v-text-field>
                        </v-flex>
                        <v-flex xs6 md4>
                            <v-menu :close-on-content-click="false" v-model="dateMenu1" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                <v-text-field slot="activator" v-model="projectInfo.startDate" label="开工日期" prepend-icon="event" readonly></v-text-field>
                                <v-date-picker v-model="projectInfo.startDate" @input="dateMenu1 = false"></v-date-picker>
                            </v-menu>
                        </v-flex>
                        <v-flex xs6 md4>
                            <v-menu :close-on-content-click="false" v-model="dateMenu2" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                <v-text-field slot="activator" v-model="projectInfo.endDate" label="竣工日期" prepend-icon="event" readonly></v-text-field>
                                <v-date-picker v-model="projectInfo.endDate" @input="dateMenu2 = false"></v-date-picker>
                            </v-menu>
                        </v-flex>
                        <v-flex xs6 md4>
                            <v-select v-model="projectInfo.status" :items="config.ProjectStatus" label="项目状态"></v-select>
                        </v-flex>
                        <v-flex xs6 md12>
                            <v-text-field v-model="projectInfo.firstParty" label="项目甲方"></v-text-field>
                        </v-flex>
                        <v-flex md12>
                            <v-text-field v-model="projectInfo.location" label="项目地点"></v-text-field>
                        </v-flex>
                        <v-flex>
                            <v-layout align-end justify-center row fill-height pa-5>
                                <v-fade-transition mode="in-out">
                                    <v-card-actions v-if="!edit" style="position: absolute;">
                                        <v-spacer></v-spacer>
                                        <v-btn color="primary" @click="edit=true">编辑</v-btn>
                                        <v-spacer></v-spacer>
                                    </v-card-actions>
                                </v-fade-transition>
                                <v-fade-transition mode="in-out">
                                    <v-card-actions bottom v-if="edit" style="position: absolute;">
                                        <v-spacer></v-spacer>
                                        <v-btn  @click="handleCancelClick">取消</v-btn>
                                        <v-btn color="primary" @click="handleSaveClick" :disabled="!valid1" :loading="valid1">保存</v-btn>
                                        <v-spacer></v-spacer>
                                    </v-card-actions>
                                </v-fade-transition>
                                <v-snackbar v-model="snackbar" right>
                                    项目信息保存成功
                                    <v-btn color="success" flat @click="snackbar = false">
                                        确定
                                    </v-btn>
                                </v-snackbar>
                            </v-layout>
                        </v-flex>
                    </v-layout>
                </v-container>
            </v-form>
        </v-card>
    </v-dialog>
</template>
<script>
import config from '../../assets/js/Config'
export default {
    name: 'ProjectInfoDialog',
    props: ['open', 'project'],
    data() {
        return {
            config,
            snackbar: false,
            readonly: false,
            edit: false,
            valid1: true,
            dateMenu1: false,
            dateMenu2: false,
            nameRules: [
                v => !!v || '请输入项目名称',
                v => (v && v.length <= 25) || '最多输入25个字符'
            ],
        }
    },
    computed: {
        projectInfo() {
            return this.$props.project
        },
        editable() {
            return !this.readonly && this.edit
        },
        dialogOpen: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('dialogClose')
            }
        }
    },
    methods: {
        handleCancelClick() {
            this.edit = false
        },
        handleSaveClick() {
            this.edit = false
            this.snackbar = true
            //TODO call save project

        }
    }
}

</script>
<style>
.half-right-dialog {
    width: 480px;
    right: 0;
    height: auto;
    position: fixed;
    overflow-y: auto;
    top: 65px;
    margin: 0;
    bottom: 0px;
}

.dialog-left-transition {}

</style>
