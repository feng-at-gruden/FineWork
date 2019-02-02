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
    [RoutePrefix("API/Worklog")]
    [ApiAuthorize]
    public class WorklogController : BaseController
    {

        [HttpPost]
        public HttpResponseMessage Create([FromBody]WorklogViewModel worklog)
        {
            var msg = ValidCreateRequest(worklog);
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
                //0. 判断task是否存在
                var task = db.Task.SingleOrDefault(m => m.Id == worklog.taskId);
                if (task == null)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse
                    {
                        Success = false,
                        Message = "没有找到相关任务信息"
                    });
                }

                //1. 添加worklog db记录
                var n = db.WorkLog.Add(new WorkLog {
                     CreatedBy = u.Id,
                     TaskId = worklog.taskId,
                     CreatedDate = worklog.created_date.HasValue? worklog.created_date.Value.ToLocalTime() : DateTime.Now.ToLocalTime(),
                     Description = worklog.description,
                });

                //2. 更新worklog所属task的进度，开工日期，结束日期，状态，
                if (worklog.status == Configurations.TASK_STATUS[3] && task.Status!= Configurations.TASK_STATUS[3])
                {
                    //已完工
                    task.ActualEndDate = DateTime.Parse(worklog.created_date.Value.ToShortDateString());
                }

                if (task.ActualStartDate == null && worklog.status == Configurations.TASK_STATUS[1])
                {
                    //"施工中
                    if (worklog.start_date.HasValue)
                        task.ActualStartDate = DateTime.Parse(worklog.start_date.Value.ToShortDateString());    // 忽略小时
                    else
                        task.ActualStartDate = DateTime.Parse(worklog.created_date.Value.ToShortDateString());  // 忽略小时
                }
                task.Progress = worklog.progress;
                task.Status = worklog.status;

                //3. 判断当前task的父节点是task还是phase，
                //4. 判断当前task所属的父节点是否已经开工。 未开工则更新父节点的最小的actual start date.
                //5 根据父节点下所有task的状态更新父节点的状态和进度。
                //6. 如果依次递归父节点也未开工，则同上。

                refreshParentsProgress(task);
                refreshPhaseProgress(task.Phase);

                db.SaveChanges();

                return Request.CreateResponse(HttpStatusCode.OK, new APIResponse { Success = true, Message = "任务进度更新成功。", Data = new { Id = n.Id } });
            }
        }


        private string ValidCreateRequest(WorklogViewModel task)
        {
            if (String.IsNullOrWhiteSpace(task.description))
                return "请输工作日志描述";
            if (task.taskId <= 0)
                return "请选择所属任务";
            if (task.created_date == null)
                return "请选择工作日志所属时间";
           
            return "";
        }


        private void refreshParentsProgress(Task task)
        {
            if (task.ParentTask != null)
            {
                decimal done = 0;
                var all = 0;
                foreach(var t in task.ParentTask.ChildrenTasks)
                {
                    var duration = (t.PlanEndDate.Value - t.PlanStartDate.Value).Days;
                    var progress = t.Progress.HasValue ? t.Progress.Value : 0;
                    all += duration;
                    done += duration * progress;
                }
                task.ParentTask.Progress = Math.Round(done / all, 2);
                if (task.ParentTask.Status == Configurations.TASK_STATUS[0] && done > 0)
                    task.ParentTask.Status = Configurations.TASK_STATUS[1];

                if (task.ParentTask.ParentTask != null)
                    refreshParentsProgress(task.ParentTask);
            }
        }

        private void refreshPhaseProgress(Phase phase)
        {
            decimal done = 0;
            var all = 0;
            foreach (var t in phase.Task)
            {
                var duration = (t.PlanEndDate.Value - t.PlanStartDate.Value).Days;
                var progress = t.Progress.HasValue ? t.Progress.Value : 0;
                all += duration;
                done += duration * progress;
            }
            phase.Progress = Math.Round(done / all, 2);
            if (phase.Status == Configurations.TASK_STATUS[0] && done > 0)
                phase.Status = Configurations.TASK_STATUS[1];
        }

    }
}
