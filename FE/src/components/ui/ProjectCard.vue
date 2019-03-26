<template>
    <CustomTransition :in="animationIn" :out="animationOut" @afterLeave="handleAnimEnd">
        <v-card>
            <v-img src="./static/images/construction2.jpg" position="top center" aspect-ratio="2.75"></v-img>
            <v-card-title primary-title>
                <div style="width: 100%">
                    <h3 class="headline mb-0 no-wrap text-truncate">{{project.Name}}</h3>
                    <div class="text-truncate" style="padding-top: 5px;">{{project.Description}} &nbsp;</div>
                </div>
            </v-card-title>
            <v-card-actions>
                <v-btn flat color="primary" @click="gotoDetail">项目详情</v-btn>
                <v-spacer></v-spacer>
                <v-icon small class="mr-2" @click="openDialog(1)">
                    bar_chart
                </v-icon>

                <!--
                <v-icon small class="mr-2" @click="openDialog(0)">
                    chrome_reader_mode
                </v-icon>
                <v-icon small class="mr-2" @click="openDialog(2)" v-if="showBtn[2]">
                    delete_forever
                </v-icon>
                -->
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
    props: ['data', 'animIn', 'animOut', 'showBtns'],
    components: { CustomTransition },
    data() {
        return {
            util,
            config,
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
        showBtn() {
            return this.$props.showBtns
        },
        project() {
            return this.$props.data
        },
    },
    methods: {
        gotoDetail() {
            this.$router.push('/Project/' + this.project.Id)
        },
        handleAnimEnd() {
            //this.$router.push('/Project/' + this.$props.project.id)
        },
        openDialog(v){
            this.$emit('onOpenDialog', { button:v, project:this.project })
        }
    },
}
</script>
<style>
</style>
