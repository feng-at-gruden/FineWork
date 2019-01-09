<template>
    <v-container grid-list-xl class="project-list-container">
        <v-layout justify-end row>
            <v-flex sm2 xs5>
                <v-btn-toggle v-model="toggle_one" mandatory>
                    <v-btn flat>
                        <v-icon>view_module</v-icon>
                    </v-btn>
                    <v-btn flat>
                        <v-icon>view_list</v-icon>
                    </v-btn>
                    <v-btn flat>
                        <v-icon>vertical_split</v-icon>
                    </v-btn>
                </v-btn-toggle>
            </v-flex>
        </v-layout>
        <v-layout row wrap>            
            <v-flex lg4 md4 sm6 xs12 v-for="p in projects">
                <ProjectCard :project="p" :animIn="animationIn" :animOut="'animated tada'"></ProjectCard>
            </v-flex>
        </v-layout>
        <div class="text-xs-center">
            <v-pagination v-model="page" :total-visible="7" :length="4" circle></v-pagination>
        </div>
        <v-btn fab bottom right :color="config.Theme" dark fixed @click.stop="dialog = !dialog">
            <v-icon>add</v-icon>
        </v-btn>
        <ProjectInfoDialog :dialog="dialog" @saveClick="dialogSaveClick" @cancelClick="dialogCancelClick"></ProjectInfoDialog>
    </v-container>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import ProjectCard from '../ui/ProjectCard'
import ProjectInfoDialog from '../ui/ProjectInfoDialog'

export default {
    extends: BasePage,
    name: 'ProjectList',
    components: { ProjectCard, ProjectInfoDialog },
    data() {
        return {
            projects: [],
            page: 2,
            dialog: false,
            toggle_one: 0,
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
