/*
Name        :    AccountTriggerHelper 
Date        :    17, March 2021
Author      :   Abdul Pathan
Description :   

*/
trigger AccountTrigger on Account (after insert, after update, before delete, after delete){
    // afterInsert 17 March 21 //Account insert then contact insert automatically
    if(trigger.isAfter && trigger.isInsert ){
        AccountTriggerHelper.afterInsert(trigger.New);
        //AccountTriggerHelper.afterInsert2(trigger.New);
    }
    // afterUpadate 
    //Account website update then contact Profile update  //Account website update then contact Profile update
    //account contact Information field update then Conatact Insert
    // Account fax field update then contact fax field update 12 July 2021
    if(Trigger.isAfter && Trigger.isUpdate){
        AccountTriggerHelper.afterUpdate(trigger.New, trigger.oldMap);
        //AccountTriggerHelper.afterUpdate2(trigger.New, trigger.oldMap);
    }
    // Before Account record Not delete bcz more then two child available (error message) 12 July 2021
    if(Trigger.isBefore && trigger.isDelete){
        AccountTriggerHelper.beforeDelete(trigger.old);
    }
    // wrapperAddList Account update then after update contact insert 
    if(Trigger.isAfter && Trigger.isUpdate){
        //wrapperAddList accountBatch = new wrapperAddList(trigger.New);
        //  database.executeBatch(accountBatch);
    }
    
}