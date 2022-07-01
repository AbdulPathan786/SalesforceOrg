public class JobApplicationController {
    
    public List<AggregateResult> Result{get;set;}
    public List<JobApplication__c> lstJobApplication{get;set;}
    public String recordId;
    public String recordName{get;set;}
    
    public JobApplicationController(){
        recordId = ApexPages.currentPage().getParameters().get('uniqueId');
        recordName = ApexPages.currentPage().getParameters().get('uniqueIdName');
        System.debug('Record id ' + recordId);
        
        Result = [SELECT Count(Id) cnt , Candidate__r.City__c city, Position__r.Name
                  FROM JobApplication__c
                  WHERE Position__c = : recordId OR Position__c = : recordName
                  group by Candidate__r.City__c, Position__r.Name
                 ];
        if(Result.size() == 0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Record available'));
        }
      /*  System.debug('Result List ' + Result);  
        if(Result.size() > 0){
            for(AggregateResult obj : Result){
                System.debug('Result Lists ' + obj);
            }
        } */
    }
  public PageReference CanselButton(){
      PageReference pg=page.positionsummary;
      return pg;
    }
    
}