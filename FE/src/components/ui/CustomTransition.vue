<template>
    <transition :enter-active-class="$props.in" :leave-active-class="$props.out" @before-leave="beforeLeave" @after-leave="afterLeave">
        <slot></slot>
    </transition>
</template>
<script>
export default {
    name: 'CustomTransition',
    props:['in','out'],    
    methods: {
        afterLeave: function (el) {
          this.$emit('afterLeave')
        },
        beforeLeave: function (el) {
          this.$emit('beforeLeave')
        }
    },    
}
</script>
<style>
@import '../../../static/animate/animate.css'
</style>
