/*
* Author  :  Abdul Pathan
* Name    :  ProductTrigger
* Date    :  09, Nov 2021
* Description  : I create the product record, then automatically five child records (Required Pards) created
*/
trigger ProductTrigger on Product2 (after Insert, before Insert) {
    //AfterInert
    if(Trigger.isInsert && Trigger.isAfter){
        ProductHelper.onAfterInsert(trigger.new);
    }
}