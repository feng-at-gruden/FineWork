<template>
    <v-container grid-list-xl>
        <v-layout row wrap>
            <v-flex lg4 md4 sm6 xs12 v-for="p in projects">
                <ProjectCard :project="p" :animIn="animationIn" :animOut="'animated tada'"></ProjectCard>
            </v-flex>
        </v-layout>
    </v-container>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import ProjectCard from '../ui/ProjectCard'

export default {
    extends: BasePage,
    name: 'ProjectList',
    components: { ProjectCard },
    data() {
        return {
            projects: [],            
        }
    },
    computed:{
        animationIn(){
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
        }
    },
    created() {
        this.loadPorjects()
    }
}

</script>
<style>
</style>
