import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/components/Login'
import Dashboard from '@/components/Dashboard'

Vue.use(Router)

export default new Router({
	routes: [{
			path: '/',
			name: 'Dashboard',
			component: Dashboard
		},
		{
			path: '/Login',
			name: 'Login',
			component: Login
		},
	]
})
