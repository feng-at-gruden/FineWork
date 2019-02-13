using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models.JsonModel
{
    public class UserViewModel
    {

        public int Id { get; set; }

        /// <summary>
        /// 用户名
        /// </summary>
        /// 
        public string UserName { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string RealName { get; set; }


        public string Password { get; set; }


        public string Mobile { get; set; }


        public string LastLogin { get; set; }

        /// <summary>
        /// 角色
        /// </summary>
        public string[] Permissions { get; set; }
    }
}