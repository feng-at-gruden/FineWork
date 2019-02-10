<template>
    <CustomTransition :in="animationIn" :out="animationOut" @afterLeave="handleAnimEnd">
        <v-card>
            <v-img src="./static/images/construction2.jpg" position="top center" aspect-ratio="2.75"></v-img>
            <v-card-title primary-title>
                <div>
                    <h3 class="headline mb-0">{{project.Name}}</h3>
                    <div>{{project.Description}}</div>
                </div>
            </v-card-title>
            <v-card-actions>
                <v-btn flat color="primary" @click="gotoDetail" slot="">项目详情</v-btn>
            </v-card-actions>
        </v-card>
    </CustomTransition>
</template>
<script>
import config from '../../assets/js/Config'
import CustomTransition from './CustomTransition'
import util from '../../assets/js/Util'

export default {
    name: 'ProjectCard',
    props: ['data', 'animIn', 'animOut'],
    components: { CustomTransition },
    data() {
        return {
            util,
            config
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
        },
        project(){
            return this.$props.data
        }
    },
    methods: {
        gotoDetail() {
            this.$router.push('/Project/' + this.project.Id)
        },
        handleAnimEnd() {
            //this.$router.push('/Project/' + this.$props.project.id)
        }
    }
}

</script>
<style>
</style>
