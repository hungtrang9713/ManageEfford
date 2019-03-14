using MISA.CRM.MANAGER.DL;
using System;
using System.Collections.Generic;
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
        #endregion
    }
}