using API.Filters;
using API.Extensions;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System;
using Newtonsoft.Json.Linq;
using API.Models;
using API.Models.JsonModel;

namespace API.Controllers
{
    [RoutePrefix("API/Account")]
    [ApiAuthorize]
    public class AccountController : BaseController
    {
        /// <summary>
        /// 获取用户权限
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("Permissions")]
        public HttpResponseMessage Permissions()
        {
            var u = CurrentUser;
            int[] permissions = Array.ConvertAll<string, int>(u.Permissions.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries), s => s.StringToInt32()); ;
            var model = from row in db.Permission where permissions.Contains(row.Id)
                        select new 
            {
                Description = row.Description,
                Value = row.Value,
            };
            return Request.CreateResponse(HttpStatusCode.OK, model); ;
        }

        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage AccountInfo()
        {
            var u = CurrentUser;
            var userInfo = new UserViewModel
            {
                Id = u.Id,
                UserName = u.UserName,
                Mobile = u.Mobile,
                RealName = u.RealName,
                Permissions = u.Permissions!=null?u.Permissions.Split(','):null,
            };
            return Request.CreateResponse(HttpStatusCode.OK, userInfo);
        }

        /// <summary>
        /// 更新用户信息
        /// </summary>
        /// <returns></returns>
        [HttpPut]
        public HttpResponseMessage AccountInfo([FromBody]UserViewModel userInfo)
        {
            var u = CurrentUser;
            if(u.Id != userInfo.Id){
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse { Success = false, Message = "信息输入有误" });
            }

            u.Mobile = userInfo.Mobile.Trim();
            u.RealName = userInfo.RealName.Trim();
            if (!String.IsNullOrWhiteSpace(userInfo.Password) && userInfo.Password != u.Password)
            {
                u.Password = userInfo.Password;
            }
            db.SaveChanges();
            return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "更新成功" });
        }

        

    }
}
