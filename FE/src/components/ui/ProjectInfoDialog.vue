<template>
    <v-dialog v-model="dialog" lazy content-class="half-right-dialog" hide-overlay transition="slide-x-reverse-transition">
        <v-card min-height="100%">
            <v-card-title class="grey lighten-4 py-4 title">
                <v-slide-x-transition mode="in-out"><span v-show="edit" style="position: absolute;"><v-icon>edit</v-icon>编辑项目信息</span></v-slide-x-transition>
                <v-slide-x-reverse-transition mode="in-out"><span v-show="!edit" style="position: absolute;">项目信息</span></v-slide-x-reverse-transition>
            </v-card-title>
            <v-form v-model="valid1" lazy-validation ref="editProjectForm">
                <v-container fluid>
                    <v-layout wrap>
                        <v-flex xs6 md6>
                            <v-text-field v-model="projectInfo.Name" :counter="25" label="项目名称" :rules="nameRules" required :readonly="!editable" append-icon="business"></v-text-field>
                        </v-flex>
                        <v-flex xs3 md3>
                            <v-text-field v-model="projectInfo.No" :counter="10" :readonly="!editable" mask="##########" label="项目编号"></v-text-field>
                        </v-flex>
                        <v-flex xs3 md3>
                            <v-select v-model="projectInfo.Type" :readonly="!editable" :items="config.ProjcetType" label="项目类型"></v-select>
                        </v-flex>
                        <v-flex xs6 md6>
                            <v-text-field v-model="projectInfo.Description" :readonly="!editable" :counter="50" label="项目简介"></v-text-field>
                        </v-flex>
                        <v-flex xs3 md3>
                            <v-text-field v-model="projectInfo.Acreage" :readonly="!editable" mask="##########" label="施工面积（㎡）"></v-text-field>
                        </v-flex>
                        <v-flex xs3 md3>
                            <v-text-field v-model="projectInfo.Cost" :readonly="!editable" mask="#######" label="工程造价(万元)" append-icon="attach_money"></v-text-field>
                        </v-flex>
                        <v-flex xs4 md4>
                            <v-text-field v-model="projectInfo.ContractNo" :readonly="!editable" label="施工合同编号"></v-text-field>
                        </v-flex>
                        <v-flex xs4 md4>
                            <v-text-field v-model="projectInfo.WarrantNo" :readonly="!editable" label="施工许可证号"></v-text-field>
                        </v-flex>
                        <v-flex xs4 md4>
                            <v-text-field v-model="projectInfo.ArchiveNo" :readonly="!editable" mask="##########" label="备案号"></v-text-field>
                        </v-flex>
                        <v-flex xs6 md4>
                            <v-menu :close-on-content-click="false" v-model="dateMenu1" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                <v-text-field slot="activator" v-model="projectInfo.StartDate" label="开工日期" prepend-icon="event" readonly></v-text-field>
                                <v-date-picker v-model="projectInfo.StartDate" :readonly="!editable" @input="dateMenu1 = false"></v-date-picker>
                            </v-menu>
                        </v-flex>
                        <v-flex xs6 md4>
                            <v-menu :close-on-content-click="false" v-model="dateMenu2" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                <v-text-field slot="activator" v-model="projectInfo.EndDate" label="竣工日期" prepend-icon="event" readonly></v-text-field>
                                <v-date-picker v-model="projectInfo.EndDate" :v-if="editable" @input="dateMenu2 = false"></v-date-picker>
                            </v-menu>
                        </v-flex>
                        <v-flex xs6 md4>
                            <v-select v-model="projectInfo.Status" :readonly="!editable" :items="config.ProjectStatus" label="项目状态"></v-select>
                        </v-flex>
                        <v-flex xs6 md12>
                            <v-text-field v-model="projectInfo.FirstParty" :readonly="!editable" label="项目甲方"></v-text-field>
                        </v-flex>
                        <v-flex sm12>
                            <v-text-field v-model="projectInfo.Location" :readonly="!editable" label="项目地点"></v-text-field>
                        </v-flex>
                        <v-flex xs12 sm12>
                            <v-layout justify-center pa-3>
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
                                        <v-btn @click="edit = false">取消</v-btn>
                                        <v-btn color="primary" @click="handleSaveClick" :disabled="!valid1" :loading="saving">保存</v-btn>
                                        <v-spacer></v-spacer>
                                    </v-card-actions>
                                </v-fade-transition>
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
            readonly: false,
            edit: false,
            saving: false,
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
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        }
    },
    methods: {
        handleSaveClick() {
            //form validtion
            if (this.$refs.editProjectForm.validate()) {
                this.loading = true
                this.saving = true
                this.$http.put(this.config.API_URL + '/Project/'  + this.projectInfo.Id, this.projectInfo).then(function(res) {
                    var json = JSON.parse(res.bodyText)
                    this.loading = this.edit = this.saving = false
                    this.$emit('update')
                }, function(res) {
                    var json = JSON.parse(res.bodyText)
                    this.loading = this.saving = false
                });
            }
        },
    }
}

</script>
<style>


.dialog-left-transition {}

</style>
