<template>
	<v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition">
        <v-card>
            <v-toolbar dark color="primary">
                <v-btn icon dark @click="handleCancel">
                    <v-icon>close</v-icon>
                </v-btn>
                <v-toolbar-title>工作日志</v-toolbar-title>
                <v-spacer></v-spacer>
                <v-toolbar-items>
                    <v-btn dark flat large @click="handleSave" :loading="loading">关闭</v-btn>
                </v-toolbar-items>
            </v-toolbar>
            <v-form lazy-validation ref="editAccountForm">
                <ds-calendar-app :calendar="calendar"></ds-calendar-app>
            </v-form>
            
        </v-card>
    </v-dialog>
</template>

<script>
//https://github.com/ClickerMonkey/dayspan-vuetify
	import BasePage from '../../assets/js/BasePage'
	import { Calendar } from 'dayspan'
	export default {
    extends: BasePage,
		name: 'WorklogCalender',
		props: ['open'],
		data () {
			return {
				calendar: Calendar.months()
			}
		},
		computed: {
		    dialog: {
		        get() { return this.$props.open },
		        set(v) {
		            this.$emit('close')
		        }
		    },
		},
		methods:{
			handleCancel() {
			    //this.$refs.editAccountForm.reset()
			    this.dialog = false
			    this.loading = false
			},
			handleSave() {
			    //Call API
			    this.dialog = false
			    this.loading = false
			},
		}
	}
</script>

<style>

</style>