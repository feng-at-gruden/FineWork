<template>
    <v-container grid-list-xl class="project-list-container">
        <ProjectFilter @filterChange="handleFilterChange" :layout="layout"></ProjectFilter>
        <v-layout row wrap>            
            <v-flex lg4 md4 sm6 xs12 v-for="p in projects" :key="p.id">
                <ProjectCard :project="p" :animIn="'animated fadeIn'" :animOut="'animated pulse'"></ProjectCard>
            </v-flex>
        </v-layout>
        <div class="text-xs-center">
            <v-pagination v-model="page" :total-visible="7" :length="4" circle color="primary"></v-pagination>
        </div>
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
                this.projects = JSON.parse(res.bodyText)
            }, function(res) {

            })
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
