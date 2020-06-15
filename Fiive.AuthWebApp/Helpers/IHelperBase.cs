using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fiive.AuthWebApp.Helpers
{
    public interface IHelperBase
    {
        string ClientId { get; set; }
        string Password { get; set; }
        string UserName { get; set; }
        string AudienceName { get; set; }

        AuthenticationProperties ValidateUser();
    }
}