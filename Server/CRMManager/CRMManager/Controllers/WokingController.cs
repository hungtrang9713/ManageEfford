using MISA.CRM.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.Http;
using System.Web.Http.Cors;

namespace MISA.CRM.Controllers
{
  public class WokingController : BaseController<Working>
  {
    [HttpGet]
    [Route("api/Working/Summary/{month}")]
    public IHttpActionResult SummaryWorking(int month)
    {
      return Ok(blBase.GetListData<Working>(new { month = month }, "Proc_SummaryWorking"));
    }
    public class WhereDate
    {
      public DateTime FromDate { get; set; }

      public DateTime ToDate { get; set; }
    }

    [HttpGet]
    [Route("api/Working/Export/{month}")]
    public HttpResponseMessage Export(int month)
    {
      var stream = blBase.ExportData(blBase.GetListData<Working>(new { month = month }, "Proc_SummaryWorking"));
      // processing the stream.

      var response = new HttpResponseMessage(HttpStatusCode.OK);

      response.Content = new StreamContent(stream);
      //OR
      //Create a file on the fly and get file data as a byte array and send back to client
      response.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment");
      response.Content.Headers.ContentDisposition.FileName = "test.xlsx";//your file Name- text.xls
      response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      response.Content.Headers.ContentLength = stream.Length;
      response.StatusCode = System.Net.HttpStatusCode.OK;

      return response;
    }

  }
}
