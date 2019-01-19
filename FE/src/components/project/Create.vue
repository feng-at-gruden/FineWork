<template>
    <v-layout>
        <v-stepper v-model="step" vertical color="primary">
            <v-stepper-step :complete="step > 1" step="1">
                项目基础信息
            </v-stepper-step>
            <v-stepper-content step="1">
                <v-card color="grey lighten-5" class="mb-5">
                    <!-- 项目信息 -->
                    <v-form v-model="valid1" lazy-validation ref="createProjectForm1">
                        <v-container>
                            <v-layout wrap>
                                <v-flex xs12 md6>
                                    <v-text-field v-model="project.Name" :counter="25" label="项目名称" :rules="nameRules" required append-icon="business"></v-text-field>
                                </v-flex>
                                <v-flex xs6 md3>
                                    <v-text-field v-model="project.No" :counter="10" mask="##########" label="项目编号"></v-text-field>
                                </v-flex>
                                <v-flex xs6 md3>
                                    <v-select v-model="project.Type" :items="config.ProjcetType" label="项目类型"></v-select>
                                </v-flex>
                            </v-layout>
                            <v-layout wrap>
                                <v-flex xs12 md6>
                                    <v-text-field v-model="project.Description" :counter="50" label="项目简介"></v-text-field>
                                </v-flex>
                                <v-flex xs6 md3>
                                    <v-text-field v-model="project.Acreage" mask="##########" label="施工面积（㎡）"></v-text-field>
                                </v-flex>
                                <v-flex xs6 md3>
                                    <v-text-field v-model="project.Cost" mask="#######" label="工程造价(万元)" append-icon="attach_money"></v-text-field>
                                </v-flex>
                            </v-layout>
                            <v-layout wrap>
                                <v-flex xs6 md4>
                                    <v-text-field v-model="project.ContractNo" label="施工合同编号"></v-text-field>
                                </v-flex>
                                <v-flex xs6 md4>
                                    <v-text-field v-model="project.WarrantNo" label="施工许可证号"></v-text-field>
                                </v-flex>
                                <v-flex xs6 md4>
                                    <v-text-field v-model="project.ArchiveNo" mask="##########" label="备案号"></v-text-field>
                                </v-flex>
                            </v-layout>
                            <v-layout wrap>
                                <v-flex xs6 md4>
                                    <v-menu :close-on-content-click="false" v-model="dateMenu1" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                        <v-text-field slot="activator" v-model="project.StartDate" label="开工日期" prepend-icon="event" readonly></v-text-field>
                                        <v-date-picker v-model="project.StartDate" @input="dateMenu1 = false"></v-date-picker>
                                    </v-menu>
                                </v-flex>
                                <v-flex xs6 md4>
                                    <v-menu :close-on-content-click="false" v-model="dateMenu2" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                        <v-text-field slot="activator" v-model="project.EndDate" label="竣工日期" prepend-icon="event" readonly></v-text-field>
                                        <v-date-picker v-model="project.EndDate" @input="dateMenu2 = false"></v-date-picker>
                                    </v-menu>
                                </v-flex>
                                <v-flex xs12 md4>
                                    <v-select v-model="project.Status" :items="config.ProjectStatus" label="项目状态"></v-select>
                                </v-flex>
                            </v-layout>
                            <v-layout wrap>
                                <v-flex xs12 md6>
                                    <v-text-field v-model="project.Location" label="项目地点" prepend-icon="location_on"></v-text-field>
                                </v-flex>
                                <v-flex xs12 md6>
                                    <v-text-field v-model="project.FirstParty" label="项目甲方"></v-text-field>
                                </v-flex>
                            </v-layout>
                        </v-container>
                    </v-form>
                </v-card>
                <v-btn color="primary" @click="validate1" :disabled="!valid1">下一步</v-btn>
            </v-stepper-content>
            <v-stepper-step :complete="step > 2" step="2">工程施工阶段</v-stepper-step>
            <v-stepper-content step="2">
                <!-- 项目阶段 -->
                <v-card color="grey lighten-5" class="mb-5">
                    <v-container>
                        <v-layout>
                            <v-flex xs12 sm8>
                                <v-select :items="config.ProjectPhase" v-model="project.Phase" label="请选择项目主要施工阶段" multiple chips hint="各施工阶段工期评估可稍后在项目计划中进行设置" persistent-hint></v-select>
                            </v-flex>
                        </v-layout>
                    </v-container>
                </v-card>
                <v-btn color="primary" @click="step++">下一步</v-btn>
                <v-btn flat @click="step--">上一步</v-btn>
            </v-stepper-content>
            <!-- <v-stepper-step :complete="step > 3" step="3">添加项目管理人员</v-stepper-step>
        <v-stepper-content step="3">
            <v-card color="grey lighten-1" class="mb-5" height="200px"></v-card>
            <v-btn color="primary" @click="step++">下一步</v-btn>
            <v-btn flat @click="step--">上一步</v-btn>
        </v-stepper-content> -->
            <v-stepper-step step="3">项目信息确认</v-stepper-step>
            <v-stepper-content step="3">
                <v-card color="grey lighten-1" class="mb-5" height="200px"></v-card>
                <v-btn color="primary" @click="handelSaveProject">生成项目</v-btn>
                <v-btn flat @click="step--">上一步</v-btn>
            </v-stepper-content>
        </v-stepper>
        <v-snackbar v-model="snackbar" :color="snackbarColor" multi-line vertical bottom right>
            {{snackbarMessage}}
            <v-btn dark flat @click="snackbar = false">确定</v-btn>
        </v-snackbar>
    </v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'

export default {
    extends: BasePage,
    name: 'CreateProject',
    props: [],
    computed: {

    },
    data() {
        return {
            step: 1,
            valid1: true,
            dateMenu1: false,
            dateMenu2: false,
            nameRules: [
                v => !!v || '请输入项目名称',
                v => (v && v.length <= 25) || '最多输入25个字符'
            ],
            project: {
                StartDate: new Date().toISOString().substr(0, 10),
                EndDate: new Date().toISOString().substr(0, 10),
                Phase: [],
            },
            snackbar: false,
            snackbarMessage: '',
            snackbarColor: '',
        }
    },
    methods: {
        validate1() {
            if (this.$refs.createProjectForm1.validate()) {
                //this.snackbar = true
                this.step++
            }
        },
        handelSaveProject() {
            this.$http.post(this.config.API_URL + '/Project', this.project).then(function(res) {
                var json = JSON.parse(res.bodyText)
                this.showSnackbar(json.Message, 'success')
                this.$router.push('/Project/List')
            }, function(res) {
                var json = JSON.parse(res.bodyText)
                this.showSnackbar(json.Message, 'error')
            });
        },
        showSnackbar(msg, color) {
            this.snackbarMessage = msg
            this.snackbarColor = color
            this.snackbar = true
        },
    }
}

</script>
<style>
</style>
