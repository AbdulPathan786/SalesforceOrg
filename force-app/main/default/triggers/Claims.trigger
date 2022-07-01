trigger Claims on Claim__c (after Insert, after Update) {
    if(trigger.isInsert && trigger.isAfter){
        ClaimsHelper.onAfterInsert(trigger.new);
    }
}