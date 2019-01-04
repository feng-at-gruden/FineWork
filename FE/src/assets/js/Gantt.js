export default {

	weekScaleTemplate :function(date) {
		var dateToStr = gantt.date.date_to_str("%m月%d日");
		var endDate = gantt.date.add(gantt.date.add(date, 1, "week"), -1, "day");
		return dateToStr(date) + " - " + dateToStr(endDate);
	},

	daysStyle : function(date) {
		var dateToStr = gantt.date.date_to_str("%D");
		if (dateToStr(date) == "六" || dateToStr(date) == "日") return "week_end";

		return "";
	},

	initProjectGantt : function(id) {
		gantt.templates.task_cell_class = function(task, date) {
			var dateToStr = gantt.date.date_to_str("%D");
			if (dateToStr(date) == "六" || dateToStr(date) == "日")
				return "week_end";
			return "";
		};
		gantt.templates.task_class = function(st, end, item) {
			return item.exceed == 1 ? "high" : ""
		};

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

		gantt.config.scale_height = 90;

		gantt.config.subscales = [
			{ unit: "week", step: 1, template: this.weekScaleTemplate },
			{ unit: "day", step: 1, date: "%j", css: this.daysStyle }
		];

		gantt.init(id);
		gantt.config.columns = [
			{ name: "text", label: "施工任务", tree: true, width: "180" },
			{ name: "start_date", label: "开始时间", align: "center" },
			{ name: "duration", label: "天", align: "center", width: "20" },
			{
				name: "progress",
				label: "状态",
				align: "center",
				template: function(obj) {
					if (obj.status == "pending")
						return "停工"

					if (obj.progress == 1) {
						return "已完工"
					} else if (obj.progress == 0) {
						return "未开工"
					} else {
						/*
				if (obj.exceed == 1){ 
                    return "已逾期"
                }else{
                    return "施工中"
                }*/
						return obj.progress * 100 + "%"
					}
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
	}

	//gantt.parse(tasks);
}
