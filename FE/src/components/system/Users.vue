<template>
    <v-layout row wrap>
        <v-flex lg12 md12>
            <v-card class="task-filter-box">
                <v-form lazy-validation ref="searchUserForm">
                    <v-layout wrap row>
                        <v-flex xs12 md8 pa-3 class="keyword" style="margin-top: -10px;">
                            <v-text-field v-model="keyword" label="用户名" append-icon="search" @keydown.enter="handleSearchClick"></v-text-field>
                            <v-text-field style="display: none;"></v-text-field>
                        </v-flex>
                        <v-flex xs12 md4 pa-3 class="keyword button-box">
                            <v-btn @click="handleResetClick">清空</v-btn>
                            <v-btn color="primary" @click="handleSearchClick" autofocus>查找</v-btn>
                        </v-flex>
                    </v-layout>
                </v-form>
            </v-card>
        </v-flex>
        <v-flex xs12 style="padding-top:25px;">
            <v-data-table :headers="headers" :items="filteredUsers" class="elevation-1">
                <template slot="items" slot-scope="props">
                    <td class="text-no-wrap">{{ props.item.UserName }}</td>
                    <td class="text-xs-center text-no-wrap task-date">{{ props.item.RealName}}</td>
                    <td class="text-xs-center text-no-wrap task-date">{{ props.item.Mobile}}</td>
                    <td class="text-xs-center text-no-wrap task-date">{{ props.item.LastLogin}}</td>
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
        <!-- -->
        <v-snackbar v-model="snackbar.open" :color="snackbar.color" multi-line vertical bottom right>
            {{snackbar.message}}
            <v-btn dark flat @click="snackbar.open = false">确定</v-btn>
        </v-snackbar>
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
            snackbar: { open: false, message: '', color: '' },
            headers: [{
                    text: '账号',
                    align: 'left',
                    value: 'UserName'
                },
                { text: '用户名', value: 'RealName', align: 'center' },
                { text: '联系方式', value: 'Mobile', align: 'center' },
                { text: '登录日期', value: 'LastUpdate', align: 'center' },
                { text: '操作', align: 'center', sortable: false, },
            ],
            allUsers: []
        }
    },
    computed: {
        addBtnCss() {
            return this.util.IsPC() ? 'add-user-btn' : 'add-user-btn-mobile'
        },
    },
    methods: {
        updateFilteredUsers() {
            var k = this.keyword.trim().toLowerCase()
            if (k.length > 0) {
                this.filteredUsers = this.allUsers.filter(t => t.UserName.toLowerCase().indexOf(k) >= 0 || t.RealName.toLowerCase().indexOf(k) >= 0 || t.Mobile.toLowerCase().indexOf(k) >= 0)
            } else {
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
            u.Password = "******"
            this.userToEdit = u//this.util.objCopy(u)
            this.openEditUserDialog = true
        },
        deleteItem(u) {
            this.userToDelete = u
            this.openDeleteUserDialog = true
        },
        handleUserAdded(u) {
            this.showSnackbar("系统帐户添加成功", 'success')
            this.allUsers.push(u)
            this.updateFilteredUsers()
        },
        handleUserUpdate(u) {
            for (var i = 0; i < this.allUsers.length; i++) {
                if (this.allUsers[i].Id == u.Id) {
                    this.allUsers[i] = u
                    break
                }
            }
            this.updateFilteredUsers()
            this.showSnackbar("系统帐户修改成功", 'success')
        },
        handleUserDeleted(u) {
            var index = -1
            for (var i = 0; i < this.allUsers.length; i++) {
                if (this.allUsers[i].Id == u.Id) {
                    index = i
                    break
                }
            }
            if (index > -1) {
                this.allUsers.splice(index, 1)
                this.updateFilteredUsers()
                this.showSnackbar("系统帐户已删除", 'success')
            }
        },
        showSnackbar(msg, color) {
            this.snackbar.message = msg
            this.snackbar.color = color
            this.snackbar.open = true
        },
        loadUsers() {
            // Call Ajax
            this.$http.get(this.config.API_URL + '/User/List').then(function(res) {
                this.allUsers = JSON.parse(res.bodyText)
                this.updateFilteredUsers()
            })
        }
    },
    mounted() {
        //Load user data from API
        this.loadUsers()
    }

}

</script>
<style scoped>
</style>
