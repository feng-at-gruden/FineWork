import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/components/Login'
import Dashboard from '@/components/Dashboard'
import NewProject from '@/components/project/Create'
import ProjectList from '@/components/project/List'

Vue.use(Router)

export default new Router({
    routes: [{
            path: '/',
            name: 'Dashboard',
            level: 1,
            component: Dashboard
        },
        {
            path: '/Login',
            name: 'Login',
            level: 1,
            component: Login
        },
        {
            path: '/Project/Create',
            name: 'NewProject',
            level: 2,
            component: NewProject
        },
        {
            path: '/Project/List',
            name: 'ProjectList',
            level: 2,
            component: ProjectList
        },
    ]
})
