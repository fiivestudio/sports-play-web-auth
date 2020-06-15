namespace Fiive.AuthWebApp.Models.SportsPlay
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class SportsPlayDataContext : DbContext
    {
        public SportsPlayDataContext(string nameOrConnectionString)
            : base("name=" + nameOrConnectionString)
        {
        }

        public virtual DbSet<users> users { get; set; }
        public virtual DbSet<customer> customer { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
        }
    }
}
