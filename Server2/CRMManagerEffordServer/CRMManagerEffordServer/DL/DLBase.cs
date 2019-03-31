using CRMManagerEffordServer.Models;
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

        public List<EmployeeManagement> GetListEmployee(object procParam, string procName = "")
        {
            List<EmployeeManagement> listResult = new List<EmployeeManagement>();
            List<User> listUsers = new List<User>();

            // lấy mảng leads
            try
            {
                procName = string.IsNullOrWhiteSpace(procName) ? "Proc_GetList" + typeof(T).Name : procName;
                Conn.Open();
                SqlCommand cmd = Conn.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procName;
                Utils.MappingParameter(cmd, procParam);

                // đọc dataset
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet dataset = new DataSet();
                adapter.Fill(dataset);

                if (dataset.Tables.Count > 0)
                {
                    DataTable tableLeads = dataset.Tables[0];
                    DataTable tableUsers = dataset.Tables[1];
                    // lấy bảng lead
                    foreach (DataRow row in tableLeads.Rows)
                    {
                        var lead = Activator.CreateInstance<EmployeeManagement>();
                        foreach (DataColumn column in tableLeads.Columns)
                        {
                            string columnName = column.ColumnName;
                            //var abc = row[column];
                            if (lead.GetType().GetProperty(columnName) != null && row[columnName] != DBNull.Value)
                            {
                                lead.GetType().GetProperty(columnName).SetValue(lead, row[columnName], null);
                            }
                        }
                        listResult.Add(lead);
                    }
                    // lấy bảng user

                    foreach (DataRow row in tableUsers.Rows)
                    {
                        var user = Activator.CreateInstance<User>();
                        foreach (DataColumn column in tableUsers.Columns)
                        {
                            string columnName = column.ColumnName;
                            //var abc = row[column];
                            if (user.GetType().GetProperty(columnName) != null && row[columnName] != DBNull.Value)
                            {
                                user.GetType().GetProperty(columnName).SetValue(user, row[columnName], null);
                            }
                        }
                        listUsers.Add(user);
                    }
                    // gắn mảng employeemanagement cho các lead
                    foreach(EmployeeManagement lead in listResult)
                    {
                        List<User> employees = new List<User>();
                        foreach(User user in listUsers)
                        {
                            if(user.UserID != user.LeadID && user.LeadID == lead.UserID)
                            {
                                employees.Add(user);
                            }
                        }
                        lead.ListEmployee = employees;
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
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
