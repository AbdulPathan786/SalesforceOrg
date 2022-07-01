/*
Name        :    CollapsedAccountController
Date        :    1April 2021
Author      :    Abdul Pathan
Description :     Aura CollapsedAccount Columns and data show in page
*/
public class AuraAccountController {
    @AuraEnabled(cacheable=true)
    public static List<wrapperAccountList> fatchAccountRecords(){
        List<wrapperAccountList> wrapperList = new List<wrapperAccountList>();
        List<Columns> columnsList = new List<Columns>();
        String caseRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Account_Record_Type').getRecordTypeId();
        
        String queryString = 'SELECt Id';
        for(Schema.FieldSetMember field : SObjectType.Account.FieldSets.Horizontal_fieldset.getFields()){
            queryString += ',' + field.getFieldPath();
            columnsList.add(new Columns(field.label, field.fieldpath));
        }
        queryString += ' FROM Account LIMIT 20';
       
        List<Account> accountRecords = Database.query(queryString);
        
        wrapperList.add(new wrapperAccountList(columnsList,accountRecords));
        
        System.debug('wrapperList' + wrapperList);
        return wrapperList;
        
    }
    // wrapper class
    public class wrapperAccountList{
        @AuraEnabled
        public List<Columns> columns;
        @AuraEnabled
        public List<Account> accountList;
        public wrapperAccountList(List<Columns> columns,List<Account> accountList){
            this.columns=columns;
            this.accountList=accountList;
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