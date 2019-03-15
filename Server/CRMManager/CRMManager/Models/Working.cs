using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MISA.CRM.Models
{
    public class Working
    {
        [Key]
        public Guid WorkingID { get; set; } = Guid.NewGuid();

        public string PBIID { get; set; }

        public string PBIName { get; set; }

        public decimal ProductivityScore { get; set; }

        public decimal PenaltyScore { get; set; }


        public decimal PlusScore { get; set; }

        public string Note { get; set; }

        public DateTime CreatedDate { get; set; } = DateTime.Today;

        public DateTime ModifiedDate { get; set; } = DateTime.Today;

        public Guid UserID { get; set; }

        public int Week { get; set; }

        public decimal Score { get; set; }

        public string FullName { get; set; }

        public string UserName { get; set; }

        public decimal Week1 { get; set; }

        public decimal Week2 { get; set; }

        public decimal Week3 { get; set; }

        public decimal Week4 { get; set; }
    }
}