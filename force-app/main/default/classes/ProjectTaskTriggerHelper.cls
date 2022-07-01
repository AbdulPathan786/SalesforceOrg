/*
* @Name         : ProjectTaskTriggerHelper
* @Author       : Abdul Pathan
* @Date         : 20 Feb, 2020
* @Description  : Project_Task(Child) Record update then Project(Parent) Record update 
                  Project_Task Notes & Attachments &  Send Email
*/

public class ProjectTaskTriggerHelper {
    // public static void updateProjectTasks(List<Project_Task__c> projectTaskList){
    public static void updateProjectTasks(Set<Id> projectSet){
        List<Project__c> projectList = new List<Project__c>();
        // Set<Id> setId = new Set<Id>();
        List<Project_Task__c> projectTaskList = [SELECT Id, Project__c, Name, Type__c, Completed__c, Previous_Task__c 
                                                 FROM Project_Task__c WHERE id =: projectSet
                                                ];
        for(Project_Task__c projectTaskObj : projectTaskList){
            // setId.add(projectTaskObj.Id);
            if(projectTaskObj.Completed__c == true ){
                Project__c projectObj = new Project__c();
                projectObj.Id = projectTaskObj.Project__c;
                
                if(projectTaskObj.Type__c == 'New Task'){
                    projectObj.Status__c = 'New';
                }else if(projectTaskObj.Type__c == 'Planning Phase'){
                    projectObj.Status__c = 'Planning';
                }
                else if(projectTaskObj.Type__c == 'Construction Work'){
                    projectObj.Status__c = 'Construction';
                }
                else if(projectTaskObj.Type__c == 'Completion Step'){
                    projectObj.Status__c  = 'Deployment';
                }
                else if(projectTaskObj.Type__c == 'Contract End'){
                    projectObj.Status__c  = 'Signoff';
                }
                projectList.add(projectObj);
            }
        }
        if(projectList.size() > 0){
            update projectList;
        }
    } 
    
    // attachmentProjectTasks Notes & Attachments
    public static void attachmentProjectTasks(List<Project_Task__c> projectTaskList){
        Set<id> projectTaskSetId = new Set<Id>();
        
        for(Project_Task__c objProjectTasks : projectTaskList){
            projectTaskSetId.add(objProjectTasks.id);
        }
        List<Project_Task__c>  lstProjectTask = [SELECT Id, Completed__c, (SELECT id, Description  from Attachments) 
                                                 FROM Project_Task__c WHERE id =: projectTaskSetId
                                                ];
        for(Project_Task__c objProjectTask : lstProjectTask){
            Boolean attachmentStatus = false;
            if(objProjectTask.Completed__c == true){
                for(Attachment objAttachment : objProjectTask.Attachments){
                    if(objAttachment.Description == 'Terms & Conditions'){
                        attachmentStatus = true;
                        break;   
                    }
                } 
                if(attachmentStatus == false){
                    for(Project_Task__c projectTaskObj : projectTaskList){
                        if(objProjectTask.Id == projectTaskObj.Id ){
                            if(projectTaskObj.Completed__c == true){
                                projectTaskObj.addError('Terms & Conditions not found');
                            }                        
                        }
                    }
                }
            }
        }
    }
    
    //ProjectTaskTriggerHelper send email  
    public static List<Project_Task__c> sendEmail(Set<Id> projectSet){
        //query on template object
        EmailTemplate objEmailTemplate = [Select id from EmailTemplate where name = 'ProjectTaskEmailTemplates'];
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();   //list of emails
        
        List<Project_Task__c> projectTaskList = [SELECT  Project__c, Completed__c, Project__r.Project_Owner__r.id, Project__r.Project_Owner__r.email
                                                 FROM Project_Task__c
                                                 WHERE id =: projectSet
                                                ];
        // loop
        for(Project_Task__c objProjectTask : projectTaskList){
            //check for Project Id 
            if(objProjectTask.Completed__c == true ){
                if(objProjectTask.Project__r.Project_Owner__r.id != null && objProjectTask.Project__r.Project_Owner__r.email != null ){
                    Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();  //initiallize messaging method
                    singleMail.setTargetObjectId(objProjectTask.Project__r.Project_Owner__r.id);  //set object Id
                    singleMail.setTemplateId(objEmailTemplate.Id); //set template Id
                    singleMail.setWhatId(objProjectTask.Project__c); //set What Id
                    singleMail.setSaveAsActivity(false);  //flag to false to stop inserting activity history
                    emails.add(singleMail);   //add mail
                }
            }
        }
        Messaging.sendEmail(emails);
        return projectTaskList;
    }
}