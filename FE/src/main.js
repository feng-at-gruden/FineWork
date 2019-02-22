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
//import 'material-design-icons-iconfont/dist/material-design-icons.css'
import './assets/css/site.css'


var themeIndex = localStorage.getItem("Theme") ? parseInt(localStorage.getItem("Theme")) : 0
var theme = config.Themes[themeIndex]

Vue.config.productionTip = false
Vue.use(Vuex)
Vue.use(Vuetify, { theme })

Vue.config.productionTip = false

Vue.http.interceptors.push(function(request, next) {
    /*
    if(this.$route.requiresAuth && !this.auth.checkIsLogin(this.$store.state)){
        this.$router.replace(this.$route.fullPath)
        return
    }*/
    var token = localStorage.getItem("Token")
    if (token && request.url.indexOf('Token') < 0) {
        request.headers.set('Content-Type', 'application/json; charset=utf-8')
        request.headers.set('auth', token + "")
        request.headers.set('Access-Control-Allow-Origin', '*')
    }
    next(function(response) {
        if (response.status === 401 && response.url.indexOf('Token') < 0) {
            localStorage.removeItem("Token")
            //this.$router.replace('/login' + '?returnUrl=' + this.$route.path)
            //console.log('token expired', this.$route.fullPath)
            //this.$router.replace(this.$route.fullPath)
            this.$router.replace('/login')
            //TODO to check
        }
    });
});

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
    beforeCreate() {
        Vue.prototype.eventBus = this
    }
})
window.app = app

router.beforeEach((to, from, next) => {

    /*
    console.log('here to check', to)
    debugger
    if(to.meta.requiresAuth && !window.app.auth.checkIsLogin()){
        console.log('not login', to.path)
        window.app.$router.replace('/login' + '?returnUrl=' + to.path)
    }*/

    if (to.meta.title) {
        document.title = config.APP_NAME + " - " + to.meta.title
    }
    if (to.meta.fullWidth) {
        //app.$store.commit('openDrawer', false)
    }
    if (to.meta.autoLoading) {
        //app.$store.commit('loading', true)
    }
    next()
})
