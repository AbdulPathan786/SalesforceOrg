public class ContactPageController {
    public List<Contact> lstContact {get; set;}
    public String textSearch {get;set;}
    public boolean status {get; set;}
    public ContactPageController(){
        status=false;
        lstContact = [SELECT Name, Account.Name, Phone, Email FROM Contact];
    }
    public void showResult(){
        status=true;
        String nm ='%'+textSearch+'%';
        lstContact = [SELECT Name, Account.Name,Phone, Email FROM Contact
                      WHERE Name Like :nm or Email like :nm];
    }
    
   
}