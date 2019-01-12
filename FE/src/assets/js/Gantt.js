export default {

	weekScaleTemplate: function(date) {
		var dateToStr = gantt.date.date_to_str("%m月%d日");
		var endDate = gantt.date.add(gantt.date.add(date, 1, "week"), -1, "day");
		return dateToStr(date) + " - " + dateToStr(endDate);
	},

	daysStyle: function(date) {
		var dateToStr = gantt.date.date_to_str("%D");
		if (dateToStr(date) == "六" || dateToStr(date) == "日") return "week_end";

		return "";
	},

	initProjectGantt: function(id, editable) {
		gantt.templates.task_cell_class = function(task, date) {
			var dateToStr = gantt.date.date_to_str("%D");
			if (dateToStr(date) == "六" || dateToStr(date) == "日")
				return "week_end";
			return "";
		};
		gantt.templates.task_class = function(st, end, item) {
			return item.exceed == 1 ? "high" : ""
		};
		/*
		gantt.templates.rightside_text = function(start, end, task) {
			return "" + task.duration + '天'
		};
		*/

		//加入当天Marker
		var date_to_str = gantt.date.date_to_str(gantt.config.task_date);
		var today = new Date(2018, 3, 26);
		gantt.addMarker({
			start_date: today,
			css: "today",
			text: "Today",
			title: "Today: " + date_to_str(today)
		});



		gantt.config.work_time = false;
		gantt.config.scale_unit = "month";
		gantt.config.step = 1;
		gantt.config.date_scale = "%Y %F";
		gantt.config.min_column_width = 40;

		//gantt.config.autofit = true;
		gantt.config.drag_progress = false;
	    gantt.config.drag_links = false;
	    gantt.config.readonly = !editable;
		gantt.config.scale_height = 60;

		gantt.config.subscales = [
			{ unit: "week", step: 1, template: this.weekScaleTemplate },
			{ unit: "day", step: 1, date: "%j", css: this.daysStyle }
		];
		
		gantt.config.columns = [
			{ name: "text", label: "施工任务", tree: true, width: "*" },
			{
				name: "start_date",
				label: "施工周期",
				align: "center",
				width: "90",
				template(obj) {
					if (obj.progress > 0) {
						var str = '<div>' + obj.plan_start + " - " + obj.plan_end + '</div>'
						str = str + '<div ' + (obj.exceed ? 'class="project-delayed"' : '') + '>' + obj.actual_start + " - " + obj.actual_end + '</div>'
					} else {
						var str = '<div class="oneline">' + obj.plan_start + " - " + obj.plan_end + '</div>'
					}
					return '<div class="gantt-content-samll">' + str + '</div>'
				}
			},
			{
				name: "duration",
				label: "天",
				align: "center",
				width: "23",
				template(obj) {
					if (obj.progress > 0) {
						var str = '<div>' + obj.plan_duration + '</div>'
						str = str + '<div ' + (obj.exceed ? 'class="project-delayed"' : '') + '>' + obj.actual_duration + '</div>'
					} else {
						var str = '<div class="oneline">' + obj.plan_duration + '</div>'
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
					if (obj.status == "pending") {
						str = "停工"
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
		gantt.templates.task_class = function(start, end, task) {
			var c = ''
			if (task.type == 'plan')
				c += ' plan'
			if (task.type == 'actual')
				c += ' actual'

			if (task.progress == 1) {
				c += ' finished'
			} else {
				switch (task.status) {
					case "working":
						c += ' working'
						break
					case "pending":
						c += ' pending'
						break
					case "finished":
						c += ' finished'
						break
					case "not_start":
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
		gantt.attachEvent("onBeforeTaskDrag", function(id, mode, e) { var task = gantt.getTask(id); return !task.locked && task.progress != 1; });


		gantt.init(id);
	}

	//gantt.parse(tasks);
}
