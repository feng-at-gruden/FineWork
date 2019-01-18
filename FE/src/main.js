// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import Vuex from 'vuex'
import store from './vuex/store'
import auth from './assets/js/Auth'
import Vuetify from 'vuetify'
import resource from './resource'
import config from './assets/js/Config'
import 'vuetify/dist/vuetify.min.css'
import './assets/css/site.css'

Vue.use(Vuex)
Vue.use(Vuetify, { theme: config.Theme })

Vue.config.productionTip = false

/* eslint-disable no-new */
const app = new Vue({
    el: '#app',
    router,
    store,
    auth,
    resource,
    config,
    template: '<App/>',
    components: { App },

    computed: {
        token() {
            console.log(this.$store.state.identity)
            return this.$store.state.identity.token
        }
    }

})
window.app = app

/*
Vue.http.interceptors.push(function(request, next) {
    var token = "123123"
    if (token) {
        //不知是Bearer;还是Bearer半角空格，网上两种写法都有。  
        request.headers.set('auth', 'Bearer;' + token);
        //下面这个方法不正确。浏览器控制台或后台服务程序均无法看到传递值  
        //request.headers.Authorization = 'Bearer;' + token;  
    }
    console.log("拦截器输出，请求参数：", request.body ? request.body : request.params);
    next(function(response) {
        console.log("拦截器输出，返回状态：", response.status);
        if (response.status === 401) {
            window.location.href = '../public/login.html';
        }
    });
});
*/

router.beforeEach((to, from, next) => {
    if (to.meta.title) {
        document.title = config.APP_NAME + " " + to.meta.title
    }
    if (to.meta.fullWidth) {
        app.$store.commit('openDrawer', false)
    }
    if (to.meta.autoLoading) {
        //app.$store.commit('loading', true)
    }
    //app.$store.commit('editing', false)
    next()
})
