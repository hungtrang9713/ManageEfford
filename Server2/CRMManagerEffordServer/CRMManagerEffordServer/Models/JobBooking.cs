using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.Models
{
    public class JobBooking : BaseEntity
    {
        [Key]
        public Guid JobBookingID { get; set; }
        public Guid UserID { get; set; }
        public DateTime Date { get; set; }
        public int WorkingState { get; set; }
    }
}
