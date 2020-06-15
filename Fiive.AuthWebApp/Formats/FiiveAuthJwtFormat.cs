using Fiive.AuthWebApp.Common;
using Fiive.AuthWebApp.Entities;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.DataHandler.Encoder;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Text;
using System.Web;
using Thinktecture.IdentityModel.Tokens;

namespace Fiive.AuthWebApp.Formats
{
    public class FiiveAuthJwtFormat : ISecureDataFormat<AuthenticationTicket>
    {
        private readonly string _issuer = string.Empty;

        public FiiveAuthJwtFormat() { _issuer = FiiveAuthProperties.ApiSecurity; }

        public string Protect(AuthenticationTicket data)
        {
            if (data == null) { throw new ArgumentNullException("data"); }

            string audienceId = (from a in data.Identity.Claims.AsEnumerable()
                                 where a.Type.ToLower().Equals("audience")
                                 select a.Value).FirstOrDefault();

            if (string.IsNullOrWhiteSpace(audienceId)) throw new InvalidOperationException("AuthenticationTicket. Properties does not include audience");
            Audience audience = AudiencesStore.FindAudience(audienceId);

            string symmetricKeyAsBase64 = audience.Base64Secret;
            var securityKey = new SymmetricSecurityKey(TextEncodings.Base64Url.Decode(symmetricKeyAsBase64));
            var signingKey = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256Signature);

            var issued = data.Properties.IssuedUtc;
            var expires = data.Properties.ExpiresUtc;

            var token = new JwtSecurityToken(_issuer, audienceId, data.Identity.Claims, issued.Value.UtcDateTime, expires.Value.UtcDateTime, signingKey);
            var handler = new JwtSecurityTokenHandler();
            var jwt = handler.WriteToken(token);
            return jwt;
        }

        public AuthenticationTicket Unprotect(string protectedText) { throw new NotImplementedException(); }
    }
}