/*
 * Author : Abdul Pathan
 * Date   : 16-August-2021
 * Description : Opportunity Amount field Insert and Update then Account Field (xyz...) Update
*/
trigger opportunityTrigger on Opportunity (before insert, After Update) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        // Before Insert calculate the total amount of opportunity Records 
        opportunityTriggerHelper.onBeforeInsert(Trigger.new);
    }
    if(Trigger.isAfter && trigger.isUpdate){
        // After Update calculate the total amount of opportunity Records
         opportunityTriggerHelper.onAfterUpdate(Trigger.New, Trigger.oldMap);
    }
    
}