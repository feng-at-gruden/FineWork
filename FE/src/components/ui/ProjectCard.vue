<template>
    <CustomTransition :in="animationIn" :out="animationOut" @afterLeave="handleAnimEnd">
        <v-card v-show="!clicked">
            <v-img src="https://cdn.vuetifyjs.com/images/cards/desert.jpg" aspect-ratio="2.75"></v-img>
            <v-card-title primary-title>
                <div>
                    <h3 class="headline mb-0">{{$props.project.name}}</h3>
                    <div>Located two hours south of Sydney in the <br>Southern Highlands of New South Wales, ...</div>
                </div>
            </v-card-title>
            <v-card-actions>
                <v-btn flat color="orange" @click="gotoDetail" slot="">Share</v-btn>
                <v-btn flat color="orange">Explore</v-btn>
            </v-card-actions>
        </v-card>
    </CustomTransition>
</template>
<script>
import CustomTransition from './CustomTransition'
import util from '../../assets/js/Util'

export default {
    name: 'ProjectCard',
    props: ['project', 'animIn', 'animOut'],
    components: { CustomTransition },
    data() {
        return {
            clicked: false,
            util,
        }
    },
    computed: {
        animationIn() {
            if (this.$props.animIn)
                return this.$props.animIn
            else
                return this.util.randomIn()
        },
        animationOut() {
            if (this.$props.animOut)
                return this.$props.animOut
            else
                return this.util.randomOut()
        }
    },
    created() {

    },
    methods: {
        gotoDetail() {
            this.clicked = true
        },
        handleAnimEnd() {
            this.$router.push('/Project/' + this.$props.project.id)
        }
    }
}

</script>
<style>
</style>
