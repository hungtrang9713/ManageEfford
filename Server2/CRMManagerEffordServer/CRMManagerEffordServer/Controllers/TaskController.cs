using CRMManagerEffordServer.App_Start;
using CRMManagerEffordServer.Models;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Drawing;
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
                listResult = this.DL.GetListData(new { Month = month, Year = year, UserID = Guid.Parse(Thread.CurrentPrincipal.Identity.Name) }, "dbo.Proc_SummaryTask_Month");
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
                        Week4 = item.Week4,
                        IsLead = item.IsLead
                    });
                }

                ExcelPackage excel = new ExcelPackage();
                var worksheet = excel.Workbook.Worksheets.Add("Sheet1");
                worksheet.Cells[1, 1].LoadFromCollection(listResult, true);
                var fileStream = new MemoryStream();
                BindingFormatForExcel(worksheet, listResult, month, year);
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
            catch (Exception e)
            {
            }

            return null;
        }
        /// <summary>
        /// format lại file báo cáo
        /// </summary>
        /// <param name="worksheet"></param>
        /// <param name="listItems"></param>
        private void BindingFormatForExcel(ExcelWorksheet worksheet, List<TaskExport> listItems, int month, int year)
        {
            // Set default width cho tất cả column
            //worksheet.DefaultColWidth = 80;
            worksheet.DefaultRowHeight = 24;
            // Tự động xuống hàng khi text quá dài
            //worksheet.Cells.Style.WrapText = true;
            // title
            worksheet.Cells["A1:J1"].Merge = true;
            worksheet.Cells["A1:J1"].Value = $"Bảng thống kê năng suất nhân viên tháng {month}/{year}";
            worksheet.Cells["A1:J1"].Style.Font.Size = 24;
            worksheet.Cells["A1:J1"].Style.Font.Bold = true;
            worksheet.Cells["A1:J1"].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
            worksheet.Cells["A1:J1"].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
            // Tạo header
            worksheet.Cells[2, 1].Value = "STT";
            worksheet.Cells[2, 2].Value = "Họ và Tên";
            worksheet.Cells[2, 3].Value = "Mã nhân viên";
            worksheet.Cells[2, 4].Value = "Tuần 1";
            worksheet.Cells[2, 5].Value = "Tuần 2";
            worksheet.Cells[2, 6].Value = "Tuần 3";
            worksheet.Cells[2, 7].Value = "Tuần 4";
            worksheet.Cells[2, 8].Value = "Tổng điểm";
            worksheet.Cells[2, 9].Value = "Số Effort";
            worksheet.Cells[2, 10].Value = "Ghi chú ";


            // Lấy range vào tạo format cho range đó ở đây là từ A1 tới D1
            using (var range = worksheet.Cells["A2:J2"])
            {
                // Set PatternType
                range.Style.Fill.PatternType = ExcelFillStyle.DarkGray;
                // Set Màu cho Background
                range.Style.Fill.BackgroundColor.SetColor(Color.Aqua);
                // Canh giữa cho các text
                range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                // Set Font cho text  trong Range hiện tại
                range.Style.Font.SetFromFont(new Font("Arial", 10));
                range.Style.Font.Bold = true;
                // Set Border
                range.Style.Border.Bottom.Style = ExcelBorderStyle.Thick;
                range.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                range.Style.Border.Right.Style = ExcelBorderStyle.Thin;
            }

            // Đỗ dữ liệu từ list vào 
            for (int i = 0; i < listItems.Count; i++)
            {
                var item = listItems[i];
                if (item.IsLead)
                {
                    // Format higlight
                    worksheet.Cells[i + 3, 2].Style.Font.Bold = true;

                }
                worksheet.Cells[i + 3, 1].Value = i + 1;
                worksheet.Cells[i + 3, 2].Value = item.FullName;
                worksheet.Cells[i + 3, 2].AutoFitColumns(30);
                worksheet.Cells[i + 3, 3].Value = item.UserName;
                worksheet.Cells[i + 3, 3].AutoFitColumns(15);
                worksheet.Cells[i + 3, 4].Value = item.Week1;
                worksheet.Cells[i + 3, 5].Value = item.Week2;
                worksheet.Cells[i + 3, 6].Value = item.Week3;
                worksheet.Cells[i + 3, 7].Value = item.Week4;
                worksheet.Cells[i + 3, 8].Value = item.Week1 + item.Week2 + item.Week3 + item.Week4;
                worksheet.Cells[i + 3, 9].Value = 1;
                worksheet.Cells[i + 3, 9].Style.Numberformat.Format = "0.00%";
                worksheet.Cells[i + 3, 10].Value = "";
                worksheet.Cells[i + 3, 10].AutoFitColumns(30);

            }
            var modelRows = listItems.Count() + 2;
            string modelRange = "A3:J" + modelRows.ToString();
            var modelTable = worksheet.Cells[modelRange];

            // Assign borders
            modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
            modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
            modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
            modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
            // thông tin người xuất 
            using (var rangeSignature = worksheet.Cells[modelRows + 3, 2, modelRows + 6, 10])
            {
                // Canh giữa cho các text
                rangeSignature.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                // Set Font cho text  trong Range hiện tại
                rangeSignature.Style.Font.SetFromFont(new Font("Arial", 10));
                rangeSignature.Style.Font.Bold = true;
                worksheet.Cells[modelRows + 3, 2].Value = "Người phê duyệt";
                worksheet.Cells[modelRows + 6, 2].Value = "Tạ Minh Ngọc";
                worksheet.Cells[modelRows + 3, 6].Value = "Người xem xét";
                worksheet.Cells[modelRows + 3, 10].Value = "Người lập";
                worksheet.Cells[modelRows + 6, 10].Value = "Nguyễn Đình Nghĩa";

            }
        }

        /// <summary>
        /// lấy dữ liệu theo tháng của nhân viên
        /// </summary>
        /// <param name="month"></param>
        /// <param name="year"></param>
        /// <param name="userID"></param>
        /// <returns></returns>
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
