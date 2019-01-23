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
            List<TaskViewModel> model = new List<TaskViewModel>();

            foreach (var t in phase.Task)
            {
                model = (List<TaskViewModel>)model.Concat(GetChildrenTask(t));
            }
            foreach(TaskViewModel i in model)
            {
                TimeSpan ts = new TimeSpan();
                ts = i.end_date.Value - i.start_date.Value;
                i.duration = ts.Days;
            }
            return Request.CreateResponse(HttpStatusCode.OK, model.ToArray());
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

            foreach (var row in task.ChildrenTasks)
            {
                result.Add(new TaskViewModel
                {
                    id = row.Id,
                    text = row.Name,
                    start_date = row.PlanStartDate.HasValue ? row.PlanStartDate : DateTime.Now,
                    end_date = row.PlanEndDate.HasValue ? row.PlanEndDate : DateTime.Now,
                    status = row.Status,
                    parent = task.Id,
                    phaseId = task.PhaseId.Value,
                    progress = row.Progress.Value,
                    type = row.ChildrenTasks.Count > 0 ? "project" : "task",
                    open = row.ChildrenTasks.Count > 0 ? true : false,
                });
                result.Concat(GetChildrenTask(row));
            }

            return result;
        }
    }
}
