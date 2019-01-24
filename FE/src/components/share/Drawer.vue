<template>
    <v-navigation-drawer v-model="drawer" @input="handleInput" class="my-drawer grey lighten-4" clipped fixed app>
        <v-list dense class="grey lighten-4">
            <template v-for="(item, i) in items">
                <v-layout row v-if="item.heading" align-center :key="i">
                    <v-flex xs6>
                        <v-subheader v-if="item.heading">
                            {{ item.heading }}
                        </v-subheader>
                    </v-flex>
                    <v-flex xs6 class="text-xs-right">
                        <!--<v-btn small flat>edit</v-btn>-->
                    </v-flex>
                </v-layout>
                <v-divider dark v-else-if="item.divider" class="my-3" :key="i"></v-divider>
                <v-list-tile :key="i" v-else-if="item.title=='PROJECT-DROPDOWN'" v-show="openProjects.length>0">
                    <v-list-tile-content class="drawer-projects-box">
                        <v-select :items="openProjects" v-model="selectedProjectId" menu-props="auto" :label="lableDisp" hide-details prepend-icon="map" single-line item-text="Name" item-value="Id"></v-select>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile :key="i" v-else @click="goto(item)">
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
export default {
    name: 'Drawer',
    props: ['selectedProject'],
    data() {
        return {
            mini: false,
            items: [
                /*{ title: '登录', link: '/login', icon: 'supervisor_account' },*/
                /*{ title: '主页', link: '/', icon: 'home' },*/
                { title: 'PROJECT-DROPDOWN', link: '/', icon: 'home' },
                { divider: true },
                { heading: '项目管理' },
                { title: '新建项目', link: '/Project/Create', icon: 'library_add' },
                { title: '项目一览', link: '/Project/List', icon: 'location_city' },
                { divider: true },
                { heading: '计划管理' },
                { title: '项目计划', link: '/Project/1', icon: 'subject' },
                { title: '阶段计划', link: '/Phase/Plan', icon: 'playlist_add_check' },
                { divider: true },
                { heading: '工作汇报' },
                { title: '施工日志', link: '/work/daily', icon: 'assignment' },
                { divider: true },
                { heading: '系统管理' },
                { title: '账号管理', link: '/Setting/Account', icon: 'supervisor_account' },
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
            return this.$store.state.openProjects
        },
        selectedProjectId: {
            get() { return this.$props.selectedProject },
            set(v) {
                //if (v != this.selectedProjectId) {
                    this.$router.push('/Project/' + v)
                    this.$store.commit('updateSelectedPorject', v)
                //}else{
                //	console.log('set from outside ', v)
                //}
            }
        },
        lableDisp(){
        	return '在建项目' + this.selectedProjectId
        }
    },
    methods: {
        goto(item) {
            if (item.link == 'logout') {
                this.auth.logout()
            } else {
                this.$router.push(item.link)
            }
        },
        handleInput(v) {
            this.$store.commit('openDrawer', v)
        }
    },
    watch: {
        selectedProject(v, ov) {
            if (v != ov) {
            	console.log('watch', v)
                this.selectedProjectId = v
            }
        }
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
    padding-bottom: 10px;
}

</style>
