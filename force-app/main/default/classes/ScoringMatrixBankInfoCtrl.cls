public with sharing class ScoringMatrixBankInfoCtrl {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getbankInfoStatementData(String accId){
            return [SELECT Id, Name, Phone, BillingCity FROM Account WHERE Id =: accId];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactRecords(String accId){
            return [SELECT Id, firstName, LastName, Email FROM Contact WHERE AccountId =: accId LIMIT 3];
    }
}