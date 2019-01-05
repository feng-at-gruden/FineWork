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
}
</script>

<style>
</style>
