
using CRMManagerEffordServer.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Http;
using System.Web.Http.Cors;
using static CRMManagerEffordServer.Models.Enumeration;

namespace CRMManagerEffordServer.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [RoutePrefix("JobBooking")]
    public class JobBookingController : ApiController
    {
        SqlConnection sqlConnection;
        string connectionString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"];
        public SqlConnection Connection
        {
            get
            {
                if (sqlConnection == null)
                {
                    sqlConnection = new SqlConnection(connectionString);
                }
                if (sqlConnection.State == ConnectionState.Closed)
                {
                    sqlConnection.Open();
                }
                return sqlConnection;
            }
        }

        public SqlDataReader executeQuery(string query)
        {
            SqlCommand command = Connection.CreateCommand();
            command.CommandText = query;
            command.CommandType = CommandType.Text;
            return command.ExecuteReader();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="month"></param>
        /// <param name="year"></param>
        /// <param name="userID"></param>
        /// <returns></returns>
        //[HttpGet]
        //[Route("{month}/{year}/{userID}")]
        //public IHttpActionResult GetBookingJobMonth(int month, int year, Guid userID)
        //{
        //    List<JobBooking> listResult = null;
        //    try
        //    {
        //        listResult = this.DL.GetListData(new { Month = month, Year = year, UserID = userID.ToString() }, "dbo.Proc_GetJobBookingMonth");
        //    }
        //    catch (Exception e)
        //    {
        //        return InternalServerError();
        //    }

        //    return Ok(listResult);
        //}
        /// <summary>
        /// 
        /// </summary>
        /// <param name="date"></param>
        /// <param name="userID"></param>
        /// <returns></returns>
        [Route("workingState/{date}/{userID}")]
        [HttpGet]
        public IHttpActionResult GetWorkingStateByDate(string date, Guid userID)
        {
            WorkingState workingState = WorkingState.NoRegister;
            string query = $"select * from JobBooking where Date = '{date}' and UserID = '{userID.ToString()}'";
            SqlDataReader reader = executeQuery(query);
            if (reader.Read())
            {
                workingState = (WorkingState)reader["WorkingState"];
            }
            sqlConnection.Close();
            return Ok(workingState);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="jobBooking"></param>
        /// <returns></returns>
        [Route("{userID}")]
        public IHttpActionResult SaveData([FromUri]Guid userID, JobBooking jobBooking)
        {
            jobBooking.UserID = userID;
            string query = "";
            if (checkJobBookingExist(jobBooking))
            {
                query = $"update JobBooking set WorkingState = {jobBooking.WorkingState} where Date = '{jobBooking.Date}' and UserID = '{jobBooking.UserID}'";
            }
            else
            {
                query = $"insert into JobBooking (UserID, Date, WorkingState) values ('{jobBooking.UserID}', '{jobBooking.Date}', {jobBooking.WorkingState})";
            }
            sqlConnection.Close();
            executeQuery(query);
            return Ok();
        }

        bool checkJobBookingExist(JobBooking jobBooking)
        {
            string query = $"select * from JobBooking where Date = '{jobBooking.Date}' and UserID = '{jobBooking.UserID.ToString()}'";
            SqlDataReader reader = executeQuery(query);
            return reader.Read();
        }


    }
}
