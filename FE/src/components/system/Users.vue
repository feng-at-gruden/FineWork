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
                    <td class="text-no-wrap">{{ props.item.username }}</td>
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
        <CreateUserDialog :open="openCreateUserDialog" @close="openCreateUserDialog=false" @save="handleUserAdded"></CreateUserDialog>
        <!--新增用户对话框-->
        <EditUserDialog :open="openEditUserDialog" @close="openEditUserDialog=false" @save="handleUserUpdate" :user="userToEdit"></EditUserDialog>
        <!--删除用户对话框-->
        <DeleteUserDialog :open="openDeleteUserDialog" @close="openDeleteUserDialog=false" @delete="handleUserDeleted" :user="userToDelete"></DeleteUserDialog>
    </v-layout>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import CreateUserDialog from './CreateUserDialog'
import EditUserDialog from './EditUserDialog'
import DeleteUserDialog from './DeleteUserDialog'

export default {
    extends: BasePage,
    name: 'Users',
    components: { CreateUserDialog, EditUserDialog, DeleteUserDialog },
    data() {
        return {
            keyword: '',
            filteredUsers: [],
            openCreateUserDialog: false,
            openEditUserDialog: false,
            openDeleteUserDialog: false,
            userToDelete: {},
            userToEdit: {},
            headers: [{
                    text: '账号',
                    align: 'left',
                    value: 'username'
                },
                { text: '用户名', value: 'realname', align: 'center' },
                { text: '联系方式', value: 'mobile', align: 'center' },
                { text: '登录日期', value: 'last_login', align: 'center' },
                { text: '操作', value: 'actual_start', align: 'center', sortable: false, },
            ],
            dateToStr: gantt.date.date_to_str("%Y-%m-%d"),
            allUsers: [
                { id: 1, username: 'admin1', realname: '郭德纲', mobile:'11000000000', last_login: '2019-02-10' },
                { id: 2, username: 'admin2', realname: '郭德纲', mobile:'12000000000', last_login: '2019-02-10' },
                { id: 3, username: 'admin3', realname: '郭德纲', mobile:'13000000000', last_login: '2019-02-10' },
                { id: 4, username: 'admin4', realname: '郭德纲', mobile:'14000000000', last_login: '2019-02-10' },
                { id: 5, username: 'admin5', realname: '郭德纲', mobile:'15000000000', last_login: '2019-02-10' },
                { id: 6, username: 'admin6', realname: '郭德纲', mobile:'16000000000', last_login: '2019-02-10' },
                { id: 7, username: 'admin7', realname: '郭德纲', mobile:'17000000000', last_login: '2019-02-10' },
                { id: 8, username: 'admin8', realname: '郭德纲', mobile:'18000000000', last_login: '2019-02-10' },
                
            ]
        }
    },
    computed:{
    	addBtnCss() {
            return this.util.IsPC() ? 'add-user-btn' : 'add-user-btn-mobile'
        },
    },
    methods: {
        updateFilteredUsers(){
            var k = this.keyword.trim().toLowerCase()
            if(k!='')
            {
                this.filteredUsers = this.allUsers.filter(t=>t.username.toLowerCase().indexOf(k)>=0 || t.realname.toLowerCase().indexOf(k)>=0 || t.mobile.toLowerCase().indexOf(k)>=0)
            }else{
                this.filteredUsers = this.allUsers
            }
        },
        handleResetClick() {
            this.keyword = ''
            this.updateFilteredUsers()
        },
        handleSearchClick() {
            this.updateFilteredUsers()
        },
        editItem(u) {
            this.userToEdit = u
            this.openEditUserDialog = true
        },
        deleteItem(u) {
            this.userToDelete = u
            this.openDeleteUserDialog = true
        },
        handleUserAdded(u){
            this.allUsers.push(u)
            this.updateFilteredUsers()
        },
        handleUserUpdate(u){
            for(var i=0;i<this.allUsers.length;i++)
            {
                if(this.allUsers[i].id==u.id)
                {
                    this.allUsers[i] = u
                    break
                }
            }
            this.updateFilteredUsers()
        },
        handleUserDeleted(u){
            var index=-1
            for(var i=0;i<this.allUsers.length;i++)
            {
                if(this.allUsers[i].id==u.id)
                {
                    index = i
                    break
                }
            }
            if(index>-1){
                this.allUsers.splice(index,1)
                this.updateFilteredUsers()
            }
        }
    },
    mounted() {
        //Load user data from API
        this.updateFilteredUsers()
    }

}

</script>
<style scoped>
</style>
