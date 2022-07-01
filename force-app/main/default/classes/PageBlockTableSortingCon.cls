public class PageBlockTableSortingCon {
   private List<Contact> Contacts;
   private String sortDirection = 'ASC';
   private String sortExp = 'name';
   
   public String sortExpression
   {
       get
       {
           return sortExp;
       }
       set
       {
           //if the column is clicked on then switch between Ascending and Descending modes
           if (value == sortExp)
               sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
           else
               sortDirection = 'ASC';
           sortExp = value;
       }
   }
   
   public String getSortDirection()
   {
       //if not column is selected
       if (sortExpression == null || sortExpression == '')
           return 'ASC';
       else
           return sortDirection;
   }
   
   public void setSortDirection(String value)
   {  
       sortDirection = value;
   }
   
   public List<Contact> getContacts() {
       return contacts;
   }
   
   public PageReference ViewData() {
       //build the full sort expression
       string sortFullExp = sortExpression  + ' ' + sortDirection;
       
       //query the database based on the sort expression
       contacts = Database.query('Select Name, Email, Phone, Account.name, type__c FROM Contact order by ' + sortFullExp + ' limit 1000');
       return null;
   }
}