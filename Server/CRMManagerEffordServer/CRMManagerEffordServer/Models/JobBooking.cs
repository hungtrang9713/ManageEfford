using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.Models
{
  public class JobBooking
  {
    public Guid? JobBookingID { get; set; }
    public Guid? UserID { get; set; }
    public string Date { get; set; }
    public int? WorkingState { get; set; }
  }
}
