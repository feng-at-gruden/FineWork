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


Vue.http.interceptors.push(function(request, next) {
    var token = localStorage.getItem("token")
    if (token && request.url.indexOf('token')<0) {
        request.headers.set('Content-Type', 'application/json; charset=utf-8')
        request.headers.set('auth', token)
    }
    next(function(response) {
        if (response.status === 401 && response.url.indexOf('token')<0) {            
            this.$router.replace('/login' + '?returnUrl=' + this.$route.path)
        }
    });
});


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
