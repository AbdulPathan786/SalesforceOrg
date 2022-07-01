/*
* @Name         : ProjectBatch
* @Author       : Abdul Pathan
* @Date         : 20 Feb, 2020
* @Description  : Project Batch Class And Schedule
*/
global class ProjectBatch implements Database.Batchable<sobject>{
    //  private String query;
    public ProjectBatch(){
        // query = 'SELECT Name, Status__c, (Select Project__c,Type__c  from Project_Tasks__r where Type__c = \'Contract End\') FROM Project__c where Status__c = \'Deployment\'';
    }
    // Start Method
    global Database.QueryLocator start(Database.BatchableContext bc){
        String  query = 'SELECT Name, Status__c, Project_Owner__c, (Select Project__c,Type__c, OwnerId  from Project_Tasks__r where Type__c = \'Contract End\') FROM Project__c where Status__c = \'Deployment\'';
        return Database.getQueryLocator(query);
    }
    // execute Method
    global void execute(Database.BatchableContext bc, List<Project__c> lstProjects){
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();   //list of emails
        List<EmailTemplate> lstEmailTemplate = [SELECT id, Name, IsActive  FROM EmailTemplate
                                                WHERE DeveloperName  = 'ProjectEmailTemplateSignOff' OR DeveloperName  = 'ProjectEmailTemplatesCompleted'
                                               ];
        if(lstEmailTemplate.size() > 1){
            for(Project__c objProject : lstProjects){
                Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();  
                singleMail.setTargetObjectId(objProject.Project_Owner__c);  
                singleMail.setTemplateId(lstEmailTemplate.get(0).Id); 
                singleMail.setWhatId(objProject.id); 
                singleMail.setSaveAsActivity(false);  
                emailList.add(singleMail);  
                
                singleMail = new Messaging.SingleEmailMessage();
                Project_Task__c objTask = objProject.Project_Tasks__r;
                singleMail.setTargetObjectId(objTask.OwnerId);  
                singleMail.setTemplateId(lstEmailTemplate.get(1).Id); 
                singleMail.setWhatId(objProject.id);
                singleMail.setSaveAsActivity(false);  
                emailList.add(singleMail);
            }
        }
        if(emailList.size() > 0){
            Messaging.sendEmail(emailList);
        }
    }
    // finish Method
    global void finish(Database.BatchableContext bs){
    }
}
/*
Batch Class Run Anonymous Window
ProjectBatch objProjectBatch = new ProjectBatch();
Id batchId = Database.executeBatch(objProjectBatch);
*/