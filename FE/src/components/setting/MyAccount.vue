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
                    <v-btn dark flat @click="handleSave">保存</v-btn>
                </v-toolbar-items>
            </v-toolbar>
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
                        <v-text-field v-model="identityCopy.RealName" label="用户名" placeholder="姓名" hint="真实姓名，非登录帐号" persistent-hint></v-text-field>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile avatar>
                    <v-list-tile-content>
                        <v-text-field v-model="identityCopy.Mobile" label="联系方式" placeholder="电话" hint="手机或固定电话号码" persistent-hint></v-text-field>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile avatar>
                    <v-list-tile-content>
                        <v-text-field v-model="identityCopy.Password" placeholder="Password" type="password" label="登录密码" hint="如需修改密码请输入新的密码，不输入或保持为空则原密码不变" persistent-hint></v-text-field>
                    </v-list-tile-content>
                </v-list-tile>
            </v-list>
            <v-divider></v-divider>
            <v-list three-line subheader>
                <v-subheader>偏好设置</v-subheader>
                <v-list-tile avatar>
                    <v-list-tile-action>
                        <v-icon large>color_lens</v-icon>
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
        identityCopy:{},
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
            set(v){
                this.$store.commit('userLogin', v)
            }
        }
    },
    methods: {
        handleCancel() {
            this.dialog = false
        },
        handleSave() {
            //Call API
            this.identity = this.identityCopy
            this.dialog = false
        },
    },
    mounted(){
        this.identityCopy = this.util.objCopy(this.identity)
    },
    watch:{
        dialog(v,ov){
            if(v){
                this.identityCopy = this.util.objCopy(this.identity)
            }
        }
    }
}

</script>
<style>
</style>
