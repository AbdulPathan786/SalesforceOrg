/*
* Name         : LoginPageController
* Author       : Abdul Pathan
* Date         : 15 Feb, 2020
* Description  : This is Question Answer Page Controller 
*/

public class QuestionAnswerController {
    
    public List<Servey_Questions__c> lstSurveyQuestions{get;set;}
    public List<PieWedgeData> lstPieWedgeData{get;set;}
    List<AggregateResult> lstResult;
    private List<Servay__c> lstServay;
    private String recordId{get;set;}
    public String options{get;set;}
    private Integer counter = 0;
    private Integer listSize = 1;
    private Integer totalSize;
    
    //  Constructor
    public QuestionAnswerController(){      
        options = '';
        totalSize = [SELECT  count() FROM Servey_Questions__c];
        recordId = ApexPages.currentPage().getParameters().get('uniqueId');
        refreshList();
        checkOptions();
    }
    
    // refreshList() call Constructor
    public void refreshList(){
        lstSurveyQuestions = [SELECT Id, Question__c, OptionA__c, OptionB__c, OptionC__c, OptionD__c
                              FROM Servey_Questions__c
                              limit : listSize OFFSET : counter
                             ];
    } 
    
    // checkOptions() call Constructor
    public void checkOptions(){
        lstServay = [SELECT Id, Answer__c
                     FROM Servay__c
                     WHERE Contact__c =: recordId AND Servey_Questions__c =: lstSurveyQuestions[0].id
                    ];
        if(lstServay.size() > 0){
            options = lstServay[0].Answer__c;
        }
    }
    
    // pagination
    public void pagination(){
        String query = 'SELECT Id, Question__c, OptionA__c, OptionB__c, OptionC__c, OptionD__c FROM Servey_Questions__c limit : listSize OFFSET : counter';
        if(totalSize != null && totalSize == 0){
            List<Servey_Questions__c> conTemp = Database.query(query);
            totalSize = (conTemp != null && conTemp.size()>0) ? conTemp.size() : 0;
        }
        lstSurveyQuestions = Database.query(query);
    }
    
    // next and save Servey 
    public PageReference next() {
        List<Servay__c> updateServey = new   List<Servay__c>();
        lstServay = [SELECT Id, Contact__c, Servey_Questions__c, Answer__c
                     FROM Servay__c
                     WHERE Contact__c =: recordId AND Servey_Questions__c =: lstSurveyQuestions[0].id
                    ];
        
        if(lstServay.size() > 0){
            for(Servay__c obj : lstServay){
                obj.Answer__c = Options;
                updateServey.add(obj);
            }
        }
        else{
            Servay__c objServay2 = new Servay__c(Contact__c = recordId, Answer__c = Options, Servey_Questions__c = lstSurveyQuestions[0].id);
            insert objServay2;
        }
        if(updateServey.size() > 0 ){
            update updateServey;
        }
        if((totalSize-1) > counter){
            counter++;
        }
        else{
            counter = 0;
        }
        pagination();
        checkOptions();
        return null;
    }
    
    // Cancel Button 
    public PageReference cancelButton(){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Record Cancel'));
        PageReference pg = page.loginpage;
        return pg;
    }
    
    // Pie Chart 
    public List<PieWedgeData> getPieData() {
        List<PieWedgeData> data = new List<PieWedgeData>();
        lstResult = [SELECT COUNT(id) cnt, Answer__c 
                     FROM Servay__c
                     WHERE Servey_Questions__c =: lstSurveyQuestions[0].id
                     GROUP BY Answer__c
                    ];
        // System.debug('lstResult' + lstResult);
        for(AggregateResult objResult : lstResult){
            String str = String.valueOf(objResult.get('Answer__c'));
            Integer abc = Integer.valueOf(objResult.get('cnt'));
            data.add(new PieWedgeData(str, abc));
        }
        return data;
    }
    
    // Wrapper class
    public class PieWedgeData {
        public String name;
        public Integer data;
        public PieWedgeData(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
    
    // logout() click button then loginpage
    public PageReference logout(){
        PageReference newPage = new PageReference('/apex/loginpage');
        newPage.setRedirect(true);
        return newPage;
    }

}