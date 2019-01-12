<template>
    <v-toolbar color="primary" app fixed clipped-left>
        <v-toolbar-side-icon @click.stop="openDrawer"></v-toolbar-side-icon>
        <v-toolbar-title>{{title}} <v-fade-transition mode="in-out"><v-icon v-if="$store.state.editing">edit</v-icon></v-fade-transition></v-toolbar-title>
        <v-spacer></v-spacer>
        <v-flex xs8 sm4 md2>
            <v-slide-x-reverse-transition>
                <v-text-field class="header-search" clearable v-if="showSearch" color="grey darken-4" @keydown.enter="showSearch=false"></v-text-field>
            </v-slide-x-reverse-transition>
        </v-flex>
        <v-btn icon @click="showSearch=!showSearch">
            <v-icon>search</v-icon>
        </v-btn>
        <v-menu bottom offset-y transition="slide-y-transition" v-if="showOptionMenu" nudge-bottom="15">
            <v-btn slot="activator" icon>
                <v-icon>notes</v-icon>
            </v-btn>
            <v-list dense>
                <template v-for="(item, index) in $route.meta.optionMenu">
                    <v-divider v-if="item.text=='Divider'"></v-divider>
                    <template v-else>
                        <v-list-tile v-if="!item.editing" :key="item.text" @click="handleOptionMenuClick(item)">
                            <v-list-tile-action class="setting-menu-list-tile-action">
                                <v-icon>{{item.icon}}</v-icon>
                            </v-list-tile-action>
                            <v-list-tile-content>
                                <v-list-tile-title>{{item.text}}</v-list-tile-title>
                            </v-list-tile-content>
                        </v-list-tile>
                        <template v-else>
                            <v-list-tile v-if="editing" :key="item.editing.text" @click="handleOptionMenuClick(item.editing)">
                                <v-list-tile-action class="setting-menu-list-tile-action">
                                    <v-icon>{{item.editing.icon}}</v-icon>
                                </v-list-tile-action>
                                <v-list-tile-content>
                                    <v-list-tile-title>{{item.editing.text}}</v-list-tile-title>
                                </v-list-tile-content>
                            </v-list-tile>
                            <v-list-tile v-else :key="item.text" @click="handleOptionMenuClick(item)">
                                <v-list-tile-action class="setting-menu-list-tile-action">
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
                    <v-list-tile-action class="setting-menu-list-tile-action">
                        <v-icon>settings</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                        <v-list-tile-title>设置</v-list-tile-title>
                    </v-list-tile-content>
                </v-list-tile>
                <v-list-tile @click="goto('logout')">
                    <v-list-tile-action class="setting-menu-list-tile-action">
                        <v-icon>exit_to_app</v-icon>
                    </v-list-tile-action>
                    <v-list-tile-content>
                        <v-list-tile-title>退出</v-list-tile-title>
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
    props: [],
    computed: {
        title() {
            return this.$route.meta.title
        },
        editing() {
            return this.$store.state.editing
        }
    },
    data: () => ({
        showSearch: false,
    }),
    methods: {
        openDrawer() {
            this.$store.commit('openDrawer', !this.$store.state.drawer)
        },
        handleOptionMenuClick(menuItem) {
            this.$emit('onOptionMenuClick', menuItem)
            setTimeout(() => (this.$emit('onOptionMenuClick', {})), 4000)
        },
        goto(link) {
            if (link == 'logout') {
                this.auth.logout()
            } else {
                this.$router.push(link)
            }
        },
    },
}

</script>
<style>
.setting-menu-list-tile-action {
    min-width: 35px;
}

.header-search .v-input__slot {
    margin-bottom: 0px;
    font-size: 0.9em;
}
</style>
