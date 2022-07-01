/*
Name        :    contactAuraController
Date        :    12 March 2021
Author      :    Abdul Pathan
Description :     Aura fieldSetContact Columns and data show in page
*/

public class contactAuraController {
    @AuraEnabled(cacheable=true)
    public static List<wrapperContactList> contactFieldSetRecords(){
        List<wrapperContactList> wrapperList = new List<wrapperContactList>();
        List<Columns> columnsList = new List<Columns>();
        
        String queryString = 'SELECt Id';
        for(Schema.FieldSetMember field : SObjectType.Contact.FieldSets.Contact_Field_Set.getFields()){
            queryString += ',' + field.getFieldPath();
            columnsList.add(new Columns(field.label, field.fieldpath));
        }
        queryString += ' FROM Contact limit 20';
        
        List<Contact> contactRecords = Database.query(queryString);
        
        wrapperList.add(new wrapperContactList(columnsList, contactRecords));
        System.debug('wrapperList'+wrapperList);
        return wrapperList;
    }
    //wrapperClass
    public class wrapperContactList{
        @AuraEnabled
        public List<Columns> columns;
        @AuraEnabled
        public List<Contact> contactList;
        public wrapperContactList(List<Columns> columns, List<Contact> contactList){
            this.columns = columns;
            this.contactList = contactList;
        }
    }
    // Columns data
    public class Columns {
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String fieldName;
        public Columns(String label, String fieldName) {
            this.label = label;
            this.fieldName = fieldName;
        }
    }
}