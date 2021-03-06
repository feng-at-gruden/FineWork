<template>
    <v-container grid-list-xl class="project-list-container">
        <ProjectFilter @filterChange="handleFilterChange" :layout="layout"></ProjectFilter>
        <v-layout row wrap>            
            <v-flex lg4 md4 sm6 xs12 v-for="p in displayProjects" :key="p.id">
                <ProjectCard :data="p" :animIn="'animated fadeIn'" :animOut="'animated pulse'" :showBtns="showBtns" @onOpenDialog="handleOpenDialog"></ProjectCard>
            </v-flex>
        </v-layout>
        <div class="text-xs-center">
            <v-pagination v-model="page" :total-visible="7" :length="pageCount" v-if="pageCount>1" circle color="primary"></v-pagination>
        </div>

        <v-btn fixed small dark fab bottom right color="primary" v-if="haveThePermission('project-management')" @click="handleAddBtnClick" :class="addBtnCss">
            <v-icon>add</v-icon>
        </v-btn>

        <!--项目统计信息对话框 -->
        <ProjectStatisticsDialog :open="openProjectStatistics" @close="openProjectStatistics = false" :projectId="dialogData.project.Id"></ProjectStatisticsDialog>

    </v-container>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import ProjectFilter from '../ui/ProjectFilter'
import ProjectCard from '../ui/ProjectCard'
import ProjectInfoDialog from '../ui/ProjectInfoDialog'
import DeleteProjectDialog from '../ui/DeleteProjectDialog'
import ProjectStatisticsDialog from './ProjectStatisticsDialog'

export default {
    extends: BasePage,
    name: 'ProjectList',
    components: { ProjectFilter, ProjectCard, ProjectInfoDialog, DeleteProjectDialog, ProjectStatisticsDialog },
    data() {
        return {
            projects: [],
            filteredProjects:[],
            filter:['在建中'],
            displayProjects:[],
            pageSize: 6,
            pageCount:0,
            page: 0,
            layout: 0,
            openProjectStatistics: false,
            dialogData:{button:0,project:{}},
        }
    },
    computed: {
        animationIn() {
            return this.util.randomIn()
        },
        addBtnCss() {
            return this.util.IsPC() ? 'add-user-btn' : 'add-user-btn-mobile'
        },
        showBtns() {
            if(!this.haveThePermission('project-management')){
                return [true,true,false]
            }else{
                return [true,true,true]
            }
        }
    },
    watch:{
        filter(v, ov){
            this.updateFilteredProjects()
        },
        page(v, ov){
            this.calculatePageDisplay()
        }
    },
    methods: {
        loadPorjects() {
            // Call Ajax
            this.loading = true
            this.$http.get(this.config.API_URL + '/Project/List').then(function(res) {
                this.projects = JSON.parse(res.bodyText)
                this.$store.commit('updateAllProjects', this.projects)
                this.updateFilteredProjects()
                this.loading = false
            }, function(res) {

            })
        },
        handleFilterChange(filter){
            this.filter = filter
        },
        handleAddBtnClick() {
            this.$router.push('/Project/Create')
        },
        haveThePermission(permission) {
            return this.auth.checkPermission(permission, this.identity)
        },
        updateFilteredProjects(){
            if(this.filter.length==0){
                this.filteredProjects = this.projects
            }else{
                this.filteredProjects = this.projects.filter(t=>{
                    var f = false
                    for(var i=0;i<this.filter.length;i++){
                        if(t.Status==this.filter[i])
                            f = true
                    }
                    return f
                })
            }
            this.pageCount = Math.ceil(this.filteredProjects.length / this.pageSize)            
            this.page = 1
            this.calculatePageDisplay()
        },
        calculatePageDisplay(){
            var st = (this.page - 1) * this.pageSize
            var ed = this.page == this.pageCount? this.filteredProjects.length: st + this.pageSize - 1
            this.displayProjects = this.filteredProjects.filter((t, index)=>{return index>=st && index<=ed})
        },
        handleOpenDialog(data) {
            this.dialogData = data
            switch(this.dialogData.button){
                case 0:
                    this.openProjectInfoDialog = true
                    break;
                case 1:
                    this.openProjectStatistics = true
                    break;
                case 2:
                    this.openDeleteProjectDialog = true
                    break;
            }
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
