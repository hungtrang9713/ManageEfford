using CRMManagerEffordServer.DL;
using CRMManagerEffordServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Principal;
using System.Threading;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace CRMManagerEffordServer.App_Start
{
    public class BasicAuthenticationAttribute : AuthorizationFilterAttribute
    {
        public override void OnAuthorization(HttpActionContext actionContext)
        {
            string uri = actionContext.Request.RequestUri.LocalPath.ToLower();
            if (uri.StartsWith("/user/login") || uri.StartsWith("/task/export"))
            {
                return;
            }
            if (actionContext.Request.Headers.Authorization != null)
            {
                var authToken = actionContext.Request.Headers.Authorization.Parameter;

                var decodeauthToken = System.Text.Encoding.UTF8.GetString(Convert.FromBase64String(authToken));

                // at 0th postion of array we get username and at 1st we get password  
                if (IsAuthorizedUser(Guid.Parse(decodeauthToken)))
                {
                    Thread.CurrentPrincipal = new GenericPrincipal(
                    new GenericIdentity(decodeauthToken), null);
                }
                else
                {
                    actionContext.Response = actionContext.Request
                    .CreateResponse(HttpStatusCode.Unauthorized);
                }
            }
            else
            {
                actionContext.Response = actionContext.Request
                 .CreateResponse(HttpStatusCode.Unauthorized);
            }
        }

        public static bool IsAuthorizedUser(Guid userID)
        {
            var auth = new DLBase<User>();
            return bool.Parse(auth.ExecuteScalar(new { UserID = userID }, "Proc_ValidateToken").ToString());
        }
    }
}
