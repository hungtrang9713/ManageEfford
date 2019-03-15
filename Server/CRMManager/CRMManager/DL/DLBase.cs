using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MISA.CRM.MANAGER.DL
{
    public class DLBase
    {
        #region Declate
        private SqlConnection _conn;
        #endregion

        #region Property
        // Khởi tạo đối tượng Connection
        protected SqlConnection Conn
        {
            get
            {
                if (_conn == null)
                {
                    _conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ConnectionString"]);
                }

                return _conn;
            }
            private set { }
        }
        #endregion

        #region Method
        /// <summary>
        /// Cất một đối tượng vào DB
        /// </summary>
        /// <param name="data">Dữ liệu muốn cất</param>
        /// <param name="dataType">Loại của dữ liệu</param>
        /// <param name="procName">Store dùng để cất dữ liệu (ngầm định là gọi store Proc_Insert<Tên class></param>
        /// <returns>Đối tượng mà store trả về (Thường là ID của đối tượng đang insert vào)</returns>
        /// created by: dtthao - 08.12.2018
        public int InsertObjectToDB(object data, Type dataType, string procName = "")
        {
            try
            {
                procName = string.IsNullOrWhiteSpace(procName) ? "Proc_Insert" + dataType.Name : procName;
                Conn.Open();
                SqlCommand cmd = Conn.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procName;
                MappingParameter(cmd, dataType, data);
                return cmd.ExecuteNonQuery();
            }
            finally
            {
                if (Conn != null && Conn.State != ConnectionState.Closed)
                {
                    Conn.Close();
                }
            }
        }

        /// <summary>
        /// Lấy danh sách tham số của store để truyền dữ liệu
        /// </summary>
        /// <param name="cmd">Đối tượng command cần truyền tham số</param>
        /// <param name="dataType">Loại dữ liệu</param>
        /// <param name="data">data của đối tượng</param>
        /// created by: dtthao 08.12.2018
        private void MappingParameter(SqlCommand cmd, Type dataType, object data)
        {
            /*
             * 1. Lấy danh sách các tham số của store
             * 2. Duyệt qua danh sách tham số, kiểm tra xem kiểu dataType có tham số trùng tên với tham số hay không
             * 3. Nếu có thì lấy dữ liệu của property đó của data để truyền vào cmd
             * 4. Nếu không có thì throw exeption báo không đủ tham số
             */
            SqlCommandBuilder.DeriveParameters(cmd);

            string paramName = string.Empty;
            for (int i = 1; i < cmd.Parameters.Count; ++i)
            {
                var param = cmd.Parameters[i];
                paramName = param.ParameterName.Substring(1);
                var propInfo = dataType.GetProperty(paramName);
                if (propInfo != null)
                {
                    var value = propInfo.GetValue(data);

                    if (value != null)
                    {
                        param.Value = value;
                    }
                    else
                    {
                        param.Value = DBNull.Value;
                    }
                }
                else
                {
                    throw new Exception("Không đủ tham số");
                }
            }
        }

        public List<T> GetListData<T>(object param, string procName = "")
        {
            List<T> listResult = new List<T>();
            try
            {
                procName = string.IsNullOrWhiteSpace(procName) ? "Proc_GetList" + typeof(T).Name : procName;
                Conn.Open();
                SqlCommand cmd = Conn.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procName;
                MappingParameter(cmd, param.GetType(), param);

                using (var reader = cmd.ExecuteReader())
                {
                    var oObject = Activator.CreateInstance<T>();
                    while (reader.Read())
                    {
                        if (reader.HasRows)
                        {
                            AutoMapingObject(reader, ref oObject);
                            listResult.Add(oObject);
                        }
                    }
                }
            }
            finally
            {
                if (Conn != null && Conn.State != ConnectionState.Closed)
                {
                    Conn.Close();
                }
            }

            return listResult;
        }

        public void AutoMapingObject<T>(SqlDataReader reader, ref T oObject)
        {
            for (int i = 0; i < reader.FieldCount; ++i)
            {
                string fieldName = reader.GetName(i);
                reader.GetValue(i);
                if (oObject.GetType().GetProperty(fieldName) != null && reader[fieldName] != DBNull.Value)
                {
                    oObject.GetType().GetProperty(fieldName).SetValue(oObject, reader[fieldName]);
                }
            }
        }
        #endregion
    }
}