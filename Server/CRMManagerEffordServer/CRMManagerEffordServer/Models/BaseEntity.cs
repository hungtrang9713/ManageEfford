using CRMManagerEffordServer.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.Models
{
    public class BaseEntity
    {
        public DateTime CreatedDate { get; set; } = DateTime.Today;

        public DateTime ModifiedDate { get; set; } = DateTime.Today;

        public string CreatedBy { get; set; }

        public string ModifiedBy { get; set; }

        public EntityState State { get; set; } = EntityState.None;
    }
}