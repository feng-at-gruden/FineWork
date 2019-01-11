<template>
    <v-dialog v-model="dialogOpen" lazy content-class="half-right-dialog" hide-overlay transition="slide-x-reverse-transition">
        <v-card height="100%">
            <v-card-title class="grey lighten-4 py-4 title">
                项目信息
            </v-card-title>
            <v-container grid-list-sm class="pa-4">
                <v-layout row wrap>
                    <v-flex xs12 align-center justify-space-between>
                        <v-layout align-center>
                            <v-avatar size="40px" class="mr-3">
                                <img src="//ssl.gstatic.com/s2/oz/images/sge/grey_silhouette.png" alt="" >
                            </v-avatar>
                            <v-text-field placeholder="姓名"></v-text-field>
                        </v-layout>
                    </v-flex>
                    <v-flex xs6>
                        <v-text-field prepend-icon="business" placeholder="Company"></v-text-field>
                    </v-flex>
                    <v-flex xs6>
                        <v-text-field placeholder="Job title"></v-text-field>
                    </v-flex>
                    
                    <v-flex xs12>
                        <v-text-field prepend-icon="notes" placeholder="Notes"></v-text-field>
                    </v-flex>
                </v-layout>
            </v-container>
            <v-card-actions>
                <v-btn flat color="primary">More</v-btn>
                <v-spacer></v-spacer>
                <v-btn flat color="primary" @click="handleCancelClick">Cancel</v-btn>
                <v-btn flat @click="handleSaveClick">Save</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>
<script>
export default {
    name: 'ProjectInfoDialog',
    props: ['open'],
    data() {
        return {

        }
    },
    computed:{
        dialogOpen:{
            get(){return this.$props.open},
            set(v){
                this.$emit('dialogClose')
            }
        }
    },
    methods: {
        handleCancelClick() {
            this.dialogOpen = false
        },
        handleSaveClick() {
            this.dialogOpen = false
        }
    }
}

</script>
<style>
.half-right-dialog {
    width: 480px;
    right: 0;
    height: auto;
    position: fixed;
    overflow-y: auto;
    top: 65px;
    margin:0;
    bottom: 0px;
}

.dialog-left-transition {}

</style>
