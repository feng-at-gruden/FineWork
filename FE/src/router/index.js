import Vue from 'vue'
import Router from 'vue-router'


import Login from '@/components/Login'
import Main from '@/components/Main'
import Dashboard from '@/components/Dashboard'
import CreateProject from '@/components/project/Create'
import ProjectList from '@/components/project/List'
import ProjectPlan from '@/components/project/Plan'
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
                    name: 'ProjectPlan',
                    meta: { requiresAuth: true, level: 2, title: "工程计划", fullWidth: true, autoLoading: true, 
                        showOptionMenu: true, 
                        optionMenu: [
                        { icon: 'info', text: '工程项目信息', }, 
                        { icon: 'timeline', text: '项目时间轴' }, 
                        { icon: '', text: 'Divider' }, 
                        { icon: 'edit', text: '项目计划调整', editing: { icon: 'save', text: '退出编辑模式'} },
                        { icon: 'delete', text: '删除本项目' }, 
                        ] },
                    component: ProjectPlan
                },
            ]
        },
        {
            path: '/Plan',
            component: Main,
            children: [{
                path: ':id',
                name: 'Phase',
                meta: { requiresAuth: true, level: 2, title: "阶段计划", fullWidth: true, autoLoading: true },
                component: PhasePlan
            }, ]
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
