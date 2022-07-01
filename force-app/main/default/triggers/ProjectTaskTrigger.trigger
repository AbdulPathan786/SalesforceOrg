/*
* Name         : ProjectTaskTrigger
* Author       : Abdul Pathan
* Date         : 20 Feb, 2020
* Description  :  Project_Task(Child) Record update then Project(Parent) Record update 
ProjectTasks attachment Notes & send Email
*/

trigger ProjectTaskTrigger on Project_Task__c (After update) {  
    Set<Id> projectSet = new Set<Id>();
    
    if(Trigger.isUpdate && Trigger.isAfter){
        for(Project_Task__c obj : Trigger.New){
            if(trigger.oldMap.get(obj.id).Completed__c == false){
                projectSet.add(obj.Id);
            }
        }
        //ProjectTaskTriggerHelper class for updateProjectTasks() call
        ProjectTaskTriggerHelper.updateProjectTasks(projectSet);
        
        //ProjectTaskTriggerHelper class for attachmentProjectTasks() call
        ProjectTaskTriggerHelper.attachmentProjectTasks(Trigger.new);
        
        //ProjectTaskTriggerHelper class for sendEmail() call and  single email but bulk messages
        ProjectTaskTriggerHelper.sendEmail(projectSet);
    }
}