using CRMManagerEffordServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CRMManagerEffordServer.Controllers
{
    [RoutePrefix("User")]
    public class UserController : BaseController<User>
    {
    }
}
