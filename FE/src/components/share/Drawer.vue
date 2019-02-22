<template>
    <v-navigation-drawer v-model="drawer" @input="handleInput" class="my-drawer grey lighten-4" clipped fixed app>
        <v-list dense class="grey lighten-4">
            <template v-for="(item, i) in items">
                <v-layout row v-if="item.heading && haveThePermission(item)" align-center :key="i">
                    <v-flex xs6>
                        <v-subheader v-if="item.heading" class="drawer-sub-heading">
                            {{ item.heading }}
                        </v-subheader>
                    </v-flex>
                    <v-flex xs6 class="text-xs-right">
                        <!--<v-btn small flat>edit</v-btn>-->
                    </v-flex>
                </v-layout>
                <v-divider dark v-else-if="item.divider" class="my-3" :key="i"></v-divider>
                <template v-else-if="item.title=='PROJECT-DROPDOWN'" v-show="openProjects.length>0">
                    <v-list-tile :key="i" v-show="openProjects.length>0">
                        <v-list-tile-content class="drawer-projects-box">
                            <v-select :items="openProjects" v-model="selectedProjectId" @change="handleProjectDropdownChange" label="在建项目" hide-details prepend-icon="map" single-line item-text="Name" item-value="Id" class="project-select"></v-select>
                        </v-list-tile-content>
                    </v-list-tile>
                    <v-divider dark class="my-3" v-show="openProjects.length>0"></v-divider>
                </template>
                <template v-else-if="item.title=='PHASE-DROPDOWN'" v-show="projectPhases.length>0">
                    <v-list-tile :key="i" v-show="projectPhases.length>0">
                        <v-list-tile-content class="drawer-phase-box">
                            <v-select :items="projectPhases" v-model="selectedPhaseId" @change="handlePhaseDropdownChange" label="阶段计划" dense hide-details prepend-icon="playlist_add_check" single-line item-text="Name" item-value="Id" class="phase-select"></v-select>
                        </v-list-tile-content>
                    </v-list-tile>
                </template>
                <v-list-tile :key="i" v-else-if="haveThePermission(item)" @click="goto(item)">
                    <v-list-tile-action>
                        <v-icon>{{ item.icon }}</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                        <v-list-tile-title class="text-darken-3">
                            {{ item.title }}
                        </v-list-tile-title>
                    </v-list-tile-content>
                </v-list-tile>
            </template>
        </v-list>
    </v-navigation-drawer>
</template>
<script>
import auth from '../../assets/js/Auth'
import config from '../../assets/js/Config'
export default {
    name: 'Drawer',
    props: [],
    data() {
        return {
            auth,
            config,
            mini: false,
            selectedProjectId: 0,
            selectedPhaseId: 0,
            projectSelectedFromOuter: false,
            phaseSelectedFromOuter: false,
            items: [
                { title: 'PROJECT-DROPDOWN', link: '/', icon: 'home' },
                { heading: '项目管理' },
                { title: '新建项目', link: '/Project/Create', icon: 'library_add', permission:'project-management' },
                { title: '项目一览', link: '/Project/List', icon: 'location_city' },
                { divider: true },
                { heading: '计划管理' },
                { title: '项目计划', link: '/Project/', icon: 'subject' },
                { title: 'PHASE-DROPDOWN', link: '/Phase/Plan', icon: 'playlist_add_check' },
                { divider: true },
                { heading: '进度管理' },
                { title: '进度汇报', link: '/Progress/Report', icon: 'assignment' },
                { divider: true },
                { heading: '系统管理', permission:'system-management' },
                { title: '用户管理', link: '/System/Users', icon: 'supervisor_account', permission:'system-management' },
            ],
            right: null
        }
    },
    computed: {
        userName() {
            return this.$store.state.identity.realname
        },
        drawer: {
            get() {
                return this.$store.state.drawer
            },
            set(value) {
                //this.$store.commit('openDrawer')
            }
        },
        openProjects() {
            return this.$store.state.allProjects.filter(t => t.Status == this.config.ProjectStatus[1].value)
        },
        projectPhases() {
            return this.$store.state.projectPhases
        },
        identity() {
            if (this.$store.state.identity != null) {
                return this.$store.state.identity
            } else {
                return JSON.parse(localStorage.getItem("Identity"))
            }
        }
    },
    methods: {
        goto(item) {
            if (item.link == 'logout') {
                this.auth.logout()
            } else if (item.title == '项目计划') {
                if (this.selectedProjectId)
                    this.$router.push(item.link + this.selectedProjectId)
            } else {
                this.$router.push(item.link)
            }
        },
        handleInput(v) {
            this.$store.commit('openDrawer', v)
        },
        handleProjectDropdownChange(v) {
            this.projectSelectedFromOuter = false
        },
        handlePhaseDropdownChange(v) {
            this.phaseSelectedFromOuter = false
        },
        haveThePermission(item) {
            return this.auth.checkPermission(item.permission, this.identity)
        }
    },
    watch: {
        selectedProjectId(v, ov) {
            if (v != ov) {
                if (this.openProjects.filter(t => t.Id == v).length > 0) {
                    if (!this.projectSelectedFromOuter) {
                        //通过下拉列表选择的
                        this.$router.push('/Project/' + v)
                        this.$store.commit('updateSelectedPorject', v)
                    }
                }
            }
        },
        selectedPhaseId(v, ov) {
            if (v != ov) {
                if (this.projectPhases.filter(t => t.Id == v).length > 0) {
                    if (!this.phaseSelectedFromOuter) {
                        this.$router.push('/Phase/' + v)
                        this.$store.commit('updateSelectedPhase', v)
                    }
                }
            }
        },
    },
    mounted() {
        this.eventBus.$on('selectedProjectChanged', v => {
            if (this.selectedProjectId != v) {
                this.projectSelectedFromOuter = true
                this.selectedProjectId = parseInt(v + '')
            }
        })
        this.eventBus.$on('selectedPhaseChanged', v => {
            if (this.selectedPhaseId != v) {
                this.phaseSelectedFromOuter = true
                this.selectedPhaseId = parseInt(v + '')
            }
        })
    },
    beforeDestroy() {
        this.eventBus.$off("selectedPhaseChanged")
        this.eventBus.$off("selectedProjectChanged")
    }
}

</script>
<style>
.navigation-drawer__border {
    display: none;
}

.my-drawer {
    padding-top: 15px;
}

.drawer-projects-box {
    margin-bottom: 10px;
}
.drawer-projects-box .v-input__slot {
    height: 41px;
}

.drawer-projects-box .v-input {
    align-items: center
}

.drawer-phase-box {
    margin-top: 1px;
}


.drawer-phase-box .v-input__slot {
    height: 41px;
}

.drawer-phase-box .v-text-field {
    padding-top: 0px;
    margin-top: 0px;
}

.drawer-phase-box .v-select-list,
.drawer-phase-box .v-select__selection--comma,
.drawer-phase-box .v-label {
    font-size: 13px;
    text-align: center;
    margin-left: 23px;
    /*margin-top: 4px;*/
    color: rgba(0, 0, 0, .87) !important;
}

.drawer-phase-box .v-list__tile__title {
    font-size: 13px;
}

.drawer-phase-box .v-input__append-outer,
.drawer-phase-box .v-input__prepend-outer {
    margin-top: 7px;
}

.project-select {
    width: 100%;
    margin-top: 0px !important;
    padding-top: 8px !important;
}

.phase-select {
    font-size: 13px;
    width: 100%;
}

.drawer-sub-heading {
    margin-top: -12px;
}

</style>
