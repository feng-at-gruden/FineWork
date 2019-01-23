import Vue from 'vue'
import Router from 'vue-router'


import Login from '@/components/Login'
import Main from '@/components/Main'
import Dashboard from '@/components/Dashboard'
import CreateProject from '@/components/project/Create'
import ProjectList from '@/components/project/List'
import ProjectPlan from '@/components/project/Plan'
import PhasePlan from '@/components/phase/Plan'
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
            meta: { requiresAuth: true, level: 1, title: "DASHBOARD", },
            component: Main,
        },
        {
            path: '/',
            component: Main,
            children: [{
                path: 'Dashboard',
                name: 'Dashboard',
                meta: { requiresAuth: true, level: 2, title: "DASHBOARD", },
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
                    meta: { requiresAuth: true, level: 2, title: "项目一览" },
                    component: ProjectList
                },
                {
                    path: ':id',
                    name: 'ProjectPlan',
                    meta: { requiresAuth: true, level: 2, title: "项目计划", fullWidth: true, autoLoading: true, 
                        showOptionMenu: true, 
                        optionMenu: [
                        { icon: 'info', text: '项目信息', }, 
                        { icon: 'timeline', text: '时间轴' }, 
                        { icon: '', text: 'Divider' }, 
                        { icon: 'edit', text: '计划调整', editing: { icon: 'save', text: '退出编辑模式'} },
                        { icon: 'delete', text: '删除项目' }, 
                        ] },
                    component: ProjectPlan
                },
            ]
        },
        {
            path: '/Phase',
            component: Main,
            children: [{
                path: ':id',
                name: 'Plan',
                meta: { requiresAuth: true, level: 2, title: "阶段计划", fullWidth: true, autoLoading: true,
                    showOptionMenu: true, 
                    optionMenu: [
                    { icon: 'edit', text: '阶段计划调整', editing: { icon: 'save', text: '退出编辑模式'} },
                    { icon: 'delete', text: '删除阶段计划' }, 
                    ] },                 
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
