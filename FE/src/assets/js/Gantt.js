const denseDateFmt = gantt.date.date_to_str("%Y/%m/%d")
const denseDateFmtS = gantt.date.date_to_str("%m/%d")

var colHeader = '<div class="gantt_grid_head_cell gantt_grid_head_add" onclick="gantt.createTask()"></div>'
var colContent = function(task) {
	return ('<i class="fa gantt_button_grid gantt_grid_edit fa-pencil" onclick="clickGridButton(' + task.id + ', \'edit\')"></i>' +
		'<i class="fa gantt_button_grid gantt_grid_add fa-plus" onclick="clickGridButton(' + task.id + ', \'add\')"></i>' +
		'<i class="fa gantt_button_grid gantt_grid_delete fa-times" onclick="clickGridButton(' + task.id + ', \'delete\')"></i>');
}

const projectReadonlyColumns = [
	{ name: "text", label: "项目阶段", tree: false, align: "center", width: "*" },
	{
		name: "start_date",
		label: "阶段周期",
		align: "center",
		width: "95",
		template(obj) {
			/*if (obj.progress > 0) {
				var str = '<div>' + denseDateFmt(obj.start_date) + " - " + denseDateFmtS(obj.end_date) + '</div>'
				str = str + '<div ' + (obj.exceed ? 'class="project-delayed"' : '') + '>' + obj.actual_start + " - " + obj.actual_end + '</div>'
			} else {
				var str = '<div class="oneline">' + denseDateFmt(obj.start_date) + " - " + denseDateFmtS(obj.end_date) + '</div>'
			}
			return '<div class="gantt-content-samll">' + str + '</div>'*/
			var str = '<div class="oneline">' + denseDateFmt(obj.start_date) + " - " + denseDateFmtS(obj.end_date) + '</div>'
			return '<div class="gantt-content-samll">' + str + '</div>'
		}
	},
	{
		name: "duration",
		label: "天",
		align: "center",
		width: "25",
		template(obj) {
			/*if (obj.progress > 0) {
				var str = '<div>' + obj.plan_duration + '</div>'
				str = str + '<div ' + (obj.exceed ? 'class="project-delayed"' : '') + '>' + obj.actual_duration + '</div>'
			} else {
				var str = '<div class="oneline">' + obj.duration + '</div>'
			}
			return '<div class="gantt-content-samll">' + str + '</div>'*/
			var str = '<div class="oneline">' + obj.duration + '</div>'
			return '<div class="gantt-content-samll">' + str + '</div>'
		}
	},
	{
		name: "progress",
		label: "状态",
		align: "center",
		width: "48",
		template: function(obj) {
			var str
			if (obj.status == "已停工") {
				str = "已停工"
			} else if (obj.progress == 1) {
				str = "已完工"
			} else if (obj.progress == 0) {
				str = "未开工"
			} else {
				str = obj.progress * 100 + "%"
			}
			return "<div class=\"gantt-content-left-status " + (obj.exceed ? 'project-delayed' : '') + '\">' + str + "</div>"
		}
	}
];
const projectEditingColumns = [
	{ name: "text", label: "项目阶段", tree: false, align: "center", width: "*" },
	{
		name: "start_date",
		label: "阶段周期",
		align: "center",
		width: "95",
		template(obj) {
			var str = '<div class="oneline">' + denseDateFmt(obj.start_date) + " - " + denseDateFmtS(obj.end_date) + '</div>'
			return '<div class="gantt-content-samll">' + str + '</div>'
		}
	},
	{
		name: "duration",
		label: "天",
		align: "center",
		width: "25",
		template(obj) {
			var str = '<div class="oneline">' + obj.duration + '</div>'
			return '<div class="gantt-content-samll">' + str + '</div>'
		}
	},
	{ name: "buttons", label: colHeader, width: "25", template: function(task) { return '' } }
];


