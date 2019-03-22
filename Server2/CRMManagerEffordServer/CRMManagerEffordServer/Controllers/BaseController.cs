using CRMManagerEffordServer.DL;
using CRMManagerEffordServer.Models;
using CRMManagerEffordServer.Util;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Threading;
using System.Web.Http;

namespace CRMManagerEffordServer.Controllers
{
    public class BaseController<T> : ApiController where T : BaseEntity
    {
        private DLBase<T> _dl;

        public virtual DLBase<T> DL
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
                this.BeforeSave(data);
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

        protected virtual void BeforeSave(T data)
        {
            PropertyInfo[] properties = data.GetType().GetProperties();

            foreach (PropertyInfo property in properties)
            {
                var attribute = Attribute.GetCustomAttribute(property, typeof(KeyAttribute))
                    as KeyAttribute;

                if (attribute != null)
                {
                    if (data.State == EntityState.Insert)
                    {
                        property.SetValue(data, Guid.NewGuid());
                    }
                }
            }
        }

        [HttpPost]
        [Route("list")]
        public IHttpActionResult SaveList(List<T> listData)
        {
            try
            {
                foreach (var data in listData)
                {
                    this.BeforeSave(data);
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
