<template>
    <v-stepper v-model="step" vertical color="primary">
        <v-stepper-step :complete="step > 1" step="1">
            项目基础信息
        </v-stepper-step>
        <v-stepper-content step="1">
            <v-card color="grey lighten-1" class="mb-5" height="200px"></v-card>
            <v-btn color="primary" @click="step++">下一步</v-btn>
        </v-stepper-content>
        <v-stepper-step :complete="step > 2" step="2">工程施工阶段</v-stepper-step>
        <v-stepper-content step="2">
            <v-card color="grey lighten-1" class="mb-5" height="200px"></v-card>
            <v-btn color="primary" @click="step++">下一步</v-btn>
            <v-btn flat @click="step--">上一步</v-btn>
        </v-stepper-content>
        <v-stepper-step :complete="step > 3" step="3">添加项目管理人员</v-stepper-step>
        <v-stepper-content step="3">
            <v-card color="grey lighten-1" class="mb-5" height="200px"></v-card>
            <v-btn color="primary" @click="step++">下一步</v-btn>
            <v-btn flat @click="step--">上一步</v-btn>
        </v-stepper-content>
        <v-stepper-step step="4">项目信息确认</v-stepper-step>
        <v-stepper-content step="4">
            <v-card color="grey lighten-1" class="mb-5" height="200px"></v-card>
            <v-btn color="primary" @click="step = 1">生成项目</v-btn>
            <v-btn flat @click="step--">上一步</v-btn>
        </v-stepper-content>
    </v-stepper>
</template>
<script>
import BasePage from '../../assets/js/BasePage'

export default {
    extends: BasePage,
    name: 'CreateProject',
    props: [],
    computed: {

    },
    data() {
        return {
            step:1,
        }
    },
    methods: {

    },
}

</script>
<style>
</style>
