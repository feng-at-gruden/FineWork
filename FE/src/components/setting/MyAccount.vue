<template>
    <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
            <v-toolbar dark color="primary">
                <v-btn icon dark @click="handleCancel">
                    <v-icon>close</v-icon>
                </v-btn>
                <v-toolbar-title>个人设置</v-toolbar-title>
                <v-spacer></v-spacer>
                <v-toolbar-items>
                    <v-btn dark flat @click="handleSave" :loading="loading">保存</v-btn>
                </v-toolbar-items>
            </v-toolbar>
            <v-form lazy-validation ref="editAccountForm">
                <v-list three-line subheader>
                    <v-subheader>登录信息</v-subheader>
                    <v-list-tile avatar>
                        <v-list-tile-content>
                            <v-list-tile-title>登录帐号: <b>{{identityCopy.UserName}}</b></v-list-tile-title>
                            <v-list-tile-sub-title>用户登录帐号不可更改</v-list-tile-sub-title>
                        </v-list-tile-content>
                    </v-list-tile>
                    <v-list-tile avatar>
                        <v-list-tile-content>
                            <v-text-field v-model="identityCopy.RealName" label="用户名" placeholder="姓名" hint="真实姓名，非登录帐号" persistent-hint :rules="[rules.RealNameRule]"></v-text-field>
                        </v-list-tile-content>
                    </v-list-tile>
                    <v-list-tile avatar>
                        <v-list-tile-content>
                            <v-text-field v-model="identityCopy.Mobile" label="联系方式" placeholder="电话" hint="手机或固定电话号码" mask="###########" persistent-hint></v-text-field>
                        </v-list-tile-content>
                    </v-list-tile>
                    <v-list-tile avatar>
                        <v-list-tile-content>
                            <v-text-field v-model="identityCopy.Password" placeholder="密码" type="password" label="登录密码" hint="如需修改密码请输入新的密码，不输入或保持为空则原密码不变" persistent-hint :rules="[rules.PasswordRule]"></v-text-field>
                        </v-list-tile-content>
                    </v-list-tile>
                </v-list>
            </v-form>
            <v-alert :value="alert.open" type="error" icon="warning" dismissible transition="slide-y-transition">
                {{alert.message}}
            </v-alert>
            <v-divider></v-divider>
            <v-list three-line subheader>
                <v-subheader>偏好设置</v-subheader>
                <v-list-tile avatar style="">
                    <v-list-tile-action>
                        <v-icon large style="margin-top: 15px;">color_lens</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                        <v-list-tile-title>主题颜色:</v-list-tile-title>
                        <div>
                            <div v-for="item in config.Themes" @click="selectTheme(item)" class="theme-block" :style="themeStyle(item)"></div>
                        </div>
                    </v-list-tile-content>
                </v-list-tile>
            </v-list>
        </v-card>
    </v-dialog>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
export default {
    extends: BasePage,
    name: 'MyAccount',
    props: ['open'],
    data: () => ({
        identityCopy: {},
        alert: { open: false, message: '' },
        rules: {
            RealNameRule: v => v == '' || !v || v && v.length < 25 || '用户名过长',
            PasswordRule: v => v == '' || !v || v && v.length >= 4 || '密码至少为4位',
        }
    }),
    computed: {
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        },
        identity: {
            get() {
                if (this.$store.state.identity != null) {
                    return this.$store.state.identity
                } else {
                    return JSON.parse(localStorage.getItem("Identity"))
                }
            },
            set(v) {
                this.$store.commit('userLogin', v)
            }
        }
    },
    methods: {
        handleCancel() {
            this.$refs.editAccountForm.reset()
            this.dialog = false
            this.loading = false
            //this.identityCopy = this.util.objCopy(this.identity)
        },
        handleSave() {
            //Call API
            if (this.$refs.editAccountForm.validate()) {
                this.loading = true
                //Call API
                this.$http.put(this.config.API_URL + '/Account/AccountInfo', this.identityCopy).then(function(res) {
                    //Success
                    this.loading = false
                    this.dialog = false
                    this.identity = this.identityCopy
                }, function(res) {
                    var json = JSON.parse(res.bodyText)
                    this.showAlert(json.Message)
                    this.loading = false
                });
            }
        },
        showAlert(msg) {
            this.alert.message = msg
            this.alert.open = true
        },
        themeStyle(theme) {
            if (typeof(theme.primary) == 'string') {
                return {
                    backgroundColor: theme.primary,
                }
            } else {
                return {
                    backgroundColor: theme.primary.base,
                }
            }

        },
        selectTheme(theme) {
            this.$vuetify.theme = theme
            localStorage.setItem("Theme",JSON.stringify(theme))
        }
    },
    mounted() {
        this.identityCopy = this.util.objCopy(this.identity)
    },
    watch: {
        dialog(v, ov) {
            if (v) {
                this.identityCopy = this.util.objCopy(this.identity)
            }
        }
    }
}

</script>
<style scoped>
.theme-block {
    width: 60px;
    height: 60px;
    line-height: 20px;
    border: 1px solid #ccc;
    display: block;
    margin: 5px;
    float: left;
    cursor: pointer;
}

</style>
