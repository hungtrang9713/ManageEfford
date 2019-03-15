﻿using MISA.CRM.MANAGER.BL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MISA.CRM.Controllers
{
    public class BaseController<T> : ApiController
    {
        /// <summary>
        /// Lưu dữ liệu vào DB
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public IHttpActionResult SaveData(T data)
        {
            bool saveSuccess = true;
            try
            {
                BLBase blBase = new BLBase();
                saveSuccess = blBase.SaveData(data, typeof(T)) > 0;
            }
            catch (Exception)
            {
                // Ghi log
                saveSuccess = false;
            }

            if (saveSuccess == false)
            {
                return InternalServerError();
            }

            // Cất thành công thì trả về 
            return Ok(data);
        }
    }
}