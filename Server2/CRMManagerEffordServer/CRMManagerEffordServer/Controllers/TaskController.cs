using CRMManagerEffordServer.App_Start;
using CRMManagerEffordServer.Models;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading;
using System.Web.Http;
using System.Web.Http.Cors;

namespace CRMManagerEffordServer.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [RoutePrefix("Task")]
    [BasicAuthentication]
    public class TaskController : BaseController<Task>
    {
        [HttpGet]
        [Route("{month}/{year}")]
        public IHttpActionResult SummaryTaskMonth(int month, int year)
        {
            List<Task> listResult = null;
            try
            {
                listResult = this.DL.GetListData(new { Month = month, Year = year, UserID = Guid.Parse(Thread.CurrentPrincipal.Identity.Name)}, "dbo.Proc_SummaryTask_Month");
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
        /// <summary>
        /// 
        /// </summary>
        /// <param name="month"></param>
        /// <param name="year"></param>
        /// <param name="userID"></param>
        /// <returns></returns>

        [HttpGet]
        [Route("export/{month}/{year}/{userID}")]
        public HttpResponseMessage ExportSummaryTaskMonth(int month, int year, Guid userID)
        {
            try
            {
                List<Task> listTemp = null;
                var listResult = new List<TaskExport>();

                listTemp = this.DL.GetListData(new { Month = month, Year = year, UserID = userID }, "dbo.Proc_SummaryTask_Month");
                foreach (var item in listTemp)
                {
                    listResult.Add(new TaskExport()
                    {
                        FullName = item.FullName,
                        UserName = item.UserName,
                        Week1 = item.Week1,
                        Week2 = item.Week2,
                        Week3 = item.Week3,
                        Week4 = item.Week4
                    });
                }

                ExcelPackage excel = new ExcelPackage();
                var worksheet = excel.Workbook.Worksheets.Add("Sheet1");
                worksheet.Cells[1, 1].LoadFromCollection(listResult, true);
                var fileStream = new MemoryStream();
                excel.SaveAs(fileStream);

                var result = new HttpResponseMessage(HttpStatusCode.OK)
                {
                    Content = new ByteArrayContent(fileStream.ToArray())
                };

                result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment")
                                                            {
                                                                FileName = $"Tong_ket_thang_{month}_{year}.xlsx"
                                                            };
                result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");

                return result;
            }
            catch (Exception)
            {
            }

            return null;
        }

        [HttpGet]
        [Route("dateworking/{month}/{year}/{userID}")]
        public IHttpActionResult GetDateWorkingMonth(int month, int year, Guid userID)
        {
            List<Task> listResult = null;
            try
            {
                listResult = this.DL.GetListData(new { Month = month, Year = year, UserID = userID }, "dbo.Proc_GetDateWorkingMonth");
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
