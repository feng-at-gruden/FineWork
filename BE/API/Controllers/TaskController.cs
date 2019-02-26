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
    [ApiAuthorize(Roles = Configurations.Permissions.PLAN_MANAGEMENT)]
    public class TaskController : BaseController
    {

        [HttpPost]
        public HttpResponseMessage Create([FromBody]TaskViewModel task)
        {
            var msg = ValidCreateRequest(task);
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
                    PlanStartDate = DateTime.Parse(task.start_date.Value.ToLocalTime().ToShortDateString()),
                    PlanEndDate = DateTime.Parse(task.end_date.Value.ToLocalTime().ToShortDateString()),
                    Progress = 0,
                    Status = string.IsNullOrWhiteSpace(task.status) ? Configurations.TASK_STATUS[0] : task.status,
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

                //Update parent task or phase status & progress
                var t = db.Task.SingleOrDefault(m=>m.Id==p.Id);
                if (t != null)
                {
                    var parentTask = t.ParentTask;
                    if (t.ParentTask == null && t.ParentTaskId > 0)
                    {
                        parentTask = db.Task.SingleOrDefault(m => m.Id == t.ParentTaskId);
                    }

                    //更新父节点的开始时间和结束时间
                    refreshParentsDuration(parentTask);

                    //重新计算父节点及阶段的进度和状态
                    refreshParentsProgress(parentTask);

                    //重新计算阶段的进度和状态
                    var phase = t.Phase;
                    if (phase == null && t.PhaseId > 0)
                    {
                        phase = db.Phase.SingleOrDefault(m => m.Id == t.PhaseId);
                    }
                    refreshPhaseProgress(phase);
                }
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
                var startDate = DateTime.Parse(task.start_date.Value.ToLocalTime().ToShortDateString());
                p.Name = task.text.Trim();
                //p.Progress = task.progress;
                p.Description = task.description;
                p.PlanStartDate = startDate;
                p.PlanEndDate = startDate.AddDays(task.duration);
                p.Status = task.status;

                var parentTask = p.ParentTask;
                if (p.ParentTask == null && p.ParentTaskId > 0)
                {
                    parentTask = db.Task.SingleOrDefault(m => m.Id == p.ParentTaskId);
                }

                //更新父节点的开始时间和结束时间
                refreshParentsDuration(parentTask);

                //重新计算父节点及阶段的进度和状态
                refreshParentsProgress(parentTask);

                //重新计算阶段的进度和状态
                var phase = p.Phase;
                if (phase == null && p.PhaseId > 0)
                {
                    phase = db.Phase.SingleOrDefault(m => m.Id == p.PhaseId);
                }
                refreshPhaseProgress(phase);
                
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
                var pId = p.ParentTaskId;
                var phaseId = p.PhaseId;
                var parentTask = db.Task.SingleOrDefault(m => m.Id == pId);
                
                db.Task.RemoveRange(GetChildrenTask(p));

                //更新父节点的开始时间和结束时间
                refreshParentsDuration(parentTask);

                //重新计算父节点及阶段的进度和状态
                refreshParentsProgress(parentTask);

                //重新计算阶段的进度和状态
                var phase = db.Phase.SingleOrDefault(m => m.Id == phaseId);
                refreshPhaseProgress(phase);

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

        private void refreshParentsDuration(Task parentTask)
        {
            if (parentTask != null && parentTask.ChildrenTasks.Count()>0)
            {
                var minStartDate = parentTask.ChildrenTasks.Min(t => t.PlanStartDate);
                var maxEndDate = parentTask.ChildrenTasks.Max(t => t.PlanEndDate);
                parentTask.PlanStartDate = minStartDate;
                parentTask.PlanEndDate = maxEndDate;

                if (parentTask.ParentTask != null)
                {
                    refreshParentsDuration(parentTask.ParentTask);
                }
            }
        }

        private void refreshParentsProgress(Task parentTask)
        {
            if (parentTask != null)
            {
                decimal done = 0;
                var all = 0;
                foreach (var t in parentTask.ChildrenTasks)
                {
                    var duration = (t.PlanEndDate.Value - t.PlanStartDate.Value).Days;
                    var progress = t.Progress.HasValue ? t.Progress.Value : 0;
                    all += duration;
                    done += duration * progress;
                }

                if (all > 0)
                {
                    parentTask.Progress = Math.Truncate((done / all) * 100m) * 0.01m;
                    if (parentTask.Status == Configurations.TASK_STATUS[0] && done > 0)
                        parentTask.Status = Configurations.TASK_STATUS[1];

                    if (parentTask.Progress >= 1)
                        parentTask.Status = Configurations.TASK_STATUS[3];

                    if (parentTask.ParentTask != null)
                        refreshParentsProgress(parentTask.ParentTask);
                }
                
            }
        }

        private void refreshPhaseProgress(Phase phase)
        {
            if (phase == null)
                return;

            decimal done = 0;
            var all = 0;
            foreach (var t in phase.Task)
            {
                var duration = (t.PlanEndDate.Value - t.PlanStartDate.Value).Days;
                var progress = t.Progress.HasValue ? t.Progress.Value : 0;
                all += duration;
                done += duration * progress;
            }

            if (all > 0)
            {
                if (phase.Status == Configurations.TASK_STATUS[0] && done > 0)
                    phase.Status = Configurations.TASK_STATUS[1];

                phase.Progress = Math.Truncate((done / all) * 100m) * 0.01m;
                if (phase.Progress >= 1)
                    phase.Status = Configurations.TASK_STATUS[3];
            }
            
        }



        private string ValidCreateRequest(TaskViewModel task)
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