const phaseReadonlyColumns = [
	{ name: "text", label: "施工任务", tree: true, align: "left", width: "*" },
	{
		name: "start_date",
		label: "施工周期",
		align: "center",
		width: "95",
		template(obj) {
			if (obj.progress > 0) {
				var str = '<div>' + denseDateFmt(obj.start_date) + " - " + denseDateFmtS(obj.end_date) + '</div>'
				if (obj.type != 'project')
					str = str + '<div ' + (obj.exceed ? 'class="project-delayed"' : '') + '>' + obj.actual_start + " - " + obj.actual_end + '</div>'
				else
					var str = '<div class="oneline">' + denseDateFmt(obj.start_date) + " - " + denseDateFmtS(obj.end_date) + '</div>'
			} else {
				var str = '<div class="oneline">' + denseDateFmt(obj.start_date) + " - " + denseDateFmtS(obj.end_date) + '</div>'
			}
			return '<div class="gantt-content-samll">' + str + '</div>'
		}
	},
	{
		name: "duration",
		label: "天",
		align: "center",
		width: "25",
		template(obj) {
			if (obj.progress > 0) {
				var str = '<div>' + obj.duration + '</div>'
				if (obj.type != 'project')
					str = str + '<div ' + (obj.exceed ? 'class="project-delayed"' : '') + '>' + obj.actual_duration + '</div>'
				else
					var str = '<div class="oneline">' + obj.duration + '</div>'
			} else {
				var str = '<div class="oneline">' + obj.duration + '</div>'
			}
			return '<div class="gantt-content-samll">' + str + '</div>'
		}
	},
	{
		name: "progress",
		label: "状态",
		align: "center",
		width: "48",
		template: function(obj) {
			var str
			if (obj.status == "已停工") {
				str = "已停工"
			} else if (obj.progress == 1) {
				str = "已完工"
			} else if (obj.progress == 0) {
				str = "未开工"
			} else {
				str = accMul(obj.progress, 100) + "%"
			}
			return "<div class=\"gantt-content-left-status " + ((obj.exceed || obj.delayed) ? 'project-delayed' : '') + '\">' + str + "</div>"
		}
	}
];
const phaseEditingColumns = [
	{ name: "text", label: "施工任务", tree: true, align: "left", width: "*" },
	{
		name: "start_date",
		label: "施工周期",
		align: "center",
		width: "95",
		template(obj) {
			var str = '<div class="oneline">' + denseDateFmt(obj.start_date) + " - " + denseDateFmtS(obj.end_date) + '</div>'
			return '<div class="gantt-content-samll">' + str + '</div>'
		}
	},
	{
		name: "duration",
		label: "天",
		align: "center",
		width: "25",
		template(obj) {
			var str = '<div class="oneline">' + obj.duration + '</div>'
			return '<div class="gantt-content-samll">' + str + '</div>'
		}
	},
	{ name: "add", label: colHeader, width: "25" }
];


function accMul(arg1, arg2) {
    var m = 0,
        s1 = arg1?arg1.toString():'0.0',
        s2 = arg2.toString();
    try { m += s1.split(".")[1].length } catch (e) {}
    try { m += s2.split(".")[1].length } catch (e) {}
    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
}

function limitMoveLeft(task, limit) {
	var dur = task.end_date - task.start_date;
	task.end_date = new Date(limit.end_date);
	task.start_date = new Date(+task.end_date - dur);
}

function limitMoveRight(task, limit) {
	var dur = task.end_date - task.start_date;
	task.start_date = new Date(limit.start_date);
	task.end_date = new Date(+task.start_date + dur);
}

function limitResizeLeft(task, limit) {
	task.end_date = new Date(limit.end_date);
}

function limitResizeRight(task, limit) {
	task.start_date = new Date(limit.start_date)
}

function getTaskFitValue(task) {
	var taskStartPos = gantt.posFromDate(task.start_date),
		taskEndPos = gantt.posFromDate(task.end_date);

	var width = taskEndPos - taskStartPos;
	var textWidth = (task.text || "").length * gantt.config.font_width_ratio;

	if (width < textWidth) {
		var ganttLastDate = gantt.getState().max_date;
		var ganttEndPos = gantt.posFromDate(ganttLastDate);
		if (ganttEndPos - taskEndPos < textWidth) {
			return "left"
		} else {
			return "right"
		}
	} else {
		return "center";
	}
}

