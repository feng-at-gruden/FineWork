using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using API.Models;
using System.Web;
using API.Models.Auth;

namespace API.Controllers
{
    public class BaseController : ApiController
    {
        protected FineWorkEntities db = new FineWorkEntities();
        


        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        protected User CurrentUser
        {
            get
            {
                try
                {
                    AuthInfo tokenJson = (AuthInfo)RequestContext.RouteData.Values["auth"];
                    var u = db.User.SingleOrDefault(m => m.UserName.Equals(tokenJson.UserName, StringComparison.CurrentCultureIgnoreCase));
                    return u;
                }
                catch (ArgumentNullException ex) { }
                
                throw new Exception("Invalid auth information");
            }
        }

    }
}