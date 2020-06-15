using Fiive.AuthWebApp.Common;
using Fiive.AuthWebApp.Entities;
using Microsoft.Owin.Security.DataHandler.Encoder;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

namespace Fiive.AuthWebApp
{
    public static class AudiencesStore
    {
        public static ConcurrentDictionary<string, Audience> AudiencesList = new ConcurrentDictionary<string, Audience>();

        static AudiencesStore()
        {
            #region Sports Play

            AudiencesList.TryAdd("099153c2625149bc8ecb3e85e03f0022",
                                    new Audience
                                    {
                                        ClientId = "099153c2625149bc8ecb3e85e03f0022",
                                        Base64Secret = "4e686af7bdcc5ae005a247624fd8c7283257c2514f6b3ad2ff5d4cb6d95196e6",
                                        Name = FiiveApps.SportsPlayUserMobile.ToString()
                                    });

            AudiencesList.TryAdd("cdb59355f3ba293977fc0945fb85f118",
                                new Audience
                                {
                                    ClientId = "cdb59355f3ba293977fc0945fb85f118",
                                    Base64Secret = "d4f0bc5a29de06b510f9aa428f1eedba926012b591fef7a518e776a7c9bd1824",
                                    Name = FiiveApps.SportsPlayCoachMobile.ToString()
                                });

            AudiencesList.TryAdd("cdb59355f3ba293977fc0945fb85aiop",
                                new Audience
                                {
                                    ClientId = "cdb59355f3ba293977fc0945fb85aiop",
                                    Base64Secret = "d4f0bc5a29de06b512389nsvdisvyr89qriojfsdiow32r98q4e776a7c9bd1824",
                                    Name = FiiveApps.SportsPlayCoachWeb.ToString()
                                });

            #endregion
        }

        public static Audience FindAudience(string clientId)
        {
            Audience audience = null;
            if (AudiencesList.TryGetValue(clientId, out audience)) { return audience; }
            return null;
        }
    }
}