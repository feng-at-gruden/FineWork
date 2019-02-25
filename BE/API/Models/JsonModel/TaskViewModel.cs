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
        public string task_name;
        public DateTime? start_date;
        public DateTime? end_date;
        public int duration;
        public decimal progress;
        public string status;
        public Int32 parent;
        public Int32 phaseId;
        public string type;
        public bool open;
        public string description;
        public string render;
        public bool exceed;     //逾期
        public bool delayed;    //延期
        public DateTime? actual_start;
        public DateTime? actual_end;
        public int actual_duration;
        public DateTime? last_update;
    }
}