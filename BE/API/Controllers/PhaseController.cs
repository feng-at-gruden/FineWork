using API.Filters;
using API.Models;
using API.Models.JsonModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace API.Controllers
{

    [RoutePrefix("API/Phase")]
    [ApiAuthorize]
    public class PhaseController : BaseController
    {

        /// <summary>
        /// /API/Phase/Plan?id=1
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("RawPlan")]
        public HttpResponseMessage RawPlan(int id)
        {
            var phase = db.Phase.SingleOrDefault(m => m.Id == id);
            if (phase == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound, new APIResponse
                {
                    Success = false,
                    Message = "没有找到相关项目阶段信息"
                });
            }
            List<TaskViewModel> data = new List<TaskViewModel>();
            foreach (var t in phase.Task)
            {
                data.AddRange(GetChildrenTask(t));
            }
            foreach (TaskViewModel i in data)
            {
                TimeSpan ts = new TimeSpan();
                ts = i.end_date.Value - i.start_date.Value;
                i.duration = ts.Days;
            }
            var model = new GanttViewModel{
                id = phase.Id,
                projectId = phase.ProjectId.Value,
                name = phase.Name,
                start_date = phase.StartDate.Value,
                end_date = phase.EndDate.Value,
                progress = phase.Progress.Value,
                status = phase.Status,
                data = data.ToArray(),
                links = null,
            };
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }


        [HttpGet]
        [Route("DetailPlan")]
        public HttpResponseMessage DetailPlan(int id)
        {
            var phase = db.Phase.SingleOrDefault(m => m.Id == id);
            if (phase == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound, new APIResponse
                {
                    Success = false,
                    Message = "没有找到相关项目阶段信息"
                });
            }
            List<TaskViewModel> data = new List<TaskViewModel>();
            foreach (var t in phase.Task)
            {
                data.AddRange(GetChildrenTask(t));
            }
            foreach (TaskViewModel i in data)
            {
                TimeSpan ts = new TimeSpan();
                ts = i.end_date.Value - i.start_date.Value;
                i.duration = ts.Days;
            }
            var model = new GanttViewModel
            {
                id = phase.Id,
                projectId = phase.ProjectId.Value,
                name = phase.Name,
                start_date = phase.StartDate.Value,
                end_date = phase.EndDate.Value,
                progress = phase.Progress.Value,
                status = phase.Status,
                data = data.ToArray(),
                links = null,
            };
            return Request.CreateResponse(HttpStatusCode.OK, model);
        }


        [HttpPost]
        public HttpResponseMessage Create([FromBody]TaskViewModel phase)
        {
            var msg = ValidCreatePhaseRequest(phase);
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
                var u = CurrentUser;
                var p = db.Phase.Add(new Phase {
                    Name = phase.text,
                    StartDate = phase.start_date.Value.ToLocalTime(),
                    EndDate = phase.end_date.Value.ToLocalTime(),
                    Progress = 0,
                    Status = string.IsNullOrWhiteSpace(phase.status)? Configurations.TASK_INIT_STATUS : phase.status,
                    CreatedBy = u.Id,
                    CreatedDate = DateTime.Now.ToLocalTime(),
                    ProjectId = phase.parent,
                    Description = phase.description
                });
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "项目阶段建立成功。", Data = new { Id = p.Id } });
            }
        }


        [HttpPut]
        public HttpResponseMessage Edit(int id, [FromBody]TaskViewModel phase)
        {
            var p = db.Phase.SingleOrDefault(t => t.Id == id);
            if (p != null)
            {
                p.Name = phase.text.Trim();
                p.Progress = phase.progress;
                p.Description = phase.description;
                p.StartDate = phase.start_date.Value.ToLocalTime();
                p.EndDate = phase.start_date.Value.ToLocalTime().AddDays(phase.duration);
                p.Status = phase.status;
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "项目阶段信息修改成功。" });
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse { Success = false, Message = "信息输入有误，请重试。" });
            }
        }


        [HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            var p = db.Phase.SingleOrDefault(m => m.Id == id);
            if (p == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse { Success = false, Message = "没有找到相关项目阶段信息，请重试。" });
            }
            else
            {
                db.Phase.Remove(p);
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "项目阶段删除成功。" });
            }
        }


        private string ValidCreatePhaseRequest(TaskViewModel task)
        {
            if (String.IsNullOrWhiteSpace(task.text))
                return "请输入项目阶段名称";
            if(task.parent<=0)
                return "请选择所属项目";
            if(task.start_date == null)
                return "请选择项目阶段开始日期";
            if (task.end_date == null)
                return "请选择项目阶段结束日期";

            return "";
        }


        private List<TaskViewModel> GetChildrenTask(Task task)
        {
            List<TaskViewModel> result = new List<TaskViewModel>();
            result.Add(new TaskViewModel
            {
                id = task.Id,
                text = task.Name,
                start_date = task.PlanStartDate.HasValue ? task.PlanStartDate : DateTime.Now,
                end_date = task.PlanEndDate.HasValue ? task.PlanEndDate : DateTime.Now,
                status = task.Status,
                parent = task.ParentTaskId.HasValue?task.ParentTaskId.Value:0,
                phaseId = task.PhaseId.Value,
                progress = task.Progress.Value,
                description = task.Description,
                type = task.ChildrenTasks.Count > 0 ? "project" : "task",
                open = task.ChildrenTasks.Count > 0 ? true : false,
            });
            foreach (var row in task.ChildrenTasks)
            {
                if(row.ChildrenTasks.Count>0)
                    result.AddRange(GetChildrenTask(row));
            }

            return result;
        }
    }
}
