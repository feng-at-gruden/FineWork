using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Models.JsonModel
{
    public class ProjectViewModel
    {
        public Int32 Id;
        public string Name;
        public string Description;
        public DateTime StartDate;
        public DateTime EndDate;
        public decimal Progress;
        public string Status;
        public string No;
        public string Type;
        public decimal Acreage;
        public decimal Cost;
        public string ContractNo;
        public string WarrantNo;
        public string ArchiveNo;
        public string Location;
        public string FirstParty;
        public string[] Phase;
        public Int32 CreatedBy;
        public DateTime CreatedDate;
    }
}