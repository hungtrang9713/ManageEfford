﻿using CRMManagerEffordServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace CRMManagerEffordServer.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]

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
    }
}