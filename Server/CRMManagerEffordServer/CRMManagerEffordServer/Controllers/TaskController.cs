using CRMManagerEffordServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CRMManagerEffordServer.Controllers
{
    [RoutePrefix("Task")]
    public class TaskController : BaseController<Task>
    {
        [HttpGet]
        [Route("{month}/{year}")]
        public IHttpActionResult SummaryTaskMonth(int month, int year)
        {
            List<Task> listResult = null;
            try
            {
                listResult = this.DL.GetListData(new { Month = month, Year = year }, "dbo.Proc_SummaryTask_Month");
            }
            catch (Exception)
            {
                return InternalServerError();
            }

            return Ok(listResult);
        }

        [HttpGet]
        [Route("{month}/{year}/{userID}")]
        public IHttpActionResult SummaryTaskWeek(int month, int year, Guid userID)
        {
            List<Task> listResult = null;
            try
            {
                listResult = this.DL.GetListData(new { Month = month, Year = year, UserID = userID }, "dbo.Proc_SummaryTask_Week");
            }
            catch (Exception)
            {
                return InternalServerError();
            }

            return Ok(listResult);
        }

        [HttpGet]
        [Route("dateworking/{month}/{year}")]
        public IHttpActionResult GetDateWorkingMonth(int month, int year)
        {
            List<Task> listResult = null;
            try
            {
                listResult = this.DL.GetListData(new { Month = month, Year = year }, "dbo.Proc_GetDateWorkingMonth");
            }
            catch (Exception)
            {
                return InternalServerError();
            }

            return Ok(listResult);
        }

        [HttpGet]
        [Route("day/{date}/{userID}")]
        public IHttpActionResult GetTaskDay(DateTime date, Guid userID)
        {
            List<Task> listResult = null;
            try
            {
                listResult = this.DL.GetListData(new { DateWorking = date, UserID = userID }, "dbo.Proc_GetTask_Day");
            }
            catch (Exception)
            {
                return InternalServerError();
            }

            return Ok(listResult);
        }
    }
}
