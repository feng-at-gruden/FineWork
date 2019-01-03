<template>
    <v-toolbar app fixed clipped-left>
        <v-toolbar-side-icon @click.stop="openDrawer"></v-toolbar-side-icon>
        <v-toolbar-title>{{title}}</v-toolbar-title>
    </v-toolbar>
</template>
<script>
export default {
    name: 'Header',
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
        }
    },
}

</script>
<style>
</style>
