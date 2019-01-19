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
                            Status = row.Status,
                            Type = row.Type,
                            No = row.No,
                            Acreage = row.Acreage.Value,
                            Cost = row.Cost.Value,
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
                    CreatedBy = row.CreatedBy.Value,
                    CreatedDate = row.CreatedDate.Value,
                    Progress = row.Progress.Value,
                    StartDate = row.StartDate.Value,
                    EndDate = row.EndDate.Value,
                    Status = row.Status,
                    No = row.No,
                    WarrantNo = row.WarrantNo,
                    ContractNo = row.ContractNo,
                    ArchiveNo = row.ArchiveNo,
                    Acreage = row.Acreage.Value,
                    Cost = row.Cost.Value,
                    Location = row.Location,
                    FirstParty = row.FirstParty,
                    Type = row.Type,
                };
                return Request.CreateResponse(HttpStatusCode.OK, model);
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.NotFound, new APIResponse { Success = false, Message = "未找到相关项目信息，请重试。" });
            }           
        }

        [HttpGet]
        [Route("RawPlan")]
        public HttpResponseMessage RawPlan(int id)
        {
            var phase = from row in db.Phase
                        where row.ProjectId == id
                        select new TaskViewModel
                        {
                            id = row.Id,
                            text = row.Name,
                            start_date = row.StartDate,
                            end_date = row.EndDate,
                            status = row.Status,
                            parent = 0,
                            progress = row.Progress.Value,
                            type = "project",
                            open = true
                        };
            var p = db.Project.SingleOrDefault(m => m.Id == id);
            var model = new ProjectPlanViewModel
            {
                id = p.Id,
                name = p.Name,
                start_date = p.StartDate.Value,
                end_date = p.EndDate.Value,
                status = p.Status,
                progress = p.Progress.Value,
            };
            model.data = phase.ToArray();
            model.links = null;
            
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        [HttpGet]
        [Route("DetailedPlan")]
        public HttpResponseMessage DetailedPlan(int id)
        {
            var phase = from row in db.Phase
                        where row.ProjectId == id
                        select new TaskViewModel
                        {
                            id = row.Id,
                            text = row.Name,
                            start_date = row.StartDate,
                            end_date = row.EndDate,
                            status = row.Status,
                            parent = 0,
                            progress = row.Progress.Value,
                            type = "project",
                            open = true
                        };
            var p = db.Project.SingleOrDefault(m => m.Id == id);
            var model = new ProjectPlanViewModel
            {
                id = p.Id,
                name = p.Name,
                start_date = p.StartDate.Value,
                end_date = p.EndDate.Value,
                status = p.Status,
                progress = p.Progress.Value,
            };
            model.data = phase.ToArray();
            model.links = null;
            return Request.CreateResponse(HttpStatusCode.OK, model);
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
                var u = CurrentUser;
                var pp = db.Project.Add(new Project
                {
                    Name = project.Name,
                    Description = project.Description,
                    CreatedBy = u.Id,
                    CreatedDate = DateTime.Now,
                    Progress = 0,
                    StartDate = project.StartDate,
                    EndDate = project.EndDate,
                    Status = project.Status,
                    No = project.No,
                    WarrantNo = project.WarrantNo,
                    ContractNo = project.ContractNo,
                    ArchiveNo = project.ArchiveNo,
                    Acreage = project.Acreage,
                    Cost = project.Cost,
                    Location = project.Location,
                    FirstParty = project.FirstParty,
                    Type = project.Type,
                });
                string[] phase = project.Phase;
                foreach(string item in phase)
                {
                    db.Phase.Add(new Phase
                    {
                        ProjectId = pp.Id,
                        Name = item,
                        Progress = 0,
                        CreatedBy = u.Id,
                        CreatedDate = DateTime.Now,
                        Status = "未开工"
                    });
                }
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
                p.Status = project.Status;
                p.No = project.No;
                p.WarrantNo = project.WarrantNo;
                p.ContractNo = project.ContractNo;
                p.ArchiveNo = project.ArchiveNo;
                p.Acreage = project.Acreage;
                p.Cost = project.Cost;
                p.Location = project.Location;
                p.FirstParty = project.FirstParty;
                p.Type = project.Type;
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
