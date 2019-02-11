<template>
    <v-layout row wrap>
        <v-flex lg12 md12>
            <v-card class="task-filter-box">
                <v-form lazy-validation ref="searchUserForm">
                    <v-layout wrap row>
                        <v-flex xs12 md8 pa-3 class="keyword" style="margin-top: -10px;">
                            <v-text-field v-model="keyword" label="用户名" append-icon="search"></v-text-field>
                        </v-flex>
                        <v-flex xs12 md4 pa-3 class="keyword button-box">
                            <v-btn @click="handleResetClick">清空</v-btn>
                            <v-btn color="primary" @click="handleSearchClick">查找</v-btn>
                        </v-flex>
                    </v-layout>
                </v-form>
            </v-card>
        </v-flex>
        <v-flex xs12 style="padding-top:25px;">
            <v-data-table :headers="headers" :items="filteredUsers" class="elevation-1">
                <template slot="items" slot-scope="props">
                    <td class="text-no-wrap" @click="openUserDialog(props.item)">{{ props.item.username }}</td>
                    <td class="text-xs-center text-no-wrap task-date">{{ props.item.realname}}</td>
                    <td class="text-xs-center text-no-wrap task-date">{{ props.item.mobile}}</td>
                    <td class="text-xs-center text-no-wrap task-date">{{ props.item.last_login}}</td>
                    <td class="justify-center layout px-0">
                        <v-icon small class="mr-2" @click="editItem(props.item)">
                            edit
                        </v-icon>
                        <v-icon small @click="deleteItem(props.item)">
                            delete
                        </v-icon>
                    </td>
                </template>
            </v-data-table>
        </v-flex>
        <v-btn fixed small dark fab bottom right color="primary" @click="openCreateUserDialog=true" :class="addBtnCss">
            <v-icon>add</v-icon>
        </v-btn>
        <!--新增用户对话框-->
        <CreateUserDialog :open="openCreateUserDialog" @close="openCreateUserDialog=false"></CreateUserDialog>
    </v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import CreateUserDialog from './CreateUserDialog'

export default {
    extends: BasePage,
    name: 'Users',
    components: { CreateUserDialog },
    data() {
        return {
            keyword: '',
            filteredUsers: [],
            allUsers: [],
            openCreateUserDialog: false,
            headers: [{
                    text: '账号',
                    align: 'left',
                    sortable: false,
                    value: 'username'
                },
                { text: '用户名', value: 'realname', align: 'center' },
                { text: '联系方式', value: 'mobile', align: 'center' },
                { text: '登录日期', value: 'last_login', align: 'center' },
                { text: '操作', value: 'actual_start', align: 'center' },
            ],
            dateToStr: gantt.date.date_to_str("%Y-%m-%d"),
            mockData: [
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 1, username: 'admin', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
            ]
        }
    },
    computed:{
    	addBtnCss() {
            return this.util.IsPC() ? 'add-user-btn' : 'add-user-btn-mobile'
        },
    },
    methods: {
        openUserDialog() {

        },
        handleResetClick() {
            this.keyword = ''

        },
        handleSearchClick() {

        },
        editItem(u) {

        },
        deleteItem(u) {

        }
    },
    mounted() {
        //Load user data from API
        console.log('mounted')
        this.filteredUsers = this.mockData
    }

}

</script>
<style scoped>
</style>
