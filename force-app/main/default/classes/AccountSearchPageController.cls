/*
* Name         : SearchAccountController
* Author       : Abdul Pathan
* Date         : 04 March, 2020
* Description  : This page is used to find Account based on search criteria.
                 Search Account On click of Search button, it will
                 search Account based on name (contains) and show in bottom table.
Page Name : accountsearch
*/

public class AccountSearchPageController {
    public List<Account> lstAccount{get;set;}
    public String textSearch{get;set;}
    public Boolean countSelect{get;set;}
    // Constructor
    public AccountSearchPageController(){
        countSelect = true;
        lstAccount = [SELECT Id, Name, Phone, Website, (SELECT id FROM Contacts) FROM Account limit 30];
    }
    // Search Account Name
    public void searchAccount(){
        countSelect = true;
        String text ='%' + textSearch + '%';
        lstAccount = [SELECT Id, Name, Phone, Website, (SELECT id FROM Contacts) FROM Account  WHERE Name Like : text];
        if(lstAccount.size() < 1){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,' Account Record Not Found'));
            countSelect = false;
        }
    }
}