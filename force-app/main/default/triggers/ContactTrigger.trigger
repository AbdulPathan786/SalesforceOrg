/*
Name        :    ContactTriggerHelper
Date        :    18th Jan 2021
Author      :    Abdul Pathan
Description :   
*/

trigger ContactTrigger on Contact (before insert, before update, after Insert, after Update, after delete, after undelete) {  
    // contact Dead field update then Account Need Intel field update
    // Contact Rating field update then Account Rating field automatically update
    // Account and Contact update 
    if(Trigger.isAfter && Trigger.isUpdate){
        ContactTriggerHelper.afterUpdate(Trigger.New, Trigger.oldMap);
    }
    
    // before insert Records duplicate email not insert
    if(trigger.isBefore && trigger.isInsert){
        ContactTriggerHelper.onBeforeInsert(trigger.New);
    }
    
    // before update trigger duplicate email not update
    if(trigger.isBefore && trigger.isUpdate){
        ContactTriggerHelper.onBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
    
    // how to delete contact record then contact Record associate with Account record add error message (contact delete then account automatic delete)
    if(trigger.isDelete){
        ContactTriggerHelper.onAfterDelete(trigger.old);
    }  
    
    // Account Count Contact Records date 11 aug 2021 add by Abdul Pathan
    if(Trigger.isAfter && (trigger.isInsert || Trigger.isUpdate || trigger.isundelete)){
        ContactTriggerHelper.contactCountRecords(trigger.new);
    }
    if(Trigger.isAfter && Trigger.isDelete){ // Account Child Records Count date 11 aug 2021 add by Abdul Pathan
        ContactTriggerHelper.contactCountRecords(trigger.old);
    }
   
}