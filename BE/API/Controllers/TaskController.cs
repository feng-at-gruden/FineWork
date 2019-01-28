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

    [RoutePrefix("API/Task")]
    [ApiAuthorize]
    public class TaskController : BaseController
    {

        [HttpPost]
        public HttpResponseMessage Create([FromBody]TaskViewModel task)
        {
            var msg = ValidCreatePhaseRequest(task);
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
                var np = new Task
                {
                    Name = task.text,
                    PlanStartDate = task.start_date.Value.ToLocalTime(),
                    PlanEndDate = task.end_date.Value.ToLocalTime(),
                    Progress = 0,
                    Status = string.IsNullOrWhiteSpace(task.status) ? Configurations.TASK_INIT_STATUS : task.status,
                    CreatedBy = u.Id,
                    CreatedDate = DateTime.Now.ToLocalTime(),
                    PhaseId = task.phaseId,
                    ParentTaskId = null,
                    Description = task.description
                };
                if (task.parent > 0)
                    np.ParentTaskId = task.parent;
                else
                    np.ParentTaskId = null;

                var p = db.Task.Add(np);
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "任务建立成功。", Data = new { Id = p.Id } });
            }
        }


        [HttpPut]
        public HttpResponseMessage Edit(int id, [FromBody]TaskViewModel task)
        {
            var p = db.Task.SingleOrDefault(t => t.Id == id);
            if (p != null)
            {
                p.Name = task.text.Trim();
                p.Progress = task.progress;
                p.Description = task.description;
                p.PlanStartDate = task.start_date.Value.ToLocalTime();
                p.PlanEndDate = task.start_date.Value.ToLocalTime().AddDays(task.duration);
                p.Status = task.status;
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "任务修改成功。" });
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse { Success = false, Message = "任务信息输入有误，请重试。" });
            }
        }


        [HttpDelete]
        public HttpResponseMessage Delete(int id)
        {
            var p = db.Task.SingleOrDefault(m => m.Id == id);
            if (p == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse { Success = false, Message = "没有找到相关任务信息，请重试。" });
            }
            else
            {
                db.Task.RemoveRange(GetChildrenTask(p));
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "任务删除成功。" });
            }
        }


        private List<Task> GetChildrenTask(Task task)
        {
            List<Task> result = new List<Task>();
            result.Add(task);
            if (task.ChildrenTasks.Count > 0)
            {
                foreach (var t in task.ChildrenTasks)
                {
                    result.AddRange(GetChildrenTask(t));
                }
            }
            return result;
        }


        private string ValidCreatePhaseRequest(TaskViewModel task)
        {
            if (String.IsNullOrWhiteSpace(task.text))
                return "请输入任务名称";
            if (task.phaseId <= 0)
                return "请选择所属项目阶段";
            if (task.start_date == null)
                return "请选择任务开始日期";
            if (task.end_date == null)
                return "请选择任务结束日期";

            return "";
        }

    }
}
