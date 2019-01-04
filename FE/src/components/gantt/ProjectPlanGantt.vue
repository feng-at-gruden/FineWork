<template>
	<div ref="container"></div>
</template>

<script>
import 'dhtmlx-gantt'
import 'dhtmlx-gantt/codebase/ext/dhtmlxgantt_marker'
import myGantt from '../../assets/js/Gantt.js'
//import '../../../static/gantt/ext/dhtmlxgantt_marker.js?v=6.0.2'
//import '../../../static/gantt/sources/dhtmlxgantt.js?v=6.0.2'

export default {
	name: 'ProjectPlanGantt',
	props: {
		plan: {
			type: Object,
			default () {
				return { data: [], links: [] }
			}
		}
	},
	mounted: function() {

		//myGantt.initProjectGantt(this.$refs.container)
		gantt.init(this.$refs.container)
		gantt.parse(this.$props.plan)
	},
	watch:{
		plan:{
			deep: true,
			handler:function(v, ov){
				//myGantt.initProjectGantt(this.$refs.container)
				//debugger
				//gantt.init(this.$refs.container)
				gantt.parse(v)
			}
		}
	}
}

</script>

<style>
@import "dhtmlx-gantt/codebase/dhtmlxgantt.css";
/*@import "dhtmlx-gantt/codebase/locale/locale_cn.js"*/
@import "../../assets/css/gantt.css" 

</style>
