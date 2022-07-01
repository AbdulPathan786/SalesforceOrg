public class ClaimsController {
    public List<Claim__c> getClaimIds;
    
    public ClaimsController(ApexPages.StandardSetController controller) {
        getClaimIds = controller.getSelected();
    }
    
    /************************Approval*********************************************/
     // pageReference
    public pageReference approvedClaims(){
        /* Set<Id> setIds = new Set<Id>();
            for(Claim__c claim: getClaimIds){
            setIds.add(claim.Id);
            }
		*/
        List<ProcessInstanceWorkitem> workItems = [ SELECT Id, ProcessInstanceId FROM ProcessInstanceWorkitem  WHERE ProcessInstance.TargetObjectId =: getClaimIds ];
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        for(ProcessInstanceWorkitem workItem : workItems){
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setWorkitemId(workItem.Id);
            //Valid values are: Approve, Reject, or Removed. 
            //Only system administrators can specify Removed.
            req.setAction('Approve');
            req.setComments('Your Comment.');
            requests.add(req);
        }
        Approval.ProcessResult[] processResults = Approval.process(requests);        
        pageReference pg = new pageReference('/lightning/o/Claim__c/list?filterName=00B2w00000HbCkiEAF');
        return pg;
    }
    /***************************Reject**************************************************************/
    // pageReference
    public pageReference claimRejected(){
        List<ProcessInstanceWorkitem> workItems = [ SELECT Id, ProcessInstanceId FROM ProcessInstanceWorkitem  WHERE ProcessInstance.TargetObjectId =: getClaimIds ];
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        for(ProcessInstanceWorkitem workItem : workItems){
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setWorkitemId(workItem.Id);
            //Valid values are: Approve, Reject, or Removed. 
            //Only system administrators can specify Removed.
            req.setAction('Reject');
            req.setComments('Your Comment.');
            requests.add(req);
        }
        Approval.ProcessResult[] processResults = Approval.process(requests);        
        pageReference pg = new pageReference('/lightning/o/Claim__c/list?filterName=00B2w00000HbCkiEAF');
        return pg;
    }
    /******************************ReAssign****************************************************************/
        // pageReference
    public pageReference reassignClaims(){ 
       List<ProcessInstanceWorkItem> processRecords =new List<ProcessInstanceWorkItem>();
        
        List<ProcessInstanceWorkItem> processList = [SELECT Id, OriginalActorId , ActorId FROM ProcessInstanceWorkItem  WHERE ProcessInstance.TargetObjectId =: getClaimIds ];
        for(ProcessInstanceWorkItem process : processList){
            process.ActorId = '0052w0000024yjoAAA';
            process.OriginalActorId = '0052w0000024yjoAAA';
            processRecords.add(process);
        }
        if(processRecords.size() > 0){
            update processRecords;
        }
        
        System.debug('Reassign===> ' + processList);
        pageReference pg = new pageReference('/lightning/o/Claim__c/list?filterName=00B2w00000HbCkiEAF');
        return pg;
    }
}