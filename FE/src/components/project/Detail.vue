<template>
	<div class="container" style="width:100%; height:100%">
		<ProjectPlanGantt :plan="plan"></ProjectPlanGantt>
	</div>
</template>
<script>
import BasePage from '../../assets/js/BasePage'
import ProjectPlanGantt from '../gantt/ProjectPlanGantt';
//import '../../../static/gantt/dhtmlxgantt.js?v=6.0.2'
//import '../../../static/gantt/ext/dhtmlxgantt_marker.js?v=6.0.2'
//import myGantt from '../../assets/js/Gantt.js'

export default {
	extends: BasePage,
	name: 'ProjectDetail',
	components:{ProjectPlanGantt},
	data() {
		return {
			plan:{ data: [], links: [] }
		}
	},
	methods: {
		loadProjectDetail() {
			// Call Ajax
			this.$http.get(this.config.API_URL + '/project/plan', { emulateJSON: true }).then(function(res) {
				this.plan = JSON.parse(res.bodyText)
			}, function(res) {

			})
		}
	},
	mounted() {
		this.loadProjectDetail()
	}
}

</script>
<style>
/* @import "../../../static/gantt/dhtmlxgantt.css"
@import "../../../static/gantt/locale/locale_cn.js"
@import "../../assets/css/gantt.css" */

</style>
