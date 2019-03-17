using MISA.CRM.MANAGER.DL;
using MISA.CRM.Models;
using OfficeOpenXml;
using OfficeOpenXml.Table;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace MISA.CRM.MANAGER.BL
{
  /// <summary>
  /// Xử lý dữ liệu, nghiệp vụ trước khi cất vào DB
  /// </summary>
  public class BLBase
  {
    #region Declaration
    private DLBase _dl;
    #endregion

    #region Property
    // Khởi tọa đối tượng DL
    public DLBase DL
    {
      get
      {
        if (_dl == null)
        {
          _dl = new DLBase();
        }
        return _dl;
      }
      private set { }
    }
    #endregion

    #region Method
    /// <summary>
    /// Thực hiện Cất dữ liệu vào DB
    /// </summary>
    /// <param name="data">Dữ liệu</param>
    /// <param name="dataType">Kiểu của dữ liệu</param>
    /// <returns>Đổi tượng trả về từ store cất</returns>
    /// created by: dtthao - 08.12.2018
    public int SaveData(object data, Type dataType)
    {
      return DL.InsertObjectToDB(data, dataType);
    }

    public List<T> GetListData<T>(object param, string procName)
    {
      return this.DL.GetListData<T>(param, procName);
    }

    public Stream ExportData<T>(IEnumerable<T> data)
    {
      using (var excelPackage = new ExcelPackage(new MemoryStream()))
      {
        // Tạo author cho file Excel
        excelPackage.Workbook.Properties.Author = "Hanker";
        // Tạo title cho file Excel
        excelPackage.Workbook.Properties.Title = "EPP test background";
        // thêm tí comments vào làm màu 
        excelPackage.Workbook.Properties.Comments = "This is my fucking generated Comments";
        // Add Sheet vào file Excel
        excelPackage.Workbook.Worksheets.Add("First Sheet");
        // Lấy Sheet bạn vừa mới tạo ra để thao tác 
        var workSheet = excelPackage.Workbook.Worksheets[1];
        // Đổ data vào Excel file
        workSheet.Cells[1, 1].LoadFromCollection(data, true, TableStyles.Dark9);
        // BindingFormatForExcel(workSheet, list);
        excelPackage.Save();
        return excelPackage.Stream;
      }
    }
    #endregion
  }
}
