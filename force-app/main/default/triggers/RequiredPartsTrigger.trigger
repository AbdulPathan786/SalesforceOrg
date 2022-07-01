/*
* Author  :  Abdul Pathan
* Name    :  RequiredPartsTrigger
* Date    :  09, Nov 2021
* Description  : I create and update the Required Parts records, then automatically update the parent records (product2) field Total Price
*/
trigger RequiredPartsTrigger on Required_Parts__c (After Insert, After Update, After Delete) {
    // afterInsert
    if(Trigger.isAfter && Trigger.isInsert){
        RequiredPartsHelper.onAfterInsert(trigger.new);
    }
    // afterUpdate
    if(Trigger.isAfter && Trigger.isUpdate){
        RequiredPartsHelper.oAfterUpdate(trigger.new, trigger.oldMap);
    }
    // AfterDelete
    if(Trigger.isAfter && trigger.isDelete){
        RequiredPartsHelper.onAfterDelete(trigger.old);
    } 
}