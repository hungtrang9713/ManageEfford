using CRMManagerEffordServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.DL
{
  public class DLAuth : DLBase<User>
  {
    /// <summary>
    /// Validate username, password
    /// </summary>
    /// <param name="username"></param>
    /// <param name="password"></param>
    /// <returns></returns>
    public bool IsAuthorizedUser(string username, string password)
    {
        User user = this.GetObject(new { UserName = username, Password = password });
        return user.UserID != null;
    }
  }
}
