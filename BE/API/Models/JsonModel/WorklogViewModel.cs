using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models.JsonModel
{
    public class WorklogViewModel
    {
        public Int32 id;
        public DateTime? created_date;
        public DateTime? start_date;
        public decimal progress;
        public string status;
        public Int32 taskId;
        public string description;

    }
}
