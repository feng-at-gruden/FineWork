<template>
    <v-dialog persistent v-model="dialog" content-class="delete-user-dialog" max-width="290">
        <v-form lazy-validation ref="deleteForm">
            <v-card>
                <v-card-title class="grey lighten-3 title">
                    <v-icon>delete</v-icon>
                    <span>删除确认</span>
                </v-card-title>
                <v-card-text>
                    <span class="delete-project-desc">您确定要删除{{myUser.username}}这个用户吗？</span>
                </v-card-text>
                <v-card-actions class="pa-3">
                    <v-spacer></v-spacer>
                    <v-btn @click="dialog = false">取消</v-btn>
                    <v-btn color="error" @click="handleDeleteClick">删除</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-form>
    </v-dialog>
</template>
<script>
import config from '../../assets/js/Config'
export default {
    name: 'DeleteUserDialog',
    props: ['open','user'],
    data() {
        return {
            config,
        }
    },
    computed: {
        myUser(){
            return this.$props.user
        },
        dialog: {
            get() { return this.$props.open },
            set(v) {
                if (!v) {
                    this.$emit('close')
                }
            }
        },
    },
    methods: {
        handleDeleteClick() {
            //TODO Call API
            //Success
            this.dialog = false
            this.$emit('delete', this.myUser)
        }
    }
}

</script>
<style scoped>
.delete-user-dialog {
    width: 480px;
    height: auto;
    position: fixed;
    overflow-y: auto;
    margin: 0;
}

.delete-project-desc{
    padding-bottom: 15px;
    display: block;
}
</style>