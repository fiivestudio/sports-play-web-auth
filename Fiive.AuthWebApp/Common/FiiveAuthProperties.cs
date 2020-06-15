using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace Fiive.AuthWebApp.Common
{
    public class FiiveAuthProperties
    {
        public static string ApiSecurity
        {
            get
            {
                if (ConfigurationManager.AppSettings["fiiveauth_IsQA"] == "1") { return ConfigurationManager.AppSettings["fiiveauth_ApiSecurityQA"]; }
                else { return ConfigurationManager.AppSettings["fiiveauth_ApiSecurity"]; }
            }
        }

        public static string SportsPlayDataContext
        {
            get
            {
                if (ConfigurationManager.AppSettings["fiiveauth_IsQA"] == "1") { return "SportsPlayDataContextQA"; }
                else { return "SportsPlayDataContext"; }
            }
        }
    }
}