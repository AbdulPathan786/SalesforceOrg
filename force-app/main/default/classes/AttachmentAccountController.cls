/*
* Developed By Abdul Pathan
* Controller AttachmentAccountController
* Description : This Class user for account attachment related list fetch  (LWC Name : accountRecordsCustom)
*/
public with sharing class AttachmentAccountController{
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
        @AuraEnabled public Account accRecord;
        @AuraEnabled public String conVersionId;
        public wrapperAccountList(Account accRecord, String conVersionId){
            this.accRecord = accRecord;
            this.conVersionId = conVersionId;
        }
    }//end
}