public class JobApplicationListController {
    public List<WrapperJobApplication> lstWrapperJobApplication{get;set;}
    private List<JobApplication__c> lstJobApplication;
    
    public JobApplicationListController(){
        lstWrapperJobApplication = new  List<WrapperJobApplication>();
        lstJobApplication = [SELECT Name, Position__c, Candidate__c , Status__c, TotalRating__c,CoverLetter__c,NumberOfReviews__c, AverageRating__c
                             FROM JobApplication__c Limit 10
                            ];
        if(lstJobApplication.size() > 0){
            for(JobApplication__c objJobApplication : lstJobApplication){
                WrapperJobApplication objWrapperJobApplication = new WrapperJobApplication(objJobApplication);              
                lstWrapperJobApplication.add(objWrapperJobApplication);
            }
        }
    }
    public void EditJobApplication(){}
    public void DeleteJobApplication(){}
    
    public class WrapperJobApplication{
        public JobApplication__c objJobApplication {get;set;}
        public Boolean Selected{get;set;}
        
        public WrapperJobApplication(JobApplication__c obj){
            this.objJobApplication = obj;
            Selected = false;
        }
    }
    
}