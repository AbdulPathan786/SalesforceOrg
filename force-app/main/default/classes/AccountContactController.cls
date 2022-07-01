/*
* Developed By Abdul Pathan
* Controller AccountContactController
* Date /02/12/2020
Description : Apex Class Call Lwc
Folder Name :	accountRecord --> accountRecord.html, accountRecord.js, accountRecord.js-meta.xml
Folder Name : 	accountChildRecord --> accountChildRecord.html, accountChildRecord.js
*/

public with sharing class AccountContactController {
    // AccountRecord and AccountChildRecord
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactRecordList(String accId){
        if(accId != null){
            return [SELECT  Id, FirstName, LastName, Phone, Email FROM Contact WHERE AccountId =: accId ];
        }
        else{
            return null;
        }
    }
    
    
    /**********************************************IbirdsAccountRecords******************************************************************************/
    // accountRecordTable  Lwc : accountRecordTable and IbirdsAccountRecords
    @AuraEnabled(cacheable=true)
    public static List<Account> accountRecordList(){
        return [SELECT Id, Name, Phone, BillingCity FROM Account LIMIT 5];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> accountContactRecs(String accountRecId){
        return [SELECT Id, Account.Name, Name, FirstName, LastName, Phone, Email, MailingCity FROM Contact WHERE AccountId =: accountRecId];
    }//end
    
    /*************************************************accountContactDetails *****************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Account> accountSearchCityName(String searchCity){
        if(searchCity != ''){
            return [SELECT Id, Name, Phone, BillingCity FROM Account WHERE BillingCity =: searchCity];
        }
        else{
            return [SELECT Id, Name, Phone, BillingCity FROM  Account LIMIT 10 ];
        }  
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> accountChildRecord(String accId){
        return [SELECT Id, Name, FirstName, LastName, Email, Phone FROM  Contact WHERE AccountId =: accId];
    } //end 
    
    /***********************************accountRecordsCustom********************** Nisar Sir Asgmnt***********05/02/2021*****************************************/
    @AuraEnabled(cacheable=true)
    public static List<wrapperAccountList> accountDetails(String accId){
        //System.debug('accId'+ accId);   
        List<wrapperAccountList> wrapperList=new List<wrapperAccountList>();
        String conVer = '';
        List<Account> accRecs = [SELECT Id, Name, Type, Phone, Industry, BillingCity FROM Account WHERE Id =: accId];
        List<ContentDocumentLink> docLinkRec = [SELECT id,ContentDocumentId, ShareType FROM ContentDocumentLink 
                                                WHERE LinkedEntityId =: accRecs[0].id];
        if(docLinkRec.size()>0){
            List<ContentVersion> conVersion =[SELECT Id, ContentDocumentId FROM ContentVersion 
                                              WHERE ContentDocumentId =: docLinkRec[0].ContentDocumentId ];
            if(conVersion.size()>0){
                conVer = conVersion[0].Id;
            }
        }
        if(accRecs.size()>0){
            for(Account accRec : accRecs){  
                wrapperList.add(new wrapperAccountList(accRec, conVer));
            }
        }
        return wrapperList;
    }
    // wrapper class
    public class wrapperAccountList{
        @AuraEnabled
        public Account accRecord;
        @AuraEnabled
        public String conVersionId;
        public wrapperAccountList(Account accRecord, String conVersionId){
            this.accRecord = accRecord;
            this.conVersionId = conVersionId;
        }
    }//end
    /**********************************************************************************************/
   
}