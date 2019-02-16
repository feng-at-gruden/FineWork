using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models
{
    public class Configurations
    {
        public const string SECRET_KEY = "FineWork is the most powerful online system";


        public class Permissions
        {
            public const string PROJECT_MANAGEMENT = "project-management";
            public const string PLAN_MANAGEMENT = "plan-management";
            public const string WORK_REPORT = "progress-management";
            public const string SYSTEM_MANAGEMENT = "system-management";
        }

        public static string[] TASK_STATUS = new string[4]{ "未开工", "施工中", "已停工", "已完工"};
    }
}