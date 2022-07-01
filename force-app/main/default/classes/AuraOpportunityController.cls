/*
Name        :    CollapsedAccountController
Date        :    1April 2021
Author      :    Abdul Pathan
Description :     Aura CollapsedAccount Columns and data show in page
*/
public class AuraOpportunityController {
    /******************************wrapper class and method******************************************************************************************************************************/
    @AuraEnabled(cacheable=true)
    public static List<wrapperOpportunityList> getOpportunity(){
        List<wrapperOpportunityList> wrapperList = new List<wrapperOpportunityList>();
        List<Columns> columnsListHorizontal = new List<Columns>();
        String queryString = 'SELECt Id';
        for(Schema.FieldSetMember field : SObjectType.Opportunity.FieldSets.Horizontal_fieldset.getFields()){
            queryString += ',' + field.getFieldPath();
            columnsListHorizontal.add(new Columns(field.label, field.fieldpath));
        }
        
        queryString += ' FROM Opportunity limit 20';
        
        List<Opportunity> accountRecords = Database.query(queryString);
        
        Map<Integer, List<Opportunity>> mapRecords = new Map<Integer, List<Opportunity>>();
        for(Opportunity accountRecord : [SELECT Id, ContactId, StageName, Probability, Type, Amount, CreatedDate, CloseDate  FROM Opportunity]){
            String year = accountRecord.CreatedDate.format('yyyy');
            Integer myInt = Integer.valueOf(year);
            if(mapRecords.containsKey(myInt)) {
                mapRecords.get(myInt).add(accountRecord);
            } else {
                mapRecords.put(myInt, new List<Opportunity>{accountRecord});  
            }
        }
        wrapperList.add(new wrapperOpportunityList(columnsListHorizontal, mapRecords));
        System.debug('wrapperList'+ wrapperList);
        return wrapperList;
    }
    
    //wrapperClass
    public class wrapperOpportunityList{
        @AuraEnabled
        public List<Columns> columnsHorizontal;
        @AuraEnabled
        public Map<Integer, List<Opportunity>> mapRecs;
       
        public wrapperOpportunityList(List<Columns> columnsHorizontal, Map<Integer, List<Opportunity>> mapRecs){
            this.columnsHorizontal = columnsHorizontal;
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
}