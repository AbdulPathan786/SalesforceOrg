public class PositionSummaryController {
    
    public List<AggregateResult> lstSummary{get;set;}
    public List<Position__c> lstPosition{get;set;}
    public String positionName{get;set;}
    public String positionId{get;set;}
    
    public PositionSummaryController(){
        lstPosition = [SELECT Name, MaxPay__c, MinPay__c, Status__c, OpenDate__c, CloseDate__c
                       FROM Position__c];
     /*   if(lstPosition.size() > 0){
            for(Position__c objPosition : lstPosition){
                System.debug('Position Record : '+ lstPosition);
            }
        }*/
        lstSummary = [ SELECT sum(MaxPay__c) Maximum, sum(MinPay__c) Mininum, Max(MaxPay__c) MaxPay, Min(MinPay__c)
                      MinPay, Count(Name) cnt FROM Position__c];
    }
    public pageReference PositionDetailPage(){
        //System.debug('Page Details....' + positionId);
        pageReference pg=Page.jobapplication;
        pg.getParameters().put('uniqueId', positionId);
        pg.getParameters().put('uniqueIdName', positionName);
        return pg;
    }
}