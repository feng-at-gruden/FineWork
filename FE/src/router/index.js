import Vue from 'vue'
import Router from 'vue-router'


import Login from '@/components/Login'
import Main from '@/components/Main'
import Dashboard from '@/components/Dashboard'
import CreateProject from '@/components/project/Create'
import ProjectList from '@/components/project/List'
import ProjectDetail from '@/components/project/Detail'

Vue.use(Router)

export default new Router({
    routes: [{
            path: '/',
            name: 'Main',
            meta: { requiresAuth: true, level: 1, title: "建筑施工项目进度跟踪系统", },
            component: Main
        },
        {
            path: '/Login',
            name: 'Login',
            meta: { requiresAuth: false, level: 1, title: "用户登录", },
            component: Login
        },
        {
            path: '/Project',
            component: Main,
            children: [{
                    path: 'Create',
                    name: 'CreateProject',
                    meta: { requiresAuth: false, level: 2, title: "新建工程项目", },
                    component: CreateProject
                },
                {
                    path: 'List',
                    name: 'ProjectList',
                    meta: { requiresAuth: false, level: 2, title: "项目一览", },
                    component: ProjectList
                },
                {
                    path: ':id',
                    name: 'ProjectDetail',
                    meta: { requiresAuth: false, level: 2, title: "项目详情", },
                    component: ProjectDetail
                },

            ]
        },

    ]

})
