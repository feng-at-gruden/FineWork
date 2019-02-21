<template>
	<v-flex xs12 fill-height id="my-phase-gantt" ref="container"></v-flex>
</template>
<script>
import 'dhtmlx-gantt'
import 'dhtmlx-gantt/codebase/ext/dhtmlxgantt_marker'
import 'dhtmlx-gantt/codebase/ext/dhtmlxgantt_fullscreen'
import "dhtmlx-gantt/codebase/locale/locale_cn.js"
import myGantt from '../../assets/js/Gantt.js'

export default {
	name: 'PhasePlanGantt',
	props: {
		plan: {
			type: Object,
			default () {
				return { data: [], lilnks: [], start_date: '', end_date: '' }
			}
		},
		editable: false,
		deleteId: 0,
	},
	data() {
		return {
			ganttEventIds: [],
		}
	},
	computed: {
		edit() {
			return this.$props.editable
		},
		myPlan: {
			get() { return this.$props.plan },
			set(v) {}
		}
	},
	methods: {
		clearAttachedGanttEvents() {
			this.ganttEventIds.forEach(t => { myGantt.detachEvent(t) })
		},
		attachGanttEvents() {
			this.clearAttachedGanttEvents()
			if (this.edit) {
				//编辑模式，event捕捉并传出
				this.ganttEventIds.push(myGantt.attachEvent('onTaskCreated', (task) => {
					this.$emit('onBeforeCreateTask', task.parent) //添加任务/子任务事件
					return false
				}))
				this.ganttEventIds.push(myGantt.attachEvent('onBeforeLightbox', (id) => {
					var task = myGantt.gantt.getTask(id);
					this.$emit('onOpenEditBox', task)
					return false
				}))
				this.ganttEventIds.push(myGantt.attachEvent('onAfterTaskUpdate', (id, task) => {
					this.$emit('onTaskUpdate', task)
					return false
				}))
				//Task drage restriction
				this.ganttEventIds.push(myGantt.attachEvent("onBeforeTaskDrag", (id, mode, e) => {
					var task = gantt.getTask(id);
					return !task.locked && task.progress != 1
				}))
				this.ganttEventIds.push(myGantt.attachEvent("onTaskDrag", (id, mode, task, original, e) => {
					var modes = gantt.config.drag_mode;
					var str_to_date = gantt.date.str_to_date("%d-%m-%Y")
					var leftLimit = str_to_date(this.myPlan.start_date), rightLimit = str_to_date(this.myPlan.end_date);
					if (mode == modes.move || mode == modes.resize) {
						var diff = original.duration*(1000*60*60*24)
						if(task.end_date > rightLimit){
				            task.end_date = new Date(rightLimit)
				            if(mode == modes.move)
				                task.start_date = new Date(task.end_date - diff)
				            }
				        if(task.start_date < leftLimit){
				            task.start_date = new Date(leftLimit)
				            if(mode == modes.move)
				                task.end_date = new Date(+task.start_date + diff)
				        }
					}
				}))
			} else {
				this.ganttEventIds.push(myGantt.attachEvent('onTaskDblClick', (id, event) => {
					//双击打开工作日志/进度更新对话框
					this.$emit('onTaskDblClick', id)
					return false
				}))
				this.ganttEventIds.push(myGantt.attachEvent('onOpenTaskWorkLog', (id, event) => {
					//双击打开工作日志/进度更新对话框
					this.$emit('onOpenTaskWorkLog', id)
					return false
				}))
			}
		},
	},
	beforeCreate() {
		document.body.parentNode.style.overflowY = "hidden";
		document.getElementById("viewport").setAttribute('content', 'user-scalable=yes, width=device-width, initial-scale=0.5')
	},
	mounted() {
		document.getElementById('my-phase-gantt').style.height = document.body.clientHeight - 64
		document.getElementById('my-phase-gantt').style.width = document.body.clientWidth
		myGantt.initPhaseGantt(this.$refs.container, this.edit)
		this.attachGanttEvents()
		gantt.parse(this.myPlan)
		gantt.render()
	},
	beforeDestroy() {
		document.getElementById("viewport").setAttribute('content', 'user-scalable=no, width=device-width, minimum-scale=1, initial-scale=1, maximum-scale=1');
		document.body.parentNode.style.overflowY = "auto";
		this.clearAttachedGanttEvents()
		gantt.clearAll()
	},
	watch: {
		myPlan: {
			handler: function(v, ov) {
				if (v != ov) {
					gantt.clearAll()
					myGantt.markerIds = []
					gantt.parse(v)
					myGantt.addTodayMarker()
					v.data.filter(t => t.open).forEach(t => {
						gantt.open(t.id)
					})
				}
			},
			//deep: true,
		},
		editable(v, ov) {
			if (v != ov) {
				myGantt.initPhaseGantt(this.$refs.container, this.edit)
				this.attachGanttEvents()
			}
		},
		deleteId(v, ov) {
			if (v > 0)
				gantt.deleteTask(v)
		}
	}
}

</script>
<style>
@import "dhtmlx-gantt/codebase/dhtmlxgantt.css";
@import "../../assets/css/gantt.css"
</style>
