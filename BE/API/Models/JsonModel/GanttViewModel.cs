using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models.JsonModel
{
    public class GanttViewModel
    {
        public int id;
        public int projectId;
        public string name;
        public DateTime start_date;
        public DateTime end_date;
        public string status;
        public decimal progress;

        public TaskViewModel[] data;
        public object[] links;
    }
}