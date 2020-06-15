namespace Fiive.AuthWebApp.Models.SportsPlay
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("customer")]
    public partial class customer
    {
        [Key]
        public int id_customer { get; set; }

        [StringLength(50)]
        public string full_name { get; set; }

        [StringLength(20)]
        public string phone { get; set; }

        [StringLength(50)]
        public string email { get; set; }

        [StringLength(50)]
        public string password { get; set; }

        public int? id_place { get; set; }
    }
}
