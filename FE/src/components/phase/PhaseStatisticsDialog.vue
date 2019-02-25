<template>
    <v-dialog v-model="dialog" lazy content-class="half-right-dialog" hide-overlay transition="slide-x-reverse-transition">
        <v-card>
            <v-container style="max-width: 600px;">
                {{json}}

                <v-btn color="success" :loading="loading" @click="loadPhaseStatistics">text</v-btn>
            </v-container>
        </v-card>
    </v-dialog>
</template>
<script>
import config from '../../assets/js/Config'
export default {
    name: 'PhaseStatisticsDialog',
    props: ['open'],
    data() {
        return {
            config,
            json:{},
            loading: false,
        }
    },
    computed: {
        phaseId() {
            return this.$route.params.id
        },
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        }
    },
    watch: {
        dialog(v, ov){
            if(v){
                this.loadPhaseStatistics()
            }
        }
    },
    methods: {
        loadPhaseStatistics() {
            console.log('Loading')
            this.loading = true
            this.$http.get(this.config.API_URL + '/Phase/Statistics?id=' + this.phaseId)
            .then(function(res) {
                this.json = JSON.parse(res.bodyText)
                
                this.loading = false
            })
        },
    }
}

</script>
<style>
</style>
