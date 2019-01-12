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
		},
		editable: false,
		newTask: null,
	},
	computed: {
		edit() {
			return this.$props.editable
		},
		commingTask() {
			return this.$props.newTask
		}
	},
	beforeCreate() {
		document.body.parentNode.style.overflowY = "hidden";
		document.getElementById("viewport").setAttribute('content', 'user-scalable=yes, width=device-width, initial-scale=0.5')
	},
	mounted() {
		document.getElementById('my-gantt-container').style.height = document.body.clientHeight - 64
		document.getElementById('my-gantt-container').style.width = document.body.clientWidth
		myGantt.initProjectGantt(this.$refs.container, this.edit)
		gantt.parse(this.$props.plan)
	},
	beforeDestroy() {
		document.getElementById("viewport").setAttribute('content', 'user-scalable=no, width=device-width, minimum-scale=1, initial-scale=1, maximum-scale=1');
		document.body.parentNode.style.overflowY = "auto";
	},
	watch: {
		plan: {
			deep: true,
			handler: function(v, ov) {
				if (v !== ov) {
					gantt.parse(v)
					v.data.filter(t => t.open).forEach(t => {
						gantt.open(t.id)
					})
				}
			}
		},
		editable(v, ov) {
			myGantt.initProjectGantt(this.$refs.container, this.edit)
			if (this.edit) {
				//编辑模式，event捕捉并传出
				myGantt.attachEvent('onTaskCreated', (task) => {
					this.$emit('onBeforeCreateTask', task.parent) //添加任务/子任务事件
					return false
				})
				myGantt.attachEvent('onBeforeLightbox', (id) => {
					var task = myGantt.gantt.getTask(id);
					console.log('onBeforeLightbox', task);
					this.$emit('onBeforeLightbox', task)
					return false
				})
			}
		},
		newTask(v, ov) {
			if (v !== ov && v) {
				console.log('here to up date gantt')
				console.log(v, v.parent);				
				//myGantt.gantt.addTask(v, 5)
				//TODO, to check the bug
				myGantt.gantt.addTask({text:v.text,start_date:v.start_date, duration: 6, }, v.parent)
			}
		},
	}
}

</script>
<style>
@import "dhtmlx-gantt/codebase/dhtmlxgantt.css";
/*@import "dhtmlx-gantt/codebase/locale/locale_cn.js"*/
@import "../../assets/css/gantt.css"

</style>
