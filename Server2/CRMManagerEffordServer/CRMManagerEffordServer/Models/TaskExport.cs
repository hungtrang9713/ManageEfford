using CRMManagerEffordServer.Util;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.Models
{
    public class TaskExport
    {

        public string FullName { get; set; }

        public string UserName { get; set; }
        public bool IsLead { get; set; }

        public decimal Week1 { get; set; }

        public decimal Week2 { get; set; }

        public decimal Week3 { get; set; }

        public decimal Week4 { get; set; }

        public decimal Total { get; set; }

        public string Note { get; set; }
    }
}