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

        public float ProductivityScore { get; set; }

        public float PenaltyScore { get; set; }


        public float PlusScore { get; set; }

        public string Note { get; set; }

        public DateTime CreatedDate { get; set; } = DateTime.Today;

        public DateTime ModifiedDate { get; set; } = DateTime.Today;

        public Guid UserID { get; set; }
    }
}