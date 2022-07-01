trigger CalendarEventTrigger on Calendar_Event__c (After Insert, After Update) {
    
    if(trigger.isAfter && trigger.isInsert){
        //CalendarEventTriggerHelper.onAfterInsert(trigger.new);
    }
    if(trigger.isAfter && trigger.isUpdate){
        //CalendarEventTriggerHelper.onAfterUpdate(trigger.new, trigger.oldMap);
    }
}