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
                return Request.CreateResponse(HttpStatusCode.BadRequest, new APIResponse
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
            foreach (var t in phase.Task.Where(t=>t.ParentTaskId==null))
            {
                data.AddRange(CalculateChildrenTasks(t));
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
        [ApiAuthorize(Roles = Configurations.Permissions.PROJECT_MANAGEMENT)]
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
                    StartDate = DateTime.Parse(phase.start_date.Value.ToLocalTime().ToShortDateString()),
                    EndDate = DateTime.Parse(phase.end_date.Value.ToLocalTime().ToShortDateString()),
                    Progress = 0,
                    Status = string.IsNullOrWhiteSpace(phase.status)? Configurations.TASK_STATUS[0] : phase.status,
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
        [ApiAuthorize(Roles = Configurations.Permissions.PROJECT_MANAGEMENT)]
        public HttpResponseMessage Edit(int id, [FromBody]TaskViewModel phase)
        {
            var p = db.Phase.SingleOrDefault(t => t.Id == id);
            if (p != null)
            {
                var startDate = DateTime.Parse(phase.start_date.Value.ToLocalTime().ToShortDateString());
                p.Name = phase.text.Trim();
                //p.Progress = phase.progress;
                p.Description = phase.description;
                p.StartDate = startDate;
                p.EndDate =startDate.AddDays(phase.duration);
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
        [ApiAuthorize(Roles = Configurations.Permissions.PROJECT_MANAGEMENT)]
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
            var c = new TaskViewModel
            {
                id = task.Id,
                text = task.Name,
                start_date = task.PlanStartDate,
                end_date = task.PlanEndDate,
                actual_start = task.ActualStartDate.HasValue ? task.ActualStartDate.Value.ToString("yyyy-MM-dd") : "",
                actual_end = task.ActualEndDate.HasValue ? task.ActualEndDate.Value.ToString("yyyy-MM-dd") : "",
                status = task.Status,
                parent = task.ParentTaskId.HasValue ? task.ParentTaskId.Value : 0,
                phaseId = task.PhaseId.Value,
                progress = task.Progress.Value,
                description = task.Description,
                type = task.ChildrenTasks.Count > 0 ? "project" : "task",
                open = task.ChildrenTasks.Count > 0 ? true : false,
            };
            if (c.type != "project" && c.progress<1)
            {
                var nowTime = DateTime.Parse(DateTime.Now.ToLocalTime().ToShortDateString()); //忽略小时
                if (task.ActualStartDate == null)
                {
                    //没开工
                    if (task.PlanStartDate.Value < nowTime)
                    {
                        //延期
                        c.delayed = true;
                    }
                    if (task.PlanEndDate.Value < nowTime)
                    {
                        //逾期
                        c.exceed = true;
                    }
                }
                else
                {
                    //已开工
                    var latestWorkDate = task.WorkLog.Max(m => m.CreatedDate); 
                    if (!latestWorkDate.HasValue)
                    {
                        //异常， 任务已经开始，但是没有找到相关工作日志？
                        latestWorkDate = task.ActualStartDate;
                    }
                    if (task.ActualStartDate.Value < task.PlanStartDate.Value)
                    {
                        //延期
                        c.delayed = true;
                    }
                    if (latestWorkDate > task.PlanEndDate.Value)
                    {
                        //逾期
                        c.exceed = true;
                    }
                    c.last_update = latestWorkDate.Value.ToString("yyyy-MM-dd");
                }
            }

            if (c.progress == 1 && task.ActualStartDate.HasValue && task.ActualEndDate.HasValue && c.type != "project")
            {
                //已完工                
                var latestWorkDate = task.WorkLog.Max(m => m.CreatedDate);
                if (!latestWorkDate.HasValue)
                {
                    //异常， 任务已经开始，但是没有找到相关工作日志？
                    latestWorkDate = task.ActualEndDate;
                }
                c.last_update = latestWorkDate.Value.ToString("yyyy-MM-dd");
                c.actual_duration = (task.ActualEndDate.Value - task.ActualStartDate.Value).Days;
            }
            result.Add(c);
            /*
            foreach (var row in task.ChildrenTasks)
            {
                if(row.ChildrenTasks.Count>0)
                    result.AddRange(GetChildrenTask(row));
            }*/
            return result;
        }
       
        private List<TaskViewModel> CalculateChildrenTasks(Task task)
        {
            List<TaskViewModel> result = new List<TaskViewModel>();
            bool notStartAndNotDelay = false;

            if (task.ChildrenTasks.Count > 0)
            {
                //父节点，普通处理
                var parentTask = new TaskViewModel
                {
                    id = task.Id,
                    text = task.Name,
                    status = task.Status,
                    parent = task.ParentTaskId.HasValue ? task.ParentTaskId.Value : 0,
                    phaseId = task.PhaseId.Value,
                    progress = task.Progress.Value,
                    description = task.Description,
                    type = "project",
                    open = true,
                };
                /*
                var st1 = task.ChildrenTasks.Min(m => m.PlanStartDate);
                var st2 = task.ChildrenTasks.Where(m=> m.ActualStartDate != null).Min(m => m.ActualStartDate);
                var ed1 = task.ChildrenTasks.Max(m => m.PlanEndDate);
                var ed2 = task.ChildrenTasks.Where(m => m.ActualEndDate != null).Max(m => m.ActualEndDate);
                parentTask.start_date = st2 == null? st1 : (st1<st2 ? st1 : st2);
                parentTask.end_date = ed2 == null ? ed1 : (ed1 > ed2 ? ed1 : ed2);
                parentTask.duration = (parentTask.end_date.Value - parentTask.start_date.Value).Days;
                */
                result.Add(parentTask);
            }
            else
            {
                var nowTime = DateTime.Parse(DateTime.Now.ToLocalTime().ToShortDateString()); //忽略小时

                //1. Add split fack task
                var holderTask = new TaskViewModel
                {
                    id = task.Id,
                    text = task.Name,
                    phaseId = task.PhaseId.Value,
                    progress = task.Progress.Value,
                    status = task.Status,
                    parent = task.ParentTaskId.HasValue ? task.ParentTaskId.Value : 0,
                    description = task.Description,
                    render = "split",
                    start_date = task.PlanStartDate,
                    end_date = task.PlanEndDate,
                    duration = (task.PlanEndDate.Value - task.PlanStartDate.Value).Days,
                    //open = task.ChildrenTasks.Count > 0 ? true : false,
                };
                //2. Add plan task
                var planTask = new TaskViewModel
                {
                    id = task.Id * 1000000,       //fack id
                    text = "",
                    phaseId = task.PhaseId.Value,
                    progress = 0,
                    status = task.Status,
                    parent = holderTask.id,
                    description = task.Description,
                    start_date = task.PlanStartDate,
                    end_date = task.PlanEndDate,
                    duration = (task.PlanEndDate.Value - task.PlanStartDate.Value).Days,
                    type = "plan",
                };
                //3. Add actual task
                var actualTask = new TaskViewModel
                {
                    id = task.Id * 1000000 + 1,       //fack id
                    phaseId = task.PhaseId.Value,
                    progress = task.Progress.Value,
                    status = task.Status,
                    parent = holderTask.id,
                    description = task.Description,
                    type = "actual",
                    //start_date = task.ActualStartDate,
                    //end_date = task.ActualEndDate,
                    //duration = (task.ActualEndDate.Value - task.ActualStartDate.Value).Days
                };

                //4. Calculate display value
                if(task.ActualStartDate==null)
                {
                    //没开工
                    if (task.PlanStartDate.Value < nowTime)
                    {
                        //延期
                        var duration = (nowTime - task.PlanStartDate.Value).Days;
                        actualTask.start_date = planTask.start_date;
                        actualTask.end_date = planTask.end_date;
                        actualTask.text = "已延期" + duration + "天";
                        actualTask.delayed = true;
                        actualTask.duration = planTask.duration;
                    }
                    else
                    {
                        planTask.text = Configurations.TASK_STATUS[0];
                        notStartAndNotDelay = true;
                    }
                    holderTask.delayed = actualTask.delayed;
                }
                else
                {
                    actualTask.start_date = task.ActualStartDate;
                    if (task.Progress.Value >= 1)
                    {
                        //已完工
                        actualTask.text = Configurations.TASK_STATUS[3];
                        actualTask.end_date = task.ActualEndDate;
                        actualTask.duration = (task.ActualEndDate.Value - task.ActualStartDate.Value).Days;
                    }
                    else if(task.Status== Configurations.TASK_STATUS[2])    //已停工
                    {
                        //考虑停工后复工的显示方式
                        //Get last day from work log
                        var latestWorkDate = task.WorkLog.Max(m => m.CreatedDate);
                        //actualTask.end_date = latestWorkDate;
			            actualTask.end_date = DateTime.Parse(latestWorkDate.Value.ToShortDateString()).AddDays(1);
                        actualTask.duration = (actualTask.end_date.Value - task.ActualStartDate.Value).Days;
                        var pendingDays = (nowTime - latestWorkDate.Value).Days;
                        actualTask.text  = Configurations.TASK_STATUS[2] + pendingDays + "天";
                        if (nowTime > task.PlanEndDate.Value)
                        {
                            actualTask.exceed = true;
                        }
                    }
                    else
                    {
                        //施工中
                        //Get last day from work log
                        var latestWorkDate = task.WorkLog.Max(m => m.CreatedDate); //task.ActualStartDate.Value.AddDays(7);
                        if(!latestWorkDate.HasValue)
                        {
                            //异常， 任务已经开始，但是没有找到相关工作日志？
                            latestWorkDate = task.ActualStartDate;
                        }
                        actualTask.end_date = DateTime.Parse(latestWorkDate.Value.ToShortDateString()).AddDays(1);
                        actualTask.duration = (actualTask.end_date.Value - task.ActualStartDate.Value).Days;

                        if (task.ActualStartDate>task.PlanStartDate){
                            //延期
                            actualTask.text = "已延期" + (task.ActualStartDate.Value - task.PlanStartDate.Value).Days + "天";
                            if(latestWorkDate>task.PlanEndDate)
                            {
                                //延期并逾期
                                actualTask.text += "逾期" + calculateExceedDays(actualTask.end_date, task.PlanEndDate) + "天";
                                actualTask.exceed = true;
                                actualTask.delayed = true;
                            }
                            else
                            {
                                //正常状态
                                actualTask.text = Configurations.TASK_STATUS[1];    // "施工中";
                            }
                        }
                        else
                        {
                            //提前或正常开工
                            if (actualTask.end_date > task.PlanEndDate)
                            {
                                //逾期
                                actualTask.text = "已逾期" + calculateExceedDays(actualTask.end_date, task.PlanEndDate) + "天";
                                actualTask.exceed = true;
                            }
                            else
                            {
                                //正常状态
                                actualTask.text = Configurations.TASK_STATUS[1];    // "施工中";
                            }
                        }
                    }
                    holderTask.actual_start = actualTask.start_date.Value.ToString("yyyy/MM/dd");
                    holderTask.actual_end = actualTask.end_date.Value.ToString("MM/dd");
                    holderTask.actual_duration = actualTask.duration;
                    holderTask.exceed = actualTask.exceed;
                    holderTask.delayed = actualTask.delayed;
                }

                result.Add(holderTask);
                result.Add(planTask);
                if(!notStartAndNotDelay)
                    result.Add(actualTask);
            }

            foreach (var row in task.ChildrenTasks)
            {
                result.AddRange(CalculateChildrenTasks(row));
            }
            return result;
        }


        private int calculateExceedDays(DateTime? lastWorkDate, DateTime? planEndDate)
        {
            var exceedSpan = lastWorkDate.Value - planEndDate.Value;
            var exceedDays = (int)Math.Ceiling((decimal)exceedSpan.TotalHours / 24);
            return exceedDays;
        }

    }
}
