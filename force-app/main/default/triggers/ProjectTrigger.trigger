/*
* Name         : ProjectTrigger
* Author       : Abdul Pathan
* Date         : 20 Feb, 2020
* Description  : Project(Parent) Record insert then Project_Task(Child) Record create (five record create)
*/

trigger ProjectTrigger on Project__c (After insert) {
    if(Trigger.isInsert && Trigger.isAfter){
        ProjectTriggerHelper.insertProjectTasks(trigger.new);
    }
}