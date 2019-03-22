using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.Models
{
    public class Enumeration
    {
        public enum WorkingState
        {
            AllDay = 0,
            Morning = 1,
            Afternoon = 2,
            NotWorking = 3,
            NoRegister = 4
        }
    }
}
