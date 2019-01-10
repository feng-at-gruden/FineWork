<template>
    <v-container grid-list-xl class="project-list-container">
        <ProjectFilter @filterChange="handleFilterChange" :layout="layout"></ProjectFilter>
        <v-layout row wrap>            
            <v-flex lg4 md4 sm6 xs12 v-for="p in projects">
                <ProjectCard :project="p" :animIn="'animated fadeIn'" :animOut="'animated pulse'"></ProjectCard>
            </v-flex>
        </v-layout>
        <div class="text-xs-center">
            <v-pagination v-model="page" :total-visible="7" :length="4" circle color="primary"></v-pagination>
        </div>
        <v-btn fab bottom right color="primary" dark fixed @click.stop="dialog = !dialog">
            <v-icon>add</v-icon>
        </v-btn>
        <ProjectInfoDialog :dialog="dialog" @saveClick="dialogSaveClick" @cancelClick="dialogCancelClick"></ProjectInfoDialog>
    </v-container>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import ProjectFilter from '../ui/ProjectFilter'
import ProjectCard from '../ui/ProjectCard'
import ProjectInfoDialog from '../ui/ProjectInfoDialog'

export default {
    extends: BasePage,
    name: 'ProjectList',
    components: { ProjectFilter, ProjectCard, ProjectInfoDialog },
    data() {
        return {
            projects: [],
            page: 2,
            dialog: false,
            layout: 0,
        }
    },
    computed: {
        animationIn() {
            return this.util.randomIn()
        },
    },
    methods: {
        loadPorjects() {
            // Call Ajax
            this.$http.get(this.config.API_URL + '/project/list', { emulateJSON: true }).then(function(res) {
                console.log('Loaded project list');
                this.projects = JSON.parse(res.bodyText)
                //this.$store.commit('loading', false)                
            }, function(res) {

            })
        },
        dialogSaveClick(v) {
            console.log('dialogSaveClick', v)
            this.dialog = false
        },
        dialogCancelClick() {
            console.log('dialogCancelClick')
            this.dialog = false
        },
        handleFilterChange(filter){
            console.log(filter)
        }
    },
    created() {
        this.loadPorjects()
    }
}

</script>
<style>
.project-list-container{
    padding-top: 0px;
}
</style>
