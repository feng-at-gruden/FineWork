using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models.JsonModel
{
    public class ProjectViewModel
    {
        public Int32 Id;
        public string Name;
        public string Description;
        public DateTime StartDate;
        public DateTime EndDate;
        public decimal Progress;
        public string Status;
    }
}