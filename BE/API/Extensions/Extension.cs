using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API.Extensions
{
    public static class Extension
    {
        public static int StringToInt32(this string str)
        {
            int num = -1;
            if (int.TryParse(str, out num))
            {
                return num;
            }
            else
            {
                return -1;
            }
        }
    }
}