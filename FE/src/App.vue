<template>
    <v-app id="app">
        <v-fade-transition mode="out-in">
            <router-view/>
        </v-fade-transition>
    </v-app>
</template>

<script>
export default {
    name: 'App',
    components: {},
    data() {
        return {
            transitionName: ''
        }
    },
    // watch: {
    //     $route(to, from) {
    //         if (to.level > from.level) {
    //             this.transitionName = 'fade'
    //         } else {
    //             this.transitionName = 'fade'
    //         }
    //     }
    // }
}

</script>

<style>


</style>
