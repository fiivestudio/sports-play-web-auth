using Fiive.AuthWebApp.Common;
using Fiive.AuthWebApp.Entities.SportsPlay;
using Fiive.AuthWebApp.Models.SportsPlay;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Fiive.Framework.Security;

namespace Fiive.AuthWebApp.Helpers.SportsPlay
{
    public class SportsPlayHelper : IHelperBase
    {
        #region Vars

        SportsPlayDataContext _dataContext;

        #endregion

        #region IHelperBase

        public string ClientId { get; set; }
        public string Password { get; set; }
        public string UserName { get; set; }
        public string AudienceName { get; set; }

        public AuthenticationProperties ValidateUser()
        {
            _dataContext = new SportsPlayDataContext(FiiveAuthProperties.SportsPlayDataContext);

            if (AudienceName == FiiveApps.SportsPlayCoachMobile.ToString() ||
                AudienceName == FiiveApps.SportsPlayCoachWeb.ToString())
            {
                return ValidateCoach();
            }
            else if (AudienceName == FiiveApps.SportsPlayUserMobile.ToString()) { return ValidateUserApp(); }

            return null;
        }

        #endregion

        private AuthenticationProperties ValidateCoach()
        {
            string sha1Password = SHA1.GetSHA1(Password);
            var result = (from user in _dataContext.customer
                          where user.email.Equals(UserName) && user.password.Equals(sha1Password)
                          select new { id_user = user.id_customer, username = user.full_name, id_place = user.id_place }).SingleOrDefault();

            if (result != null)
            {
                AuthenticationProperties props = new AuthenticationProperties(new Dictionary<string, string>
                {
                    {"id_user", result.id_user.ToString()},
                    {"name_customer", result.username},
                    {"id_place", result.id_place.ToString()}
                });

                return props;
            }

            return null;
        }

        private AuthenticationProperties ValidateUserApp()
        {
            // Validamos si se trata de un Id de Red Social o un Username comun
            // 1. Si viene el username sin password es por que es un Id de Red Social
            //    En este caso solo se valida el valor enviado en el campo username contra el campo [id_usersocialred] de la base de datos.
            // 2. Si vienen los dos campos llenos es por que es un Username comun
            //    En este caso se valida el username contra el campo email y el password contra el campo password de la base de datos. 

            if (!string.IsNullOrEmpty(UserName) && string.IsNullOrWhiteSpace(Password))
            {
                var result = (from user in _dataContext.users
                              where user.id_usersocialred.Equals(UserName)
                              select new UserEntity { IdUser = user.id_users, Name = user.name, Phone = user.phone }).SingleOrDefault();

                if (result != null) { return GetUserAuthenticationProperties(result); }
            }
            else
            {
                string sha1Password = SHA1.GetSHA1(Password);
                var result = (from user in _dataContext.users
                              where user.email.Equals(UserName) && user.password.Equals(sha1Password)
                              select new UserEntity { IdUser = user.id_users, Name = user.name, Phone = user.phone }).SingleOrDefault();

                if (result != null) { return GetUserAuthenticationProperties(result); }
            }

            return null;
        }

        private AuthenticationProperties GetUserAuthenticationProperties(UserEntity user)
        {
            AuthenticationProperties props = new AuthenticationProperties(new Dictionary<string, string>
            {
                {"id_user", user.IdUser.ToString()},
                {"user_name", user.Name},
                {"user_phone", user.Phone}
            });

            return props;
        }
    }
}