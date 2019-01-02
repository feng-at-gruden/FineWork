<template>
    <v-app dark id="app">
        <transition :name="transitionName">
            <router-view />
        </transition>
    </v-app>
</template>
<script>
export default {
    name: 'App',
    data(){
        return {
            transitionName:''
        }
    },
    watch:{
        $route(to, from) {
            if(to.level>from.level)
            {
                this.transitionName = 'bounce'
            }else{
                this.transitionName = 'fade'
            }
        }
    }
}

</script>
<style>
#app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin: 0px;
}
.fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}

.bounce-enter-active {
  animation: bounce-in .5s;
}
.bounce-leave-active {
  animation: bounce-in .5s reverse;
}
@keyframes bounce-in {
  0% {
    transform: scale(0);
  }
  50% {
    transform: scale(1.5);
  }
  100% {
    transform: scale(1);
  }
}
</style>
