using CRMManagerEffordServer.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.DL
{
    public class DLBase<T>
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

        /// <summary>
        /// Thực hiện store theo state
        /// </summary>
        /// <param name="data">dữ liệu</param>
        /// <param name="procName">tên store</param>
        /// <param name="state">Trạng thái</param>
        /// <returns>Số dòng affect sau khi chạy store</returns>
        public int ExecuteStoreByState(object data, EntityState state, string procName = "")
        {
            try
            {
                if (string.IsNullOrWhiteSpace(procName))
                {
                    procName = $"Proc_{state.ToString()}{typeof(T).Name}";
                }

                Conn.Open();
                SqlCommand cmd = Conn.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procName;
                Utils.MappingParameter(cmd, data);
                return cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
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
        /// Lấy danh sách dữ liệu
        /// </summary>
        /// <param name="procParam"></param>
        /// <param name="procName"></param>
        /// <returns></returns>
        public List<T> GetListData(object procParam, string procName = "")
        {
            List<T> listResult = new List<T>();
            try
            {
                procName = string.IsNullOrWhiteSpace(procName) ? "Proc_GetList" + typeof(T).Name : procName;
                Conn.Open();
                SqlCommand cmd = Conn.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procName;
                Utils.MappingParameter(cmd, procParam);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader.HasRows)
                        {
                            var oObject = Activator.CreateInstance<T>();
                            Utils.AutoMapingObject<T>(reader, ref oObject);
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

        /// <summary>
        /// Lấy về một object
        /// </summary>
        /// <param name="procParam"></param>
        /// <param name="procName"></param>
        /// <returns></returns>
        public T GetObject(object procParam, string procName = "")
        {
            var oObject = Activator.CreateInstance<T>();
            try
            {
                procName = string.IsNullOrWhiteSpace(procName) ? "Proc_GetObject" + typeof(T).Name : procName;
                Conn.Open();
                SqlCommand cmd = Conn.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procName;
                Utils.MappingParameter(cmd, procParam);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader.HasRows)
                        {
                            Utils.AutoMapingObject<T>(reader, ref oObject);
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

            return oObject;
        }

        /// <summary>
        /// Chạy lệnh lấy về giá trị đầu tiên
        /// </summary>
        /// <param name="procParam"></param>
        /// <param name="procName"></param>
        /// <returns></returns>
        public object ExecuteScalar(object procParam, string procName)
        {
            object result = null;
            try
            {
                Conn.Open();
                SqlCommand cmd = Conn.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procName;
                Utils.MappingParameter(cmd, procParam);

                result = cmd.ExecuteScalar();
            }
            finally
            {
                if (Conn != null && Conn.State != ConnectionState.Closed)
                {
                    Conn.Close();
                }
            }

            return result;
        }
    }
}
