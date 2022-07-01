/*
* Author : Abdul Pathan
* Created At  : 23 November, 2021
* Description : The batch will fetch all accounts and its related contacts and create as many invoice records
*/
global class InvoiceBatch implements Database.Batchable<sObject> {
    // collect the batches of records or objects to be passed to execute
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Name, (SELECT Id, Name, AccountId FROM contacts) FROM Account';
        return Database.getQueryLocator(query);
    }
    //execute
    global void execute(Database.BatchableContext BC, List<Account> accountList){
        Map<String, Set<Id>> mapRecords = new Map<String, Set<Id>>();
        Set<Id> setAllIds = new Set<Id>();//Contacts Ids
        Set<String> setIds = new Set<String>();//Contacts Ids
        List<Invoice__c> invoicesList = new List<Invoice__c>();
        
        DateTime myDate = System.today();
        String month = myDate.format('MMMM');
        String year = myDate.format('YYYY');
        
        if(accountList.size() > 0){
            for(Account accountRecord: accountList){
                Set<Id> contactsIds = new Set<Id>();
                for(Contact contactRecord : accountRecord.contacts){
                    contactsIds.add(contactRecord.Id);
                    mapRecords.put(accountRecord.Id, contactsIds);
                }
            } 
        }
        if(mapRecords.size() > 0){
            for(Set<Id> setId:  mapRecords.values()){
                setAllIds.addAll(setId);
            }
            List<Invoice__c> invoicesRecord = [SELECT Id, Account__c, Contact__c, Month__c, Year__c, Amount__c 
                                               FROM Invoice__c 
                                               WHERE Contact__c IN : setAllIds AND Month__c =: month AND Year__c =: year
                                              ];
            if(invoicesRecord.size() > 0){
                for(Invoice__c invoice: invoicesRecord){
                    setIds.add(invoice.Contact__c);
                }
            }
            
            for(String key : mapRecords.keyset()){
                for(Id value : mapRecords.get(key)){
                    if(!setIds.contains(value)){
                        Invoice__c invoiceRecord = new Invoice__c();
                        invoiceRecord.Account__c = key;
                        invoiceRecord.Contact__c = value;
                        invoiceRecord.Amount__c = 1000;
                        invoiceRecord.Month__c = month;
                        invoiceRecord.Year__c = year;
                        invoicesList.add(invoiceRecord);
                    }
                }
            }
        }
        if(invoicesList.size() > 0){
            Insert invoicesList;
        }
    }
    //finish
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
}