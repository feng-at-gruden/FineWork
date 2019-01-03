<template>
    <div>
        {{title}}
    </div>
</template>

<script>
    import BasePage from '../assets/js/BasePage'
    export default {
        extends : BasePage,
        name: 'Dashboard',        
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

</style>