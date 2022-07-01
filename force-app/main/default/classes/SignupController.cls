/*
* Name         : LoginPageController
* Author       : Abdul Pathan
* Date         : 15 Feb, 2020
* Description  : This is Signup Page Controller 
*/

public class SignupController{
    public Contact objContact{get;set;}
    public String textEmail{get;set;}
    
    // Constructor
    public SignupController(){
        objContact = new Contact();
    }
    
    // Signup Page Record Insert and email different
    public void save(){
        textEmail = objContact.Email;
        if(String.isBlank(objContact.FirstName) == true){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Please enter FirstName'));
        }
        else if(String.isBlank(objContact.LastName) == true){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Please enter LastName'));
        }
 
        else if(String.isBlank(objContact.Email) == true){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Please enter Email'));
        }
       // Email Condition 
        else if(String.isBlank(objContact.Email) != true){
            List<Contact>  lstontact = [SELECT id, email 
                                        FROM Contact 
                                        where email =: textEmail 
                                       ];
            System.debug('textEmail' + textEmail);
            if(lstontact.size() >0){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Email all ready exist'));
            }
            
            else if(String.isBlank(objContact.Password__c) == true){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Please enter Password'));
            }
            else{
                try{
                    insert objContact;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,' Record Save Successfully ')); 
                }
                catch (exception e){
                    // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' e Successfully '));
                }
            }
        }
        
    }
    
    // Cancel Button 
    public PageReference cancel(){
        PageReference newPage = new PageReference('/apex/loginpage');
        newPage.setRedirect(true);
        return newPage;
    }
}