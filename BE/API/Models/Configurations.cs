using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models
{
    public class Configurations
    {
        public const string SECRET_KEY = "FineWork is the most powerful online system";


        public class Permission
        {
            public const string CREATE_PROJECT = "Project-Create";
            public const string MANAGE_PROJECT_PLAN = "Project-Plan";
            public const string MANAGE_DEPARTMENT = "System-Department";
            public const string MANAGE_USER = "System-User";
        }

        public const string TASK_INIT_STATUS = "未开工";
    }
}