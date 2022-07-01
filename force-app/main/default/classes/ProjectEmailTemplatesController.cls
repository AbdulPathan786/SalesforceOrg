/*
* @Name         : ProjectEmailTemplatesController
* @Author       : Abdul Pathan
* @Date         : 20 Feb, 2020
* @Description  : Project Tasks compeleted then send email  (component Name = projectemailtemplates)
*/
public class ProjectEmailTemplatesController{
    public Boolean projectTaskBoolean{get;set;}
    public String ownerName{get;set;}
    public String projectId{get;set;}
    public List<Project_Task__c> lstProjectTask{get;set;}
    public List<Project_Task__c> lstProjectTaskName{get;set;}
    
    public ProjectEmailTemplatesController(){
        //  ProjectTasks()
    }
    
    // ProjectTasks Method
    public List<Project_Task__c> getProjectTasks(){
        lstProjectTask = [SELECT Id,  Project__c, CreatedDate, Completion_Date__c, Type__c, Owner.Name ,
                          Project__r.Project_Owner__c, Project__r.Project_Owner__r.Name  
                          FROM Project_Task__c
                          where Project__c =: projectId AND Completed__c = true
                         ];
        return lstProjectTask;
    }
    
    public String getProjectTaskName(){
        lstProjectTaskName = [SELECT id, Type__c, Owner.Name FROM Project_Task__c   
                              where Project__c =: projectId 
                             ];
        for(Project_Task__c objProjecttask : lstProjectTaskName){
            if(objProjecttask.Type__c == 'Contract End'){	
                ownerName = objProjecttask.Owner.Name;
            }
        }
        return ownerName;
    }
}