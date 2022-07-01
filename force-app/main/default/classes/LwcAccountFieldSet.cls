/*
Name        :    AccountFieldSetController 
Date        :    4, March 2021
Author      :	Abdul Pathan
Description :   Lwc fieldSetAccount Columns and data show in page

*/
public class LwcAccountFieldSet{
    @AuraEnabled(cacheable=true)
    public static List<wrapperAccountList> accountFieldSetRecords(){
        List<wrapperAccountList> wrapperList = new List<wrapperAccountList>();
        List<Columns> columnsList = new List<Columns>();
        
        String queryString = 'SELECt Id';
        for(Schema.FieldSetMember field : SObjectType.Account.FieldSets.Detail_Fieldset.getFields()){
            queryString += ',' + field.getFieldPath();
            columnsList.add(new Columns(field.label, field.fieldpath));
        }
        queryString += ' FROM Account limit 20';
        
        List<Account> accountRecords = Database.query(queryString);
        
        wrapperList.add(new wrapperAccountList(columnsList, accountRecords));
        System.debug('wrapperList- ' + wrapperList);
        return wrapperList;
    }
    //wrapperClass
    public class wrapperAccountList{
        @AuraEnabled
        public List<Columns> columns;
        @AuraEnabled
        public List<Account> accountList;
        public wrapperAccountList(List<Columns> columns, List<Account> accountList){
            this.columns = columns;
            this.accountList = accountList;
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
//SELECT Id, DeveloperName, MasterLabel, Label, QualifiedApiName, Data_Table_Object__r.MasterLabel FROM Data_Table_Field__mdt