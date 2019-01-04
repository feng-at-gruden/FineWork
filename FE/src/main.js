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
import 'vuetify/dist/vuetify.min.css'
import './assets/css/site.css'

Vue.use(Vuex)
Vue.use(Vuetify)

Vue.config.productionTip = false

/* eslint-disable no-new */
window.app = new Vue({

    el: '#app',
    router,
    store,
    auth,
    resource,
    template: '<App/>',
    components: { App }

})

router.beforeEach((to, from, next) => {
    if (to.meta.title) {
        document.title = "Fine Work - " + to.meta.title
    }
    next()
})
