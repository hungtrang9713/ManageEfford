using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MISA.CRM.Models
{
    public class JobBooking
    {
        public Guid JobBookingID { get; set; }

        public Guid UserID { get; set; }

        public DateTime Date { get; set; }

        public JobBookingState WokingState { get; set; }
    }
}