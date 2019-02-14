using API.Models;
using API.Models.Auth;
using JWT;
using JWT.Algorithms;
using JWT.Serializers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;

namespace API.Controllers
{
    [RoutePrefix("API/Token")]
    public class TokenController : BaseController
    {
        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="loginRequest"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage GetToken([FromBody] LoginRequest loginRequest)
        {
            TokenInfo response = new TokenInfo();//需要返回的口令信息
            if (loginRequest != null)
            {
                string userName = loginRequest.UserName;
                string passWord = loginRequest.Password;

                var u = db.User.FirstOrDefault(m => m.Password == passWord && m.UserName == userName);
                if (u!=null)
                {
                    AuthInfo authInfo = new AuthInfo { UserName = u.UserName, RealName= u.RealName, ExpiryDateTime = DateTime.Now.AddHours(2) };
                    const string secretKey = Configurations.SECRET_KEY;//口令加密秘钥
                    try
                    {
                        byte[] key = Encoding.UTF8.GetBytes(secretKey);
                        IJwtAlgorithm algorithm = new HMACSHA256Algorithm();//加密方式
                        IJsonSerializer serializer = new JsonNetSerializer();//序列化Json
                        IBase64UrlEncoder urlEncoder = new JwtBase64UrlEncoder();//base64加解密
                        IJwtEncoder encoder = new JwtEncoder(algorithm, serializer, urlEncoder);//JWT编码
                        var token = encoder.Encode(authInfo, key);//生成令牌
                                                                  //口令信息
                        response.Success = true;
                        response.Token = token;
                        response.Message = "OK";
                    }
                    catch (Exception ex)
                    {
                        response.Success = false;
                        response.Message = ex.Message.ToString();
                    }
                    u.LastLoginAt = DateTime.Now;
                    db.SaveChanges();
                }
                else
                {
                    response.Success = false;
                    response.Message = "用户名/密码错误";
                }
            }
            else
            {
                response.Success = false;
                response.Message = "用户信息为空";
            }
            if(!response.Success)
            {
                return Request.CreateResponse(HttpStatusCode.Unauthorized, response, "application/json");
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, response, "application/json"); ;
            }
        }



    }

}
