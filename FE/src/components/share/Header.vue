<template>
    <v-toolbar :color="config.Theme" app fixed clipped-left>
        <v-toolbar-side-icon @click.stop="openDrawer"></v-toolbar-side-icon>
        <v-toolbar-title>{{title}}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon>
            <v-icon>search</v-icon>
        </v-btn>
        <v-btn icon>
            <v-icon>info_outline</v-icon>
        </v-btn>
        <v-menu bottom offset-y transition="slide-y-transition">
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
        }
    },
    data: () => ({
        
    }),
    methods: {
        openDrawer() {
            this.$store.commit('openDrawer', !this.$store.state.drawer)
        },
        goto(link){            
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
.setting-menu-list-tile-action{
    min-width: 35px;
}
</style>
