// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import Vuex from 'vuex'
import store from './vuex/store'
import Vuetify from 'vuetify'
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
	template: '<App/>',
	components: { App }

})

router.beforeEach((to, from, next) => { //beforeEach是router的钩子函数，在进入路由前执行
	if (to.meta.title) { //判断是否有标题
		document.title = "Fine Work - " + to.meta.title
	}
	next() //执行进入路由，如果不写就不会进入目标页
})

