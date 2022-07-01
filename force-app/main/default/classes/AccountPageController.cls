/*
* Developed By Abdul Pathan
* Controller AccountController
* Date /01/2020
Page Name accountPage
*/
public with sharing class AccountPageController {
    
    public List<Contact> lstContact {get; set;}
    public String accName {get; set;}
    public boolean status {get; set;}
    public String txtSearch {get;set;}
    
    
    public AccountPageController(){
        txtSearch = '';
        status = false;
        accName = 'Abdul Pathan';
        lstContact = [SELECT firstName, lastName, phone, email FROM contact ];
    }    
    public void showResult(){
        status = true;
        string nm ='%'+txtSearch+'%';
        lstContact = [SELECT firstName, lastName, phone, email FROM contact WHERE Name Like :nm or Email like :nm ];
    }
    
    
}