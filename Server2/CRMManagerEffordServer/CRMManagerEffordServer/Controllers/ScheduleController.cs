using CRMManagerEffordServer.App_Start;
using CRMManagerEffordServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Cors;

namespace CRMManagerEffordServer.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [RoutePrefix("Schedule")]
    [BasicAuthentication]
    public class ScheduleController : BaseController<JobBooking>
    {
        /// <summary>
        /// lấy danh sách các ngày nghỉ trong tháng
        /// </summary>
        /// <param name = "month" ></ param >
        /// < param name="year"></param>
        /// <param name = "userID" ></ param >
        /// < returns ></ returns >
        [HttpGet]
        [Route("{month}/{year}/{userID}")]
        public async Task<HttpResponseMessage> GetBookingJobMonth(int month, int year, Guid userID)
        {
            //tạo response
            HttpResponseMessage res = new HttpResponseMessage();
            List<JobBooking> listResult = null;
            try
            {
                listResult = this.DL.GetListData(new { Month = month, Year = year, UserID = userID}, "[dbo].[Proc_GetJobBookingMonth]");
                res = Request.CreateResponse(HttpStatusCode.OK,listResult);
            }
            catch (Exception ex)
            {
                res = Request.CreateResponse(ex.Message);
            }

            return await System.Threading.Tasks.Task.FromResult(res);
        }

    }
}
