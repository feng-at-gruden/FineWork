using API.Filters;
using API.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace API.Controllers
{
    [RoutePrefix("api/Account")]
    [ApiAuthorize]
    public class ProjectController : BaseController
    {

        [HttpGet]
        public HttpResponseMessage List()
        {
            var p = new
            {
                Id = 0,
                Name = "测试项目",
                Description = "",
            };
            return Request.CreateResponse(HttpStatusCode.OK, new object[] { p, p });
        }

        [HttpGet]
        public HttpResponseMessage Detail(int id)
        {
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        public HttpResponseMessage Create([FromBody]JObject project)
        {
            return Request.CreateResponse(HttpStatusCode.OK, project); 
        }

    }



}
