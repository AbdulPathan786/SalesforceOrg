/*
* Name         : ContactSearchRecordController
* Author       : Abdul Pathan
* Date         : 9 Nov, 2020
* Description  : use by Lightning Web Component folder name : contactSearch and contactRecordSearch  
*/
//ContactRecordSearchController
public with sharing class LwcContactRecs{
    
    //********************************** (contactSearchPubsubChild) contactSearchPubsubParent********************************
    @AuraEnabled(cacheable=true)
    public static List<Contact> ContactSearchCityRecords(String cName){
        if(cName == 'All'){
            return [Select FirstName, LastName, Phone,Email, MailingCity  From Contact limit 10];
        }
        else{
            return [Select FirstName, LastName, Phone,Email, MailingCity  From Contact WHERE MailingCity =: cName ];
        }      
    }//end
    
    /*************************** ContactRecordSearchByName *********************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Contact> ContactRecords(String SearchContactName, String SearchContactCity){
        String contactName = '%'+SearchContactName+'%';
        String contactCity = '%'+SearchContactCity+'%';
        return [SELECT Name, Phone, Email, MailingCity  FROM Contact 
                Where ( Name like: contactName OR MailingCity Like : contactCity ) 
                ORDER By CreatedDate DESC
               ];
    }//end
    
    //***********************ContactSearchPickListDynamic*******************************************/
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactList(String cName){ 
        if(cName == 'All')
            return [SELECT Name, Phone, Email, MailingAddress, MailingCity FROM Contact Limit 10];
        else
            return [SELECT Name, Phone, Email, MailingAddress, MailingCity FROM Contact WHERE MailingCity =: cName ];
    }
    @AuraEnabled(cacheable=true)
    public static List<String> contactCities(){
        Set<String> setContact=new Set<String>();   
        List<String> lstContactRecord=new List<String>();
        for(Contact contactRecord : [SELECT MailingCity, Name FROM Contact WHERE MailingCity <> null]){
            setContact.add(contactRecord.MailingCity);	
        }
        lstContactRecord.addAll(setContact);
        return lstContactRecord;
    }//end
    
    /**************************** ContactTab**********************************************************************************************/
    // contact Records
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactRecs(){
        return [SELECT Id, Name, FirstName, LastName, Phone FROM Contact LIMIT 5];
    }//end
    
    /***********************************paginationParentComp********************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactRecList(Integer pagenumber, Integer numberOfRecords, Integer pageSize, String searchString){
        String searchKey = '%' + searchString + '%';  
        String query = 'SELECT Id, FirstName, LastName, Email, Phone FROM Contact';
        if(searchString != null && searchString != ''){
            query += ' WHERE LastName like \'%' + searchString + '%\' ';
        }
        query += ' LIMIT ' + pageSize + ' offset ' + (pageSize * (pagenumber - 1));
        return Database.query(query);
    }
    @AuraEnabled(cacheable=true)
    public static Integer contactRecCount(String searchString){
        String query = 'SELECT count() FROM Contact';
        if (searchString != null && searchString != '') {  
            query += ' WHERE LastName like \'%' + searchString + '%\' ';  
        }  
        return Database.countQuery(query); 
    }
    /* columns Name
@AuraEnabled(cacheable=true)
public static List<Data_Table_Field__mdt> dataTableFields(){
List<Data_Table_Field__mdt> dataTabelFields = [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label,
QualifiedApiName,Data_Table_Object__r.MasterLabel 
FROM Data_Table_Field__mdt];
//System.debug('dataTabelFields' + dataTabelFields);
return dataTabelFields;
}*/
    
}