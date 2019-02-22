export default {


	initCalendar: function(id){
		scheduler.config.readonly = true;
		scheduler.config.xml_date="%Y-%m-%d %H:%i";
		scheduler.init(id, new Date(), "month");
		
	},

	loadEvents: function(data){
		scheduler.parse(data, "json");
	}
}