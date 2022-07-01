// Author : Abdul Pathan
// Date : 07-Oct-2021
// Class :  claimApprovedRejectComponent
public class claimApprovedRejectComponent {
    @AuraEnabled(cacheable=true)
    public static List<Claim__c> setViewStat(String accountId) {
        List<Claim__c> claimRecords = [SELECT Id, Status__c, Owner.Name, CreatedBy.Name, Name, CreatedDate, LastModifiedDate, Accounts__r.Name 
                                       FROM Claim__c
                                       WHERE Accounts__c =: accountId AND Status__c =: 'Approve'
                                      ];
        return claimRecords;
    }
}
/*
@AuraEnabled 
public static Map<String, String> getStatusFieldValue(){
Map<String, String> options = new Map<String, String>();
Schema.DescribeFieldResult fieldResult = Claim__c.Status__c.getDescribe();
List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
for (Schema.PicklistEntry p: pValues) {
options.put(p.getValue(), p.getLabel());
}
System.debug('options' + options);
return options;
}
*/