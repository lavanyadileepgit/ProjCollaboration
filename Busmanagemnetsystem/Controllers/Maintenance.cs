//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Busmanagemnetsystem.Controllers
{
    using System;
    using System.Collections.Generic;
    
    public partial class Maintenance
    {
        public int MaintenanceID { get; set; }
        public Nullable<int> BusID { get; set; }
        public System.DateTime Date { get; set; }
        public string Description { get; set; }
    
        public virtual Bus Bus { get; set; }
    }
}