using MISA.CRM.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MISA.CRM.Controllers
{
  [RoutePrefix("JobBooking")]
  public class JobBookingController : BaseController<JobBooking>
  {
    [HttpPost]
    [Route("")]
    public IHttpActionResult Save(JobBooking jobBooking)
    {
      return Ok("ok");
    }
  }
}
