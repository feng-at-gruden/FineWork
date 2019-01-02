<template>
        <h1>{{msg}}</h1>
</template>

<script>
export default {
    name: 'Header',
    props: [],
    data() {
        return {
            msg: 'Welcome to Your Vue.js App'
        }
    },
    methods: {
        
    }
}
</script>

<style>
h1{
    color:white;
}
</style>