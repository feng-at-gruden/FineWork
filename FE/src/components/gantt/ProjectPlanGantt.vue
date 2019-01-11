<template>
	<v-flex xs12 fill-height id="my-gantt-container" ref="container"></v-flex>
</template>

<script>
import 'dhtmlx-gantt'
import 'dhtmlx-gantt/codebase/ext/dhtmlxgantt_marker'
import 'dhtmlx-gantt/codebase/ext/dhtmlxgantt_fullscreen'
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
	beforeCreate() {
		document.body.parentNode.style.overflowY = "hidden";
		document.getElementById("viewport").setAttribute('content','user-scalable=yes, width=device-width, initial-scale=0.5')
	},
	mounted() {
		document.getElementById('my-gantt-container').style.height = document.body.clientHeight - 64
		document.getElementById('my-gantt-container').style.width = document.body.clientWidth
		myGantt.initProjectGantt(this.$refs.container)
		gantt.parse(this.$props.plan)
	},
	beforeDestroy(){
		document.getElementById("viewport").setAttribute('content','user-scalable=no, width=device-width, minimum-scale=1, initial-scale=1, maximum-scale=1');
		document.body.parentNode.style.overflowY = "auto";
	},
	watch:{
		plan:{
			deep: true,
			handler:function(v, ov){
				if(v!==ov){
					gantt.parse(v)
					v.data.filter(t=>t.open).forEach(t=>{						
						gantt.open(t.id)						
					})				
				}				
			}
		}
	},	
}

</script>

<style>
@import "dhtmlx-gantt/codebase/dhtmlxgantt.css";
/*@import "dhtmlx-gantt/codebase/locale/locale_cn.js"*/
@import "../../assets/css/gantt.css" 




</style>
