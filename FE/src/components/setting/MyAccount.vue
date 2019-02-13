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
                        <v-list-tile-title>登录帐号: Admin</v-list-tile-title>
                        <v-list-tile-sub-title>用户登录帐号不可更改。</v-list-tile-sub-title>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile avatar>
                    <v-list-tile-content>
                        <v-text-field value="guof" label="用户名" hint="非登录帐号" persistent-hint></v-text-field>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile avatar>
                    <v-list-tile-content>
                        <v-list-tile-title>登录密码</v-list-tile-title>
                        <v-text-field value="guof"   persistent-hint></v-text-field>
                        <v-list-tile-sub-title>如需修改登录密码请输入新的密码，不输入或保持为空则原密码不改变。</v-list-tile-sub-title>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile avatar>
                    <v-list-tile-content>
                        <v-list-tile-title>联系方式</v-list-tile-title>
                        <v-list-tile-sub-title>Require password for purchase or use password to restrict purchase</v-list-tile-sub-title>
                    </v-list-tile-content>
                </v-list-tile>
            </v-list>
            <v-divider></v-divider>
            <v-list three-line subheader>
                <v-subheader>偏好设置</v-subheader>
                <v-list-tile avatar>
                    <v-list-tile-action>
                        <v-checkbox ></v-checkbox>
                    </v-list-tile-action>
                    <v-list-tile-content>
                        <v-list-tile-title>主题颜色</v-list-tile-title>
                        <v-list-tile-sub-title>Notify me about updates to apps or games that I downloaded</v-list-tile-sub-title>
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
        user:{}
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
                
            }
        },
    }
}

</script>
<style>
</style>
