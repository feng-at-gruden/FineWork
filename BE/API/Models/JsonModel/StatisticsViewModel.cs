using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models.JsonModel
{
    public class StatisticsViewModel
    {
        public int Id { get; set; }
        public string Name;

        public int TaskCount;           //任务总数
        public int FinishedCount;       //已完成
        public int UnfinishedCount;     //未完成
        public int WorkingCount;        //施工中
        public int PendingCount;        //停工中
        public int FulfilAheadCount;    //提前完成
        public int DelayedCount;        //延期开工未开工任务数
        public int ExceededCount;       //逾期未完成任务数
        

        public DateTime StartDate;
        public DateTime EndDate;
        public int Duration;
        
        public DateTime? ActualStart;
        public DateTime? ActualEnd;
        public int ActualDuration;

        public decimal Progress;
        public string Status;
        public DateTime? LastUpdate;
    }
}