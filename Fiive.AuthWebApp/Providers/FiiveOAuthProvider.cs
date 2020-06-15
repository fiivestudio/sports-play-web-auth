using Fiive.AuthWebApp.Common;
using Fiive.AuthWebApp.Entities;
using Fiive.AuthWebApp.Helpers;
using Fiive.AuthWebApp.Helpers.SportsPlay;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.OAuth;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;

namespace Fiive.AuthWebApp.Providers
{
    public class FiiveOAuthProvider : OAuthAuthorizationServerProvider
    {
        #region Vars

        Audience _audience = new Audience();
        private string nameUser = string.Empty, phoneUser = string.Empty;
        private string nameCustomer = string.Empty;
        OAuthValidateClientAuthenticationContext _globalContext;

        #endregion

        public override Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            string clientId = string.Empty;
            string clientSecret = string.Empty;
            string symmetricKeyAsBase64 = string.Empty;

            if (!context.TryGetBasicCredentials(out clientId, out clientSecret))
            {
                context.TryGetFormCredentials(out clientId, out clientSecret);
            }

            if (context.ClientId == null)
            {
                context.SetError("002", "client_Id Invalido: El client_id no puede estar vacio.");
                return Task.FromResult<object>(null);
            }

            _audience = AudiencesStore.FindAudience(context.ClientId);

            if (_audience == null)
            {
                context.SetError("001", string.Format("client_id Invalido: El client_id '{0}' no existe.", context.ClientId));
                return Task.FromResult<object>(null);
            }

            context.Validated();
            _globalContext = context;
            return Task.FromResult<object>(null);
        }

        public override Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            context.OwinContext.Response.Headers.Add("Access-Control-Allow-Origin", new[] { "*" });
            AuthenticationProperties props = ValidateUser(context);

            if (props == null)
            {
                context.SetError("003", "Error de Autenticacion: Usuario o password incorrecto.");
                return Task.FromResult<object>(null);
            }

            var identity = new ClaimsIdentity("JWT");
            identity.AddClaim(new Claim(ClaimTypes.Name, context.UserName));
            identity.AddClaim(new Claim("sub", context.UserName));
            identity.AddClaim(new Claim(ClaimTypes.Role, _audience.Name));
            identity.AddClaim(new Claim("audience", (context.ClientId == null) ? string.Empty : context.ClientId));

            var ticket = new AuthenticationTicket(identity, props);
            context.Validated(ticket);
            return Task.FromResult<object>(null);
        }

        public AuthenticationProperties ValidateUser(OAuthGrantResourceOwnerCredentialsContext context)
        {
            try
            {
                IHelperBase helperApp = null;
                if (_audience.Name == FiiveApps.SportsPlayUserMobile.ToString() ||
                    _audience.Name == FiiveApps.SportsPlayCoachMobile.ToString() ||
                    _audience.Name == FiiveApps.SportsPlayCoachWeb.ToString())
                {
                    helperApp = new SportsPlayHelper();

                    helperApp.ClientId = context.ClientId;
                    helperApp.UserName = context.UserName;
                    helperApp.Password = context.Password;
                    helperApp.AudienceName = _audience.Name;

                    AuthenticationProperties props = helperApp.ValidateUser();
                    return props;
                }
                else { return null; }
            }
            catch (Exception) { return null; }
        }

        public override Task TokenEndpoint(OAuthTokenEndpointContext context)
        {
            foreach (KeyValuePair<string, string> property in context.Properties.Dictionary)
            {
                context.AdditionalResponseParameters.Add(property.Key, property.Value);
            }
            return Task.FromResult<object>(null);
        }
    }
}