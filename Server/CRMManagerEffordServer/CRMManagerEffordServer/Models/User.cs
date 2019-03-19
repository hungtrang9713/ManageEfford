using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.Models
{
    public class User : BaseEntity
    {
        public Guid UserID { get; set; } = Guid.NewGuid();

        public string UserName { get; set; }

        public string FullName { get; set; }

        public bool IsLead { get; set; }

        public string Password { get; set; }
    }
}