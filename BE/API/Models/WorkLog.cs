//------------------------------------------------------------------------------
// <auto-generated>
//     此代码已从模板生成。
//
//     手动更改此文件可能导致应用程序出现意外的行为。
//     如果重新生成代码，将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace API.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class WorkLog
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public string Comment { get; set; }
        public Nullable<int> TaskId { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<int> CreatedBy { get; set; }
    
        public virtual Task Task { get; set; }
        public virtual User User { get; set; }
    }
}
