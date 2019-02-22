export default {


	initCalendar: function(id, startDate){
		scheduler.config.readonly = true;
		scheduler.config.xml_date="%Y-%m-%d %H:%i";
		scheduler.init(id, startDate, "month");
		
	},

	loadEvents: function(data){
		scheduler.clearAll();
		scheduler.parse(data, "json");
		if(data.length>0){
			scheduler.select(data[0].id);
		}
	},

	attachEvent: function(eventName, handler) {
		var id = scheduler.attachEvent(eventName, handler);
		return id;
	},

	detachEvent: function(eventId) {
		scheduler.detachEvent(eventId);
	}


}