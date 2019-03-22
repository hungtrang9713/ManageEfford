using CRMManagerEffordServer.App_Start;
using CRMManagerEffordServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Web.Http;

namespace CRMManagerEffordServer.Controllers
{
    [RoutePrefix("User")]
    [AllowAnonymous]
    public class UserController : BaseController<User>
    {
        /// <summary>
        /// Đăng nhập
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        [Route("login")]
        public IHttpActionResult Login(User user) 
        {
            var md5 = new MD5CryptoServiceProvider();
            var userDB = this.DL.GetObject(new
            {
                user.UserName,
                user.Password //md5.ComputeHash(Encoding.ASCII.GetBytes(password))
            }, "Proc_Login");

            if (userDB.UserID != null)
            {
                userDB.Password = null;
                return Ok(new
                {
                    Token = Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(userDB.UserID.ToString())),
                    UserInfo = userDB
                });
            }
            return Unauthorized();
        }
    }
}
