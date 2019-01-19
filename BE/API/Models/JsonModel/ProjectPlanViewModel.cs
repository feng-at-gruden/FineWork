using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models.JsonModel
{
    public class ProjectPlanViewModel
    {
        public Int32 id;
        public string name;
        public DateTime start_date;
        public DateTime end_date;
        public decimal progress;
        public string status;
        public TaskViewModel[] data;
        public object[] links;
    }
}