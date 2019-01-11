<template>
    <v-layout justify-center>
        <v-flex xs12 sm8>
            <v-card>
                <v-card-title class="grey lighten-4 py-4 title">
                    个人设置
                </v-card-title>
                <v-container grid-list-sm class="pa-4">
                    <v-layout row wrap>
                        <v-form ref="form" v-model="valid" lazy-validation>
                            <v-flex xs12 align-center justify-space-between>
                                <v-layout align-center>
                                    <v-avatar size="40px" class="mr-3">
                                        <img src="//ssl.gstatic.com/s2/oz/images/sge/grey_silhouette.png" alt="" >
                                    </v-avatar>
                                    <v-text-field v-model="name" :counter="10" :rules="nameRules" label="用户名" required></v-text-field>
                                </v-layout>
                            </v-flex>
                            <v-text-field v-model="password" :rules="passwordRules" label="密码" prepend-icon="security" required></v-text-field>
                            <v-text-field v-model="rePassword" :rules="rePasswordRules" label="确认密码" prepend-icon="security" required></v-text-field>
                            <v-text-field v-model="email" :rules="emailRules" label="E-mail" prepend-icon="mail"></v-text-field>
                            <v-text-field v-model="phone" :rules="phoneRules" label="电话" type="tel" prepend-icon="phone"></v-text-field>
                            <v-select v-model="select" :items="items" :rules="[v => !!v || 'Item is required']" label="角色" prepend-icon="perm_identity" required></v-select>
                            <v-checkbox v-model="checkbox" :rules="[v => !!v || 'You must agree to continue!']" label="Do you agree?" required></v-checkbox>
                            <v-btn :disabled="!valid" color="success" @click="validate">
                                Validate
                            </v-btn>
                            <v-btn color="error" @click="reset">
                                Reset Form
                            </v-btn>
                            <v-btn color="warning" @click="resetValidation">
                                Reset Validation
                            </v-btn>
                        </v-form>
                    </v-layout>
                </v-container>
            </v-card>
        </v-flex>
    </v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
export default {
    extends: BasePage,
    name: 'MyAccount',
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
        phoneRules:[

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
