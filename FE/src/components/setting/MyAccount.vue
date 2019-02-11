<template>
    <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
            <v-toolbar dark color="primary">
                <v-btn icon dark @click="dialog = false">
                    <v-icon>close</v-icon>
                </v-btn>
                <v-toolbar-title>个人设置</v-toolbar-title>
                <v-spacer></v-spacer>
                <v-toolbar-items>
                    <v-btn dark flat @click="dialog = false">保存</v-btn>
                </v-toolbar-items>
            </v-toolbar>
            <v-list three-line subheader>
                <v-subheader>登录信息</v-subheader>
                <v-list-tile avatar>
                    <v-list-tile-content>
                        <v-list-tile-title>真实姓名</v-list-tile-title>
                        <v-list-tile-sub-title>Set the content filtering level to restrict apps that can be downloaded</v-list-tile-sub-title>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile avatar>
                    <v-list-tile-content>
                        <v-list-tile-title>登录密码</v-list-tile-title>
                        <v-list-tile-sub-title>Require password for purchase or use password to restrict purchase</v-list-tile-sub-title>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile avatar>
                    <v-list-tile-content>
                        <v-list-tile-title>手机号</v-list-tile-title>
                        <v-list-tile-sub-title>Require password for purchase or use password to restrict purchase</v-list-tile-sub-title>
                    </v-list-tile-content>
                </v-list-tile>
            </v-list>
            <v-divider></v-divider>
            <v-list three-line subheader>
                <v-subheader>偏好设置</v-subheader>
                <v-list-tile avatar>
                    <v-list-tile-action>
                        <v-checkbox v-model="notifications"></v-checkbox>
                    </v-list-tile-action>
                    <v-list-tile-content>
                        <v-list-tile-title>主题颜色</v-list-tile-title>
                        <v-list-tile-sub-title>Notify me about updates to apps or games that I downloaded</v-list-tile-sub-title>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile avatar>
                    <v-list-tile-action>
                        <v-checkbox v-model="widgets"></v-checkbox>
                    </v-list-tile-action>
                    <v-list-tile-content>
                        <v-list-tile-title>Auto-add widgets</v-list-tile-title>
                        <v-list-tile-sub-title>Automatically add home screen widgets</v-list-tile-sub-title>
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
        valid: true,
        name: '',
        nameRules: [
            v => !!v || '用户名不能为空',
            v => (v && v.length <= 10) || '用户名不能超过10个字符'
        ],
        password: '',
        passwordRules: [
            v => !!v || '密码不能为空',
            v => (v && v.length < 4) || '密码必须4位以上'
        ],
        rePassword: '',
        rePasswordRules: [
            v => !!v || '请确认您的密码',
            v => (v && v.length < 4) || '密码必须4位以上'
        ],
        email: '',
        emailRules: [
            v => !!v || '邮箱不能为空',
            v => /.+@.+/.test(v) || '无效E-mail'
        ],
        phone: '',
        phoneRules: [

        ],
        select: null,
        items: [
            'Item 1',
            'Item 2',
            'Item 3',
            'Item 4'
        ],
        checkbox: false
    }),
    computed: {
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        },
    },
    methods: {
        validate() {
            if (this.$refs.form.validate()) {
                this.snackbar = true
            }
        },
        reset() {
            this.$refs.form.reset()
        },
        resetValidation() {
            this.$refs.form.resetValidation()
        }
    }
}

</script>
<style>
</style>
