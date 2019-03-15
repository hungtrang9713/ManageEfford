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
        [Route("api/Working/Summary")]
        public IHttpActionResult SummaryWorking(WhereDate oWhere)
        {
            return Ok(blBase.GetListData<Working>(oWhere, "Proc_SummaryWorking"));
        }
        public class WhereDate
        {
            public DateTime FromDate { get; set; }

            public DateTime ToDate { get; set; }
        }

        [HttpPost]
        [Route("api/Working/Export")]
        public HttpResponseMessage Export(WhereDate oWhere)
        {
            var stream = blBase.ExportData(blBase.GetListData<Working>(oWhere, "Proc_SummaryWorking"));
            // processing the stream.

            var result = new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new ByteArrayContent(stream.ToArray())
            };
            result.Content.Headers.ContentDisposition =
                new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment")
                {
                    FileName = "CertificationCard.pdf"
                };
            result.Content.Headers.ContentType =
                new MediaTypeHeaderValue("application/octet-stream");

            return result;
        }

    }
}
