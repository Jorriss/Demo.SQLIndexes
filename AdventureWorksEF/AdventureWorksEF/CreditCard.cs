//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AdventureWorksEF
{
    using System;
    using System.Collections.Generic;
    
    public partial class CreditCard
    {
        public CreditCard()
        {
            this.PersonCreditCards = new HashSet<PersonCreditCard>();
            this.SalesOrderHeaders = new HashSet<SalesOrderHeader>();
        }
    
        public int CreditCardID { get; set; }
        public string CardType { get; set; }
        public string CardNumber { get; set; }
        public byte ExpMonth { get; set; }
        public short ExpYear { get; set; }
        public System.DateTime ModifiedDate { get; set; }
    
        public virtual ICollection<PersonCreditCard> PersonCreditCards { get; set; }
        public virtual ICollection<SalesOrderHeader> SalesOrderHeaders { get; set; }
    }
}
