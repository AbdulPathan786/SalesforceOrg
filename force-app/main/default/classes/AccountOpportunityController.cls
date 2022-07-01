/*
* Developed By Abdul Pathan
* Controller AccountOpportunityController
* Date 
Description : Apex Class Call Lwc
Folder Name :	
Folder Name : 	
*/

public with sharing class AccountOpportunityController {
    // 
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> opportunityRecords(String accountId){
        return [SELECT Id, AccountId, CloseDate, Name, Probability, StageName 
                                     FROM Opportunity 
                                     WHERE AccountId =: accountId AND (StageName != 'Closed Won' AND StageName != 'Closed Lost')
                                    ];
    }
}