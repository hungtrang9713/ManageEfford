using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.Models
{
    public class User : BaseEntity
    {
        [Key]
        public Guid? UserID { get; set; }

        public string UserName { get; set; }

        public string FullName { get; set; }

        public bool IsLead { get; set; }
        public bool IsPM { get; set; }

        public string Password { get; set; }
        /// <summary>
        /// mã lead
        /// </summary>
        public Guid LeadID { get; set; }
    }
}