import Vue from 'vue'
import Router from 'vue-router'


import Login from '@/components/Login'
import Main from '@/components/Main'
import Dashboard from '@/components/Dashboard'
import CreateProject from '@/components/project/Create'
import ProjectList from '@/components/project/List'
import ProjectPlan from '@/components/project/Plan'
import PhasePlan from '@/components/phase/Plan'
import ProgressReport from '@/components/progress/Report'
import Users from '@/components/system/Users'
//import MyAccount from '@/components/setting/MyAccount'


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
            redirect: '/Project/List',
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
                        { icon: 'info_outline', text: '项目信息', }, 
                        /*{ icon: 'timeline', text: '时间轴' }, */
                        /*{ icon: '', text: 'Divider', permission: 'project-management' }, */
                        { icon: 'blur_linear', text: '阶段调整', permission: 'project-management', editing: { icon: 'save', text: '退出编辑'} },
                        { icon: 'delete_forever', text: '删除项目', permission: 'project-management' }, 
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
                name: 'PhasePlan',
                meta: { requiresAuth: true, level: 2, title: "阶段计划", fullWidth: true, autoLoading: true,
                    showOptionMenu: true, 
                    optionMenu: [
                    { icon: 'dns', text: '显示选项', hideOnEditing: true }, 
                    { icon: 'insert_chart_outlined', text: '阶段统计', }, 
                    { icon: 'border_color', text: '计划调整', permission: 'plan-management', editing: { icon: 'save', text: '退出编辑'} },
                    { icon: 'delete_sweep', text: '删除阶段', permission: 'project-management' }, 
                    ] },                 
                component: PhasePlan
            }, ]
        },
        {
            path: '/Progress',
            component: Main,
            children: [{
                path: 'Report',
                name: 'ProgressReport',
                meta: { requiresAuth: true, level: 2, title: "进度汇报", fullWidth: false, autoLoading: false,
                    showOptionMenu: false, },                 
                component: ProgressReport
            }, ]
        },
        {
            path: '/System',
            component: Main,
            children: [{
                path: 'Users',
                name: 'Users',
                meta: { requiresAuth: true, level: 2, title: "用户管理", fullWidth: false, autoLoading: false,
                    showOptionMenu: false, },                 
                component: Users
            }]
        },
        /*
        {
            path: '/Setting/',
            component: Main,
            children: [{
                path: 'MyAccount',
                name: 'MyAccount',
                meta: { requiresAuth: true, level: 2, title: "个人设置", },
                component: MyAccount
            }]
        },
        */
    ]

})
