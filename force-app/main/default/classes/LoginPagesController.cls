/*
* Name         : LoginPageController
* Author       : Abdul Pathan
* Date         : 15 Feb, 2020
* Description  : This is Login Page Controller 
*/

public class LoginPagesController{
    List<Contact> lstContact{get;set;}
    public String textEmail{get;set;}
    public String textPassword{get;set;}
    
    // Constructor
    public void LoginPagesController(){
        lstContact = new List<Contact>();
    }
    
    // Login Page Enter User Email and Password valid
    public PageReference login(){
        
        if(String.isBlank(textEmail) != true && String.isBlank(textPassword) != true){
            lstContact = [SELECT Email, Password__c 
                          FROM Contact
                          WHERE Email =: textEmail AND Password__c =: textPassword
                         ];
            
            if(lstContact.size() > 0){
                PageReference  pgEdit=Page.questionanswerpage;
                pgEdit.getParameters().put('uniqueId', lstContact[0].id);
                return pgEdit;
            }else{
                lstContact = [SELECT Email, Password__c 
                              FROM Contact
                              WHERE Email =: textEmail
                             ];
                if(lstContact.size() > 0){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Password does not exit'));
                }
                else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Email does not exit'));
                }
            }
        }
        
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Please Enter Email and Password'));
        }
        return null;
        
    }
    
    // Signup Page
    public PageReference signup(){
        PageReference newPage = new PageReference('/apex/signuppage');
        newPage.setRedirect(true);
        return newPage;
    }
}