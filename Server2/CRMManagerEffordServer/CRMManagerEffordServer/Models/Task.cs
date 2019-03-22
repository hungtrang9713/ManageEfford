using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.Models
{
    public class Task : BaseEntity
    {
        [Key]
        public Guid TaskID { get; set; }

        public string PBI { get; set; }

        public string TaskName { get; set; }

        public decimal EffortScore { get; set; }

        public decimal MinusScore { get; set; }

        public decimal FinalScore { get; set; }

        public string Note { get; set; }

        public Guid UserID { get; set; }

        public int Week { get; set; }

        public DateTime DateWorking { get; set; } = DateTime.Today;

        public string FullName { get; set; }

        public string UserName { get; set; }

        public decimal Week1 { get; set; }

        public decimal Week2 { get; set; }

        public decimal Week3 { get; set; }

        public decimal Week4 { get; set; }

        public decimal Total { get; set; }
    }
}