/*
* Name         : ProjectTriggerHelper
* Author       : Abdul Pathan
* Date         : 20 Feb, 2020
* Description  : Project(Parent) Record insert then Project_Task(Child) Record create (five record create)
*/

public class ProjectTriggerHelper {
    public static void insertProjectTasks(List<Project__c> projectList){
        
        List<Project_Task__c> projectTaskList = new List<Project_Task__c>();
        
        if(projectList.size() > 0){
            for(Project__c projectObj : projectList){          
                projectTaskList.add(new Project_Task__c(Project__c =projectObj.Id , Type__c = 'New Task'));
                projectTaskList.add(new Project_Task__c(Project__c =projectObj.Id , Type__c = 'Planning Phase'));
                projectTaskList.add(new Project_Task__c(Project__c =projectObj.Id , Type__c = 'Construction Work'));
                projectTaskList.add(new Project_Task__c(Project__c =projectObj.Id , Type__c = 'Completion Step'));
                projectTaskList.add(new Project_Task__c(Project__c =projectObj.Id , Type__c = 'Contract End'));
            }
        }
        
        
        // Insert  project Task Record
        if(projectTaskList.size() > 0){
            insert projectTaskList;
        }
        
        Integer count = 0;   // Index Count Previous Task
        List<Project_Task__c> projectTaskRecords = new List<Project_Task__c>();
        if(projectTaskList.size() > 0){
            for(Project_Task__c projectTaskObj : projectTaskList){
                
                if(projectTaskObj.Type__c != 'New Task' ){
                    projectTaskObj.Previous_Task__c = projectTaskList[count].id;
                    count++;
                    projectTaskRecords.add(projectTaskObj);
                }
            }
        }
        
        // update  Project Task Record
        if(projectTaskRecords.size() > 0){
            update projectTaskRecords;
        }
    }   
}