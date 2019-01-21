using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models.JsonModel
{
    public class TaskViewModel
    {
        public Int32 id;
        public string text;
        public DateTime? start_date;
        public DateTime? end_date;
        public int duration;
        public decimal progress;
        public string status;
        public Int32 parent;
        public string type;
        public bool open;
        public string description;
    }
}