using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CRMManagerEffordServer.Models
{
    public class EmployeeManagement:User
    {
        // lấy thông tin User là Lead và mảng thông tin dev thuộc quản lý của Lead đó
        public List<User> ListEmployee { get; set; }
    }
}