namespace Fiive.AuthWebApp.Models.SportsPlay
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class users
    {
        [Key]
        public int id_users { get; set; }

        [StringLength(50)]
        public string name { get; set; }

        [StringLength(50)]
        public string password { get; set; }

        [StringLength(50)]
        public string phone { get; set; }

        [StringLength(50)]
        public string email { get; set; }

        [StringLength(50)]
        public string id_usersocialred { get; set; }
    }
}
