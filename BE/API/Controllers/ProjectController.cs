using API.Filters;
using API.Models;
using API.Models.JsonModel;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace API.Controllers
{
    [RoutePrefix("api/Project")]
    [ApiAuthorize]
    public class ProjectController : BaseController
    {

        [HttpGet]
        [Route("List")]
        public HttpResponseMessage List()
        {
            var model = from row in db.Project
                        select new ProjectViewModel
                        {
                            Id = row.Id,
                            Name = row.Name,
                            Description = row.Description,
                            StartDate = row.StartDate.Value,
                            EndDate = row.EndDate.Value,
                            Progress = row.Progress.Value,
                            Status = row.Status
                        };
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        [HttpGet]
        public HttpResponseMessage Detail(int id)
        {
            var row = db.Project.SingleOrDefault(m => m.Id == id);
            if (row != null)
            {
                var model = new ProjectViewModel
                {
                    Id = row.Id,
                    Name = row.Name,
                    Description = row.Description,
                    StartDate = row.StartDate.Value,
                    EndDate = row.EndDate.Value,
                    Progress = row.Progress.Value,
                    Status = row.Status
                };
                return Request.CreateResponse(HttpStatusCode.OK, model);
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.NotFound, new APIResponse { Success = false, Message = "未找到相关项目信息，请重试。" });
            }           
        }

        [HttpPost]
        public HttpResponseMessage Create([FromBody]ProjectViewModel project)
        {
            if (!String.IsNullOrWhiteSpace(project.Name))
            {
                var p = db.Project.SingleOrDefault(m => project.Name.Equals(m.Name, StringComparison.CurrentCultureIgnoreCase));
                if (p != null)
                {
                    return Request.CreateResponse(HttpStatusCode.Conflict, new APIResponse { Success = false, Message = "已存在同名的项目，请重试。" });
                }
                var c = CurrentUser;
                var pp = db.Project.Add(new Project
                {
                    Name = project.Name,
                    Description = project.Description,
                    CreatedBy = c.Id,
                    CreatedDate = DateTime.Now,
                    Progress = 0,
                    StartDate = project.StartDate,
                    EndDate = project.EndDate,
                    Status = project.Status,
                });
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "项目建立成功。", Data = new { Id = pp.Id} });
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse { Success = false, Message = "输入信息有误，请重试。" });
            }
        }

        [HttpPut]
        public HttpResponseMessage Edit(int id, [FromBody]ProjectViewModel project)
        {
            if (!String.IsNullOrWhiteSpace(project.Name) && id>0)
            {
                var p = db.Project.SingleOrDefault(m => m.Id==id);
                if (p == null)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse { Success = false, Message = "没有找到相关项目，请重试。" });
                }
                var c = CurrentUser;
                p.Name = project.Name;
                p.Description = project.Description;
                p.StartDate = project.StartDate;
                p.EndDate = project.EndDate;
                //p.Progress = project.Progress;  自动计算
                p.Status = project.Status;
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "项目信息修改成功。" });
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse { Success = false, Message = "输入信息有误，请重试。" });
            }
        }

        [HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            var p = db.Project.SingleOrDefault(m => m.Id == id);
            if (p == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse { Success = false, Message = "没有找到相关项目，请重试。" });
            }
            else
            {
                db.Project.Remove(p);
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "项目删除成功。" });
            }
        }

    }



}
