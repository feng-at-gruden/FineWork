using System;
using System.Collections.Generic;
using System.Linq;
using System.Security;
using System.Web.Security;
using System.Security.Principal;
using System.Web;

namespace API.Models
{
    public class UserPrincipal: IPrincipal
    {
        public string RealName { get; set; }
        public int Id { get; set; }

        private IIdentity _identity;


        public UserPrincipal(int id, string realName, IIdentity identity)
        {
            Id = id;
            RealName = realName;
            _identity = identity;
        }

        IIdentity IPrincipal.Identity
        {
            get
            {
                return _identity;
            }
        }

        bool IPrincipal.IsInRole(string role)
        {
            throw new NotImplementedException();
        }
    }
}