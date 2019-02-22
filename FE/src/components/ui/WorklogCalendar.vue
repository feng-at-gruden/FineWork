<template>
	<v-dialog v-model="dialog" width="100%" fullscreen hide-overlay transition="dialog-bottom-transition">
		<v-card>
			<v-toolbar dark color="primary">
				<v-btn icon dark @click="dialog=false">
					<v-icon>close</v-icon>
				</v-btn>
				<v-toolbar-title>工作日志</v-toolbar-title>
				<v-spacer></v-spacer>
				<v-toolbar-items>
					<v-btn dark flat large @click="dialog=false" :loading="loading">关闭</v-btn>
				</v-toolbar-items>
			</v-toolbar>
			<div id="worklog-calendar-container" class="dhx_cal_container" ref="container">
				<div class="dhx_cal_navline">
					<div class="dhx_cal_prev_button">&nbsp;</div>
					<div class="dhx_cal_next_button">&nbsp;</div>
					<div class="dhx_cal_today_button"></div>
					<div class="dhx_cal_date"></div>
					<div class="dhx_cal_tab" name="day_tab" style="right:204px;"></div>
					<div class="dhx_cal_tab" name="week_tab" style="right:140px;"></div>
					<div class="dhx_cal_tab" name="month_tab" style="right:76px;"></div>
				</div>
				<div class="dhx_cal_header">
				</div>
				<div class="dhx_cal_data">
				</div>
			</div>
		</v-card>
	</v-dialog>
</template>
<script>
import 'dhtmlx-scheduler'
import myCalendar from '../../assets/js/Calendar.js'
import BasePage from '../../assets/js/BasePage'
var demoEvents =  [
		{ "id": "1", "start_date": "2019-02-14 08:00:00", "end_date": "2019-02-14 09:30:00", "text": "French Open", "details": "Philippe-Chatrier Court\n Paris, FRA" },
	]


export default {
	extends: BasePage,
	name: 'WorklogCalendar',
	props: ['open', 'taskId'],
	components: {},
	data() {
		return {
			worklogs:[],
		}
	},
	computed: {
		dialog: {
			get() { return this.$props.open },
			set(v) {
				this.$emit('close')
			}
		},
		id(){
			return this.$props.taskId
		}
	},
	watch: {
		dialog(v, ov) {
			if (v) {
				setTimeout(() => (myCalendar.initCalendar(this.$refs.container)), 100)
				this.loadWorklog()
			}
		}
	},
	methods: {
		loadWorklog() {
			//Load API
			this.loading = true
            this.$http.get(this.config.API_URL + '/Worklog/List?id=' + this.id).then(function(res) {
                var json = JSON.parse(res.bodyText)
                this.loading = false
                this.worklogs = this.refineWorklog(json)
                this.refreshCalendar()
            })
		},
		refineWorklog(worklogs){
			var r = []
			for(var i=0;i<worklogs.length;i++){
				r.push( {
					id: worklogs[i].id,
					text: worklogs[i].description,
					details: worklogs[i].comment,
					start_date: worklogs[i].created_date.split('T')[0]  + ' ' + worklogs[i].created_date.split('T')[1],
					end_date: worklogs[i].created_date.split('T')[0]  + ' ' + worklogs[i].created_date.split('T')[1],
				} )
			}
			return r
		},
		refreshCalendar() {
			//Clear
			console.log(this.worklogs)
			myCalendar.loadEvents(this.worklogs)
		}
	},
}

</script>
<style>
@import "dhtmlx-scheduler/codebase/dhtmlxscheduler_material.css";
@import "../../assets/css/calendar.css"

</style>
