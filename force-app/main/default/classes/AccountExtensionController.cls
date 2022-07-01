public class AccountExtensionController {
   public List<Case> caseList {get; set;}
   public Account currentRecord    {get; set;}
   public AccountExtensionController(ApexPages.StandardController controller) {
       caseList = new List<Case>();
       Id accountId = ApexPages.currentPage().getParameters().get('id');
       if(accountId != null){
           caseList = [ SELECT Id, AccountId, Type, Status, Origin, Subject, Reason, Priority, Description, Product__c 
                       FROM Case WHERE AccountId =:accountId
                      ];
       }
       System.debug('caseList-->'+ caseList);
   }
}