export default {

	monthScaleTemplate: function(date) {
		var formatFunc = gantt.date.date_to_str("%M");
		return formatFunc(date)
	},

	weekScaleTemplate: function(date) {
		var dateToStr = gantt.date.date_to_str("%m月%d日");
		var endDate = gantt.date.add(gantt.date.add(date, 1, "week"), -1, "day");
		return dateToStr(date) + " - " + dateToStr(endDate);
	},

	projectWeekScaleTemplate: function(date) {
		var dateToStr = gantt.date.date_to_str("%m/%d");
		var endDate = gantt.date.add(gantt.date.add(date, 1, "week"), -1, "day");
		return dateToStr(date) + " - " + dateToStr(endDate);
	},

	daysStyle: function(date) {
		var dateToStr = gantt.date.date_to_str("%D");
		if (dateToStr(date) == "六" || dateToStr(date) == "日") return "week_end";
		return "";
	},

	addMarker: function(marker_date, text, css) {
		//add start and finish marker
		var date_to_str = gantt.date.date_to_str("%Y年%m月%d日")
		var str_to_date = gantt.date.str_to_date("%d-%m-%Y")
		if (marker_date != '') {
			var start = str_to_date(marker_date)
			var id = gantt.addMarker({
				start_date: start,
				css,
				text,
				title: text + "日期: " + date_to_str(start)
			})
			return id
		}
		return 0
	},

	addMarkers: function(project) {
		if (this.markerIds.length >= 3)
			return
		if (project.start_date != '')
			this.markerIds.push(this.addMarker(project.start_date, '开工', 'start-work'))
		if (project.end_date != '')
			this.markerIds.push(this.addMarker(project.end_date, '竣工', 'end-work'))
		this.addTodayMarker()
	},
	addTodayMarker: function() {
		var date_to_str = gantt.date.date_to_str("%d-%m-%Y")
		this.markerIds.push(this.addMarker(date_to_str(new Date()), '今天', 'today'))
	},
	removeMarkers: function() {
		for (var i; i < this.markerIds.length; i++) {
			gantt.deleteMarker(this.markerIds[i])
		}
	},
	removeMarker: function(id) {
		document.getElementById('') //TODO
	},
	markerIds: [],

	initBasicProjectGantt: function(id, editable) {
		/*gantt.templates.task_cell_class = function(task, date) {
			var dateToStr = gantt.date.date_to_str("%D");
			if (dateToStr(date) == "六" || dateToStr(date) == "日")
				return "week_end";
			return "";
		};
		gantt.templates.task_class = function(st, end, item) {
			return item.exceed == 1 ? "high" : ""
		};*/
		/*
		gantt.templates.rightside_text = function(start, end, task) {
			return "" + task.duration + '天'
		};
		*/

		gantt.config.work_time = false; //false为工作日也计算在内
		gantt.config.min_column_width = 40;

		//gantt.config.autofit = true;
		gantt.config.drag_progress = false;
		gantt.config.drag_links = false;
		gantt.config.readonly = !editable;
		gantt.config.scale_height = 60;
	},

	initProjectGantt: function(id, editable) {
		this.initBasicProjectGantt(id, editable)
		//按年为单位
		gantt.config.scale_unit = "year";
		gantt.config.subscales = [
			{ unit: "month", step: 1, template: this.monthScaleTemplate },
			//{ unit: "week", step: 1, template: this.projectWeekScaleTemplate, date:"%W" }, //确定是否要加week显示
		];
		//gantt.config.step = 1;
		gantt.config.date_scale = "%Y年";
		gantt.config.fit_tasks = true;
		gantt.config.round_dnd_dates = false;

		//切换编辑和只读模式
		if (editable) {
			gantt.config.columns = projectEditingColumns
		} else {
			gantt.config.columns = projectReadonlyColumns
		}

		gantt.templates.task_class = function(start, end, task) {
			var c = ''
			if (task.progress == 1) {
				c += ' finished'
			} else if (task.progress == 0) {
				c += ' not_start'
			} else {
				switch (task.status) {
					case "施工中":
						c += ' working'
						break
					case "已停工":
						c += ' pending'
						break
					case "已完工":
						c += ' finished'
						break
					case "未开工":
						c += ' not_start'
						break
				}
				if (task.exceed)
					c = ' exceed'
				if (task.delayed)
					c = ' delayed'
			}
			return c
		};
		gantt.init(id);
	},

	initPhaseGantt: function(id, editable) {
		this.initBasicProjectGantt(id, editable)
		gantt.templates.task_cell_class = function(task, date) {
			var dateToStr = gantt.date.date_to_str("%D");
			if (dateToStr(date) == "六" || dateToStr(date) == "日")
				return "week_end";
			return "";
		};
		gantt.templates.task_class = function(st, end, item) {
			return item.exceed == 1 ? "high" : ""
		};

		gantt.config.scale_unit = "month";
		gantt.config.step = 1;
		gantt.config.date_scale = "%Y %F";
		gantt.config.round_dnd_dates = true;

		gantt.config.subscales = [
			{ unit: "week", step: 1, template: this.weekScaleTemplate },
			{ unit: "day", step: 1, date: "%j", css: this.daysStyle }
		];

		gantt.config.drag_project = true; //Project自动计算并整体可拖拽

		//切换编辑和只读模式
		if (editable) {
			gantt.config.columns = phaseEditingColumns
		} else {
			gantt.config.columns = phaseReadonlyColumns
			gantt.templates.task_class = function(start, end, task) {
				var c = ''
				if (task.type == 'plan')
					c += ' plan'
				if (task.type == 'actual')
					c += ' actual'

				if (task.progress == 1) {
					c += ' finished'
				} else if (task.type != 'plan') {
					switch (task.status) {
						case "施工中":
							c += ' working'
							break
						case "已停工":
							c += ' pending'
							break
						case "已完工":
							c += ' finished'
							break
						case "未开工":
							c += ' not_start'
							break
					}
					if (task.delayed)
						c = ' delayed'
					if (task.exceed && task.status != '已停工')
						c = ' exceed'
				}
				return c
			};
		}


		gantt.config.font_width_ratio = 7;
		gantt.templates.leftside_text = function leftSideTextTemplate(start, end, task) {
			if (getTaskFitValue(task) === "left") {
				return task.text;
			}
			return "";
		};
		gantt.templates.rightside_text = function rightSideTextTemplate(start, end, task) {
			if (getTaskFitValue(task) === "right") {
				return task.text;
			}
			return "";
		};
		gantt.templates.task_text = function taskTextTemplate(start, end, task) {
			if (getTaskFitValue(task) === "center") {
				return task.text;
			}
			return "";
		};


		//Drag restriction
		/*
		gantt.attachEvent("onTaskDrag", function(id, mode, task, original, e) {
			var parent = task.parent ? gantt.getTask(task.parent) : null,
				children = gantt.getChildren(id),
				modes = gantt.config.drag_mode;

			var limitLeft = null,
				limitRight = null;

			if (!(mode == modes.move || mode == modes.resize)) return;

			if (mode == modes.move) {
				limitLeft = limitMoveLeft;
				limitRight = limitMoveRight;
			} else if (mode == modes.resize) {
				limitLeft = limitResizeLeft;
				limitRight = limitResizeRight;
			}

			//check parents constraints
			if (parent && +parent.end_date < +task.end_date) {
				limitLeft(task, parent);
			}
			if (parent && +parent.start_date > +task.start_date) {
				limitRight(task, parent);
			}

			//check children constraints
			for (var i = 0; i < children.length; i++) {
				var child = gantt.getTask(children[i]);
				if (+task.end_date < +child.end_date) {
					limitLeft(task, child);
				} else if (+task.start_date > +child.start_date) {
					limitRight(task, child)
				}
			}
		});
		*/

		gantt.init(id);
	},


	attachEvent(eventName, f) {
		var eventId = gantt.attachEvent(eventName, f)
		return eventId
	},
	detachEvent(eventId) {
		gantt.detachEvent(eventId)
	},
	gantt,
	//gantt.parse(tasks);
}
