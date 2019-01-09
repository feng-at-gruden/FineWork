import Vue from 'vue'
import Router from 'vue-router'


import Login from '@/components/Login'
import Main from '@/components/Main'
import Dashboard from '@/components/Dashboard'
import CreateProject from '@/components/project/Create'
import ProjectList from '@/components/project/List'
import ProjectDetail from '@/components/project/Detail'
import PhasePlan from '@/components/plan/Phase'
import MyAccount from '@/components/setting/MyAccount'


Vue.use(Router)

export default new Router({
    routes: [{
            path: '/Login',
            name: 'Login',
            meta: { requiresAuth: false, level: 1, title: "用户登录", },
            component: Login
        },
        {
            path: '/',
            redirect: '/Dashboard',
            meta: { requiresAuth: true, level: 1, title: "建筑施工项目进度跟踪系统", },
            component: Main,
        },
        {
            path: '/',
            component: Main,
            children: [{
                path: 'Dashboard',
                name: 'Dashboard',
                meta: { requiresAuth: true, level: 2, title: "建筑施工项目进度跟踪系统", },
                component: Dashboard
            }]
        },
        {
            path: '/Project',
            component: Main,
            children: [{
                    path: 'Create',
                    name: 'CreateProject',
                    meta: { requiresAuth: true, level: 2, title: "新建工程项目", },
                    component: CreateProject
                },
                {
                    path: 'List',
                    name: 'ProjectList',
                    meta: { requiresAuth: true, level: 2, title: "工程一览" },
                    component: ProjectList
                },
                {
                    path: ':id',
                    name: 'ProjectDetail',
                    meta: { requiresAuth: true, level: 2, title: "工程详情", fullWidth: true, autoLoading: true },
                    component: ProjectDetail
                },
            ]
        },
        {
            path: '/Plan',
            component: Main,
            children: [
                {
                    path: ':id',
                    name: 'Phase',
                    meta: { requiresAuth: true, level: 2, title: "阶段计划", fullWidth: true, autoLoading: true },
                    component: PhasePlan
                },
            ]
        },
        {
            path: '/',
            component: Main,
            children: [{
                path: '/Setting/MyAccount',
                name: 'MyAccount',
                meta: { requiresAuth: true, level: 2, title: "个人设置", },
                component: MyAccount
            }]
        },

    ]

})
