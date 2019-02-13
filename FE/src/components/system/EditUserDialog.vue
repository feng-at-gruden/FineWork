<template>
    <v-dialog v-model="dialog" lazy persistent :content-class="dialogCss" transition="scale-transition">
        <v-card>
            <v-card-title class="grey lighten-4 py-3 title">
                修改用户信息
            </v-card-title>
            <v-form lazy-validation ref="createUserForm">
                <v-container fluid class="report-dialog-container">
                    <v-layout wrap>
                        <v-flex xs12 md6>
                            <v-text-field v-model="myUser.UserName" disabled label="登录帐号" required append-icon="account_box"></v-text-field>
                        </v-flex>
                        <v-flex xs12 md6>
                            <v-text-field v-model="myUser.Password" :append-icon="passwordShow ? 'visibility_off' : 'visibility'" :type="passwordShow ? 'text' : 'password'" name="input-10-2" label="登录密码" :counter="20" class="input-group--focused" @click:append="passwordShow = !passwordShow" autocomplete="off"></v-text-field>
                        </v-flex>
                        <v-flex xs12 md6>
                            <v-text-field v-model="myUser.RealName" :counter="25" label="用户名" required append-icon="card_membership"></v-text-field>
                        </v-flex>
                        <v-flex xs12 md6>
                            <v-text-field v-model="myUser.Mobile" :counter="25" mask="###########" label="联系方式" required append-icon="phone_android"></v-text-field>
                        </v-flex>
                        <v-flex xs12 md12>
                            <v-select v-model="myUser.Permissions" :items="config.UserPermissions" item-text="text" item-value="value" label="用户权限" multiple chips hint="请选择用户操作权限" persistent-hint append-outer-icon="markunread_mailbox"></v-select>
                        </v-flex>
                        <v-flex xs12 sm12>
                            <v-layout justify-center pa-2 style="margin-bottom:10px;">
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
        <v-alert :value="alert.open" type="error" icon="warning" dismissible transition="slide-y-transition">
            {{alert.message}}
        </v-alert>
    </v-dialog>
</template>
<script>
import config from '../../assets/js/Config'
import util from '../../assets/js/Util'

export default {
    name: 'EditUserDialog',
    props: ['open', 'user'],
    data() {
        return {
            config,
            util,
            alert: { open: false, message: '' },
            loading: false,
            passwordShow: false,
            rules: {
                required: value => !!value || '不能为空.',
                min: v => v && v.trim().length >= 4 || '最少为4位字母',
            }
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
        myUser() {
            return this.$props.user
        }
    },
    methods: {
        handleCancelClick() {
            this.dialog = false
        },
        handleSaveClick() {
            if (this.$refs.createUserForm.validate()) {
                this.loading = true
                //Call API
                this.$http.put(this.config.API_URL + '/User/' + this.myUser.Id, this.myUser).then(function(res) {
                    //Success
                    this.$emit('save', this.myUser)
                    this.loading = false
                    this.dialog = false
                }, function(res) {
                    var json = JSON.parse(res.bodyText)
                    this.showAlert(json.Message)
                    this.loading = false
                    this.dialog = false
                });


            }
        },
        showAlert(msg) {
            this.alert.message = msg
            this.alert.open = true
        },
    },
}

</script>
<style scoped>
</style>
