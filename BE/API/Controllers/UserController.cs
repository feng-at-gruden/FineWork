using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using API.Filters;
using API.Models;
using API.Models.JsonModel;

namespace API.Controllers
{
    [RoutePrefix("API/User")]
    [ApiAuthorize]
    public class UserController : BaseController
    {
        [HttpPost]
        public HttpResponseMessage Create([FromBody]UserViewModel user)
        {
            var msg = ValidRequest(user);
            if (msg != "")
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse
                {
                    Success = false,
                    Message = msg
                });
            }
            else
            {
                var ou = db.User.SingleOrDefault(m => user.UserName.Equals(m.UserName, StringComparison.CurrentCultureIgnoreCase));
                if(ou != null)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse
                    {
                        Success = false,
                        Message = "系统账号名已存在，请重试！"
                    });
                }
                var permission = "";
                if (user.Permissions != null && user.Permissions.Length > 0)
                {
                    foreach (var p in user.Permissions)
                    {
                        if (!String.IsNullOrEmpty(p))
                            permission += p + ",";
                    }
                    if (permission.LastIndexOf(",") > 0)
                        permission = permission.Substring(0, permission.LastIndexOf(","));
                }
                var newuser = new User
                {
                    UserName = user.UserName,
                    RealName = user.RealName,
                    Mobile = user.Mobile,
                    Password = user.Password,
                    Permissions = permission
                };
                var u = db.User.Add(newuser);
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "系统账号建立成功。", Data = new { Id = u.Id } });
            }
        }


        [HttpGet]
        [Route("List")]
        public HttpResponseMessage List()
        {
            var users = (from row in db.User
                        orderby row.Id descending
                        select row).ToList();
            var model = from row in users
                        select new UserViewModel
                            {
                                Id = row.Id,
                                UserName = row.UserName,
                                RealName = row.RealName,
                                Mobile = row.Mobile,
                                Permissions = String.IsNullOrEmpty(row.Permissions)?new String[0]:row.Permissions.Split(','),
                                LastLogin = row.LastLoginAt.HasValue?row.LastLoginAt.Value.ToString("yyyy-MM-dd"):"",
                            };
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }


        [HttpPut]
        public HttpResponseMessage Edit(int id, [FromBody]UserViewModel user)
        {
            var msg = ValidRequest(user, false);
            if (msg != "")
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse
                {
                    Success = false,
                    Message = msg
                });
            }
            else
            {
                var ou = db.User.SingleOrDefault(m => user.UserName.Equals(m.UserName, StringComparison.CurrentCultureIgnoreCase));
                if (ou == null)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse
                    {
                        Success = false,
                        Message = "没有找到相关系统账号，请重试！"
                    });
                }
                var permission = "";
                if (user.Permissions != null && user.Permissions.Length > 0)
                {
                    foreach (var p in user.Permissions)
                    {
                        if(!String.IsNullOrEmpty(p))
                            permission += p + ",";
                    }
                    if (permission.LastIndexOf(",") > 0)
                        permission = permission.Substring(0, permission.LastIndexOf(","));
                }
                ou.RealName = user.RealName.Trim();
                ou.Mobile = user.Mobile.Trim();
                ou.Permissions = permission;
                if(!String.IsNullOrWhiteSpace(user.Password) && user.Password.IndexOf("******")<0)
                {
                    ou.Password = user.Password;
                }
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "系统账号修改成功。", Data = new { } });
            }
        }

        [HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            var p = db.User.SingleOrDefault(m => m.Id == id);
            if (p == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse { Success = false, Message = "没有找到相关系统账号，请重试。" });
            }
            else
            {
                db.User.Remove(p);
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "系统账号删除成功。" });
            }
        }


        private string ValidRequest(UserViewModel user, bool validatePassword=true)
        {
            if (String.IsNullOrWhiteSpace(user.UserName.Trim()))
                return "请输入登录账号";
            if (validatePassword && user.UserName.Trim().Length < 4)
                return "登录账号至少要4位字母";
            if (user.Password.Trim().Length < 4)
                return "密码至少要4位字母";
            return "";
        }


    }
}
