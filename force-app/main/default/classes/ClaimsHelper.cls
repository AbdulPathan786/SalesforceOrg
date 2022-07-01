public class ClaimsHelper {
    public static void onAfterInsert(List<Claim__c> claimsList){
        if(claimsList.size() > 0){
            for(Claim__c claim : claimsList){
                if(claim.Status__c == 'Pending'){                  
                    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                    req.setComments('Submitting request for approval automatically using Trigger');
                    req.setObjectId(claim.Id);
                    req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
                    Approval.ProcessResult approvalResult = Approval.process(req);
                    System.debug('offer submitted for approval successfully: '+ approvalResult .isSuccess());
                }
            }
        }
        
    }
}