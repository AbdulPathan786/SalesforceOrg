/*
* Developed By Abdul Pathan
* Controller LeadController
* Date /01/2020
*/
public class ContactCreateController {
    public Contact objContact {get; set;}
    public List<Account> lstAccount{get; set; }
    public List<Contact>  lstContact{get; set;}
    public String textAccount {get; set; }
    public Boolean Status{get; set;}
    
    public ContactCreateController(){
        Status=false;
        lstContact=new List<Contact>();
        objContact=new  Contact();
    }
    
    public void SaveButton(){
        if (String.isBlank(objContact.LastName) == true || String.isBlank((objContact.Email)) ==true ){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter LastName or Email name'));
        }
        else {
            if(String.isBlank(textAccount) == true){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter Account Name'));
            }
            else {
                lstAccount = [SELECT Name FROM Account WHERE Name Like : textAccount];
                if(lstAccount.size() == 0){
                    Status=true;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Account Name does not exist'));
                    Account  acc=new Account();
                    acc.Name = textAccount;
                    insert acc;
                    objContact.AccountId=acc.id;
                }
                else {
                    Status=true;
                    objContact.AccountId = lstAccount.get(0).ID;
                    insert objContact; 
                    objContact = new Contact();
                    textAccount = '';
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Record insert successfully...'));
                    lstContact.add(objContact);
                }
            }
        }
    }
    public void CancelButton(){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Record Cancel'));
    }
}