using CRMManagerEffordServer.DL;
using CRMManagerEffordServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CRMManagerEffordServer.Controllers
{
    public class BaseController<T> : ApiController where T : BaseEntity
    {
        private DLBase<T> _dl;

        public DLBase<T> DL
        {
            get
            {
                if (_dl == null)
                {
                    _dl = new DLBase<T>();
                }
                return _dl;
            }
            private set
            {

            }
        }

        /// <summary>
        /// Save/Update/Delete
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("")]
        public IHttpActionResult Save(T data)
        {
            try
            {
                this.DL.ExecuteStoreByState(data, data.State);
            }
            catch (Exception ex)
            {
                // Log
                return InternalServerError(ex);
                throw;
            }

            return Ok(data);
        }

        [HttpPost]
        [Route("list")]
        public IHttpActionResult SaveList(List<T> listData)
        {
            try
            {
                foreach (var data in listData)
                {
                    this.DL.ExecuteStoreByState(data, data.State);
                }
            }
            catch (Exception ex)
            {
                // Log
                return InternalServerError(ex);
                throw;
            }

            return Ok(listData);
        }
    }
}
