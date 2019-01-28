<template>
    <v-toolbar color="primary" app fixed clipped-left>
        <v-toolbar-side-icon @click.stop="openDrawer"></v-toolbar-side-icon>
        <v-toolbar-title>
            {{projectName}} {{title}}
            <v-fade-transition mode="in-out">
                <v-icon v-if="editing">edit</v-icon>
            </v-fade-transition>
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-flex xs3 sm3 md2>
            <v-layout justify-end>
                <v-slide-x-reverse-transition>
                    <!-- <v-text-field class="header-search" clearable v-if="showSearch" color="grey darken-4" @keydown.enter="showSearch=false"></v-text-field>-->
                    <v-autocomplete v-model="project" :items="allProjects" item-text="Name" item-value="Id" color="black lighten-4" v-if="showSearch" @blur="showSearch=false" class="header-search" flat hide-details hide-no-data dense>
                        <template slot="item" slot-scope="data">
                            <template v-if="typeof data.item !== 'object'">
                                <v-list-tile-content v-text="data.item"></v-list-tile-content>
                            </template>
                            <template v-else>
                                <v-list-tile-content class="search-result-project-name">
                                    <v-list-tile-title v-html="data.item.Name"></v-list-tile-title>
                                </v-list-tile-content>
                            </template>
                        </template>
                    </v-autocomplete>
                </v-slide-x-reverse-transition>
            </v-layout>
        </v-flex>
        <v-btn icon @click="handleSearchIconClick">
            <v-icon>search</v-icon>
        </v-btn>
        <v-menu bottom offset-y transition="slide-y-transition" v-if="showOptionMenu" nudge-bottom="15" offset-x nudge-left="110">
            <v-btn slot="activator" icon>
                <v-icon>notes</v-icon>
            </v-btn>
            <v-list dense>
                <template v-for="(item, index) in $route.meta.optionMenu">
                    <v-divider v-if="item.text=='Divider'"></v-divider>
                    <template v-else>
                        <v-list-tile v-if="!item.editing" :key="item.text" @click="handleOptionMenuClick(item)">
                            <v-list-tile-action class="header-list-action">
                                <v-icon>{{item.icon}}</v-icon>
                            </v-list-tile-action>
                            <v-list-tile-content>
                                <v-list-tile-title>{{item.text}}</v-list-tile-title>
                            </v-list-tile-content>
                        </v-list-tile>
                        <template v-else>
                            <v-list-tile v-if="editing" :key="item.editing.text" @click="handleOptionMenuClick(item.editing)">
                                <v-list-tile-action class="header-list-action">
                                    <v-icon>{{item.editing.icon}}</v-icon>
                                </v-list-tile-action>
                                <v-list-tile-content>
                                    <v-list-tile-title>{{item.editing.text}}</v-list-tile-title>
                                </v-list-tile-content>
                            </v-list-tile>
                            <v-list-tile v-else :key="item.text" @click="handleOptionMenuClick(item)">
                                <v-list-tile-action class="header-list-action">
                                    <v-icon>{{item.icon}}</v-icon>
                                </v-list-tile-action>
                                <v-list-tile-content>
                                    <v-list-tile-title>{{item.text}}</v-list-tile-title>
                                </v-list-tile-content>
                            </v-list-tile>
                        </template>
                    </template>
                </template>
            </v-list>
        </v-menu>
        <v-menu bottom offset-y transition="slide-y-transition" nudge-bottom="15">
            <v-btn slot="activator" icon>
                <v-icon>more_vert</v-icon>
            </v-btn>
            <v-list dense class="setting-menu">
                <v-list-tile @click="goto('/Setting/MyAccount')">
                    <v-list-tile-action class="header-list-action">
                        <v-icon>settings</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                        <v-list-tile-title>个人设置</v-list-tile-title>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile @click="goto('logout')">
                    <v-list-tile-action class="header-list-action">
                        <v-icon>exit_to_app</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                        <v-list-tile-title>退出系统</v-list-tile-title>
                    </v-list-tile-content>
                </v-list-tile>
            </v-list>
        </v-menu>
    </v-toolbar>
</template>
<script>
import BasePage from '../../assets/js/BasePage'

export default {
    name: 'Header',
    extends: BasePage,
    props: ['subHeader'],
    computed: {
        editing() {
            return this.$store.state.editPlan //TODO add more
        },
        projectName() {
            return this.$props.subHeader
        },
        allProjects() {
            var result = []
            var all = this.$store.state.allProjects
            if(all.length){
                for (var i = 0; i < this.config.ProjectStatus.length; i++) {
                    var s = this.config.ProjectStatus[i]
                    if(all.filter(t => t.Status == s.value).length){
                        result.push({ header: s.text })
                        result = result.concat(all.filter(t => t.Status == s.value))
                        result.push({ divider: true })
                    }
                }
                if(result.length)
                    result.pop()
            }else{
                // Call Ajax
                this.$http.get(this.config.API_URL + '/Project/List').then(function(res) {
                    this.$store.commit('updateAllProjects', JSON.parse(res.bodyText))
                })
            }
            return result
        },
    },
    data: () => ({
        showSearch: false,
        project: 0,
    }),
    methods: {
        openDrawer() {
            this.$store.commit('openDrawer', !this.$store.state.drawer)
        },
        handleOptionMenuClick(menuItem) {
            this.$emit('onOptionMenuClick', menuItem)
            setTimeout(() => (this.$emit('onOptionMenuClick', {})), 2000)
        },
        handleSearchIconClick() {
            if (!this.showSearch)
                this.project = 0
            this.showSearch = !this.showSearch
        },
        goto(link) {
            if (link == 'logout') {
                this.$store.commit('updateProjectPhases', [])
                this.auth.logout()
            } else {
                this.$router.push(link)
            }
        },
    },
    watch: {
        project(v, ov) {
            if (v) {
                this.showSearch = false
                this.$router.push('/Project/' + v)
                //this.project = 0
            }
        }
    }
}

</script>
<style scoped>
.header-list-action {
    min-width: 35px !important;
}

.header-search .v-input__slot {
    margin-bottom: 0px;
    font-size: 0.9em;
}

.header-search {
    padding-top: 0px !important;
    max-width: 165px;
}

.search-result-project-name {
    padding-left: 12px;
}

</style>
