/*
* Name         : LwcContactController
* Author       : Abdul Pathan
* Date         : 23 Aug 2021
* Description  : use by Lightning Web Component folder name :  contactRecords 
*/

public  with sharing class LwcContactController {
    /****************************** Contact Records get********************************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<ContactWrapper> getcontactRecords(){ 
        List<ContactWrapper> contactWrapperList = new List<ContactWrapper>();
        List<Contact> contactList = [Select Id, Name, Phone, Email, MailingCity From Contact ORDER By CreatedDate DESC limit 10];
        Integer count = 0;
        for(Contact contactRecord : contactList){
            count++;
            contactWrapperList.add(new ContactWrapper(contactRecord, count));
        }
        return contactWrapperList;
    }
    
    public class ContactWrapper{
        @AuraEnabled
        public Contact contactRecs{get;set;}
        @AuraEnabled
        public Integer num{get;set;}
        public ContactWrapper(Contact contactRecs, Integer num){
            this.contactRecs = contactRecs;
            this.num = num;
        }
    }
    /**************************************Contact Record Insert*****************************************************************************************/
    // Contact Records Insert
    @AuraEnabled
    public static void createContactRecords(String firstName, String lastName, String email, String phone, String city){
        List<Contact> contactList = new List<Contact>();
        Contact contactRecord = new Contact();
        contactRecord.FirstName = firstName;
        contactRecord.LastName = lastName;
        contactRecord.Email = email;
        contactRecord.Phone = phone;
        contactRecord.MailingCity = city;
        contactList.add(contactRecord);
        if(contactList.size() > 0){
            Insert contactList;
        }
    }
    /**********************************************************************************************************************************************************/
}