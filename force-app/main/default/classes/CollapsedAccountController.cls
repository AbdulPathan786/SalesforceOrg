/*
Name        :    CollapsedAccountController
Date        :    1April 2021
Author      :    Abdul Pathan
Description :     Aura CollapsedAccount Columns and data show in page
*/
public class CollapsedAccountController {
    /******************************wrapper class and method Start***************************************/
    @AuraEnabled(cacheable=true)
    public static List<wrapperAccountList> getAccount(){
        List<wrapperAccountList> wrapperList = new List<wrapperAccountList>();
        List<Columns> columnsListHorizontal = new List<Columns>();
        List<Columns> columnsListVertical = new List<Columns>();
        List<Columns> columnsListDetails = new List<Columns>();
        
        String queryString = 'SELECt Id';
        for(Schema.FieldSetMember field : SObjectType.Account.FieldSets.Horizontal_fieldset.getFields()){
            queryString += ',' + field.getFieldPath();
            columnsListHorizontal.add(new Columns(field.label, field.fieldpath));
        }
        for(Schema.FieldSetMember field : SObjectType.Account.FieldSets.Vertical_fieldset.getFields()){
            queryString += ',' + field.getFieldPath();
            columnsListVertical.add(new Columns(field.label, field.fieldpath));
        }
        for(Schema.FieldSetMember field : SObjectType.Account.FieldSets.Detail_Fieldset.getFields()){
            queryString += ',' + field.getFieldPath();
            columnsListDetails.add(new Columns(field.label, field.fieldpath));
        }
        queryString += ' FROM Account limit 20';
        
        List<Account> accountRecords = Database.query(queryString);
        
        Map<Integer, List<Account>> mapRecords = new Map<Integer, List<Account>>();
        for(Account accountRecord : [SELECT Id, Name, Phone, Industry, Type, Rating, CreatedDate FROM Account]){
            String year = accountRecord.CreatedDate.format('yyyy');
            Integer myInt = Integer.valueOf(year);
            if(mapRecords.containsKey(myInt)) {
                mapRecords.get(myInt).add(accountRecord);
            } else {
                mapRecords.put(myInt, new List<Account>{accountRecord});  
            }
        }
        
        wrapperList.add(new wrapperAccountList(columnsListHorizontal, columnsListVertical, columnsListDetails, mapRecords));
        //System.debug('wrapperList'+wrapperList);
        return wrapperList;
    }
    //wrapperClass
    public class wrapperAccountList{
        @AuraEnabled
        public List<Columns> columnsHorizontal;
        @AuraEnabled
        public List<Columns> columnsVartical;
        @AuraEnabled
        public List<Columns> columnsDetails;
        // @AuraEnabled/
        // public List<Account> accountList;
        @AuraEnabled
        public Map<Integer, List<Account>> mapRecs;
        
        public wrapperAccountList(List<Columns> columnsHorizontal, List<Columns> columnsVartical, List<Columns> columnsDetails, Map<Integer, List<Account>> mapRecs){
            this.columnsHorizontal = columnsHorizontal;
            this.columnsVartical = columnsVartical; 
            this.columnsDetails = columnsDetails;
            //this.accountList = accountList;
            this.mapRecs = mapRecs;
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
    /******************************wrapper class and method End***************************************/    
    /*************************************************Map start******************************************/
    @AuraEnabled
    public static Map<Integer, List<Account>> getAccountRecords(){
        Map<Integer, List<Account>> mapRecords = new Map<Integer, List<Account>>();
        for(Account accountRecord : [SELECT Id, Name, Phone, Industry, Type,Rating, CreatedDate FROM Account]){
            String year = accountRecord.CreatedDate.format('yyyy');
            Integer myInt = Integer.valueOf(year);
            if(mapRecords.containsKey(myInt)) {
                mapRecords.get(myInt).add(accountRecord);
            } else {
                mapRecords.put(myInt, new List<Account>{accountRecord});  
            }
        }
        return mapRecords;
    }
    /*************************************************Map end******************************************/
}