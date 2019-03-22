using CRMManagerEffordServer.DL;
using CRMManagerEffordServer.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
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
    string connectionString = "Data Source = BHTRANG\\DEVELOPMENT;Initial Catalog = CRMManager; Integrated Security = True";

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

    [Route("workingState/{date}")]
    [HttpGet]
    public IHttpActionResult GetWorkingStateByDate(string date)
    {
      WorkingState workingState = WorkingState.NoRegister;
      Guid userID = new Guid("E8CC28D7-8E5A-496D-8183-25ECDE19F48E");
      string query = $"select * from JobBooking where Date = '{date}' and UserID = '{userID.ToString()}'";
      SqlDataReader reader = executeQuery(query);
      if(reader.Read())
      {
        workingState =  (WorkingState)reader["WorkingState"];
      }
      sqlConnection.Close();
      return Ok(workingState);
    }

    [Route("")]
    public IHttpActionResult SaveData(JobBooking jobBooking) 
    {
      Guid userID = new Guid("E8CC28D7-8E5A-496D-8183-25ECDE19F48E");
      jobBooking.UserID = userID;
      string query = "";
      if(checkJobBookingExist(jobBooking))
      {
        query = $"update JobBooking set WorkingState = {jobBooking.WorkingState} where Date = '{jobBooking.Date}' and UserID = '{jobBooking.UserID}'";
      } else
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
