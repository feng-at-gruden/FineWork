<template>
	<v-flex xs12 fill-height id="my-gantt-container" ref="container"></v-flex>
</template>
<script>
import 'dhtmlx-gantt'
import 'dhtmlx-gantt/codebase/ext/dhtmlxgantt_marker'
import 'dhtmlx-gantt/codebase/ext/dhtmlxgantt_fullscreen'
import "dhtmlx-gantt/codebase/locale/locale_cn.js"
import myGantt from '../../assets/js/Gantt.js'

export default {
	name: 'ProjectPlanGantt',
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
		clearAttachedGanttEvents(){
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
					console.log('onAfterTaskUpdate');
					this.$emit('onTaskUpdate', task)
					return false
				}))
			} else {
				this.ganttEventIds.push(myGantt.attachEvent('onTaskDblClick', (id, event) => {
					//按ctrl键点击task进入阶段计划
					this.$emit('onTaskDblClick', id)
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
		document.getElementById('my-gantt-container').style.height = document.body.clientHeight - 64
		document.getElementById('my-gantt-container').style.width = document.body.clientWidth
		myGantt.initProjectGantt(this.$refs.container, this.edit)
		this.attachGanttEvents()
		gantt.parse(this.myPlan)
		gantt.render()
	},
	beforeDestroy() {
		document.getElementById("viewport").setAttribute('content', 'user-scalable=no, width=device-width, minimum-scale=1, initial-scale=1, maximum-scale=1');
		document.body.parentNode.style.overflowY = "auto";
		this.clearAttachedGanttEvents()
	},
	watch: {
		myPlan: {
			handler: function(v, ov) {
				if (v != ov) {
					gantt.clearAll()
					myGantt.markerIds = []
					gantt.parse(v)
					myGantt.addMarkers(v) //添加开工/竣工Marker					
					v.data.filter(t => t.open).forEach(t => {
						gantt.open(t.id)
					})
				} else {
					//console.log('Data MAYBE Changed')
				}
			},
			//deep: true,
		},
		editable(v, ov) {
			if (v != ov) {
				myGantt.initProjectGantt(this.$refs.container, this.edit)
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
