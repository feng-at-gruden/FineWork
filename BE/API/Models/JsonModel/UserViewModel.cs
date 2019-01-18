using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models.JsonModel
{
    public class UserViewModel
    {
        /// <summary>
        /// 用户名
        /// </summary>
        /// 
        public string UserName { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string RealName { get; set; }

        /// <summary>
        /// 角色
        /// </summary>
        public List<string> Permissions { get; set; }
    }
}