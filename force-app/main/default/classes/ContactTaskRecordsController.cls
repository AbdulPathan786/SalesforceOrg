/*
Name        :    ContactTaskRecordsController 
Date        :    4, March 2021
Author      :	Abdul Pathan
Description :    LWc Name : contactTaskRecords

*/
public class ContactTaskRecordsController {
    @AuraEnabled(cacheable=true)
    public static List<ContactTaskWrapper> contactRecords(){
        List<ContactTaskWrapper> lstContactTaskWrappers = new List<ContactTaskWrapper>();
        Set<Id> contactIds = new Set<Id>();
        
        List<Contact> contactRecs = [SELECT Id, Name, Email, PhotoUrl, (SELECT Id, Status, Description, CreatedDate, WhoId  FROM Tasks) FROM Contact];
        for(Contact contactRec: contactRecs){
            contactIds.add(contactRec.Id);
        }
        // Attachment 
        Map<String, String> contentDocumentLinkIdsMap = new Map<String, String>();
		Map<String, List<String>> contentVersionIdMap = new Map<String,  List<String>>();        
        for(ContentDocumentLink docLinkRec : [SELECT id, ContentDocumentId, LinkedEntityId, ShareType FROM ContentDocumentLink WHERE LinkedEntityId IN : contactIds]){
            contentDocumentLinkIdsMap.put(docLinkRec.ContentDocumentId , docLinkRec.LinkedEntityId);   
        }
        for(ContentVersion conVersionRec: [SELECT Id, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN : contentDocumentLinkIdsMap.keySet()]){
            String conVer = contentDocumentLinkIdsMap.get(conVersionRec.ContentDocumentId);
            if(contentVersionIdMap.containsKey(conVer)){
                contentVersionIdMap.get(conVer).add(conVersionRec.Id);
            }else{
                contentVersionIdMap.put(conVer, new List<String>{conVersionRec.Id});
            }
        }  
        
        for(Contact contactRec : contactRecs){
            Integer completed = 0;
            for(Task objTask : contactRec.Tasks){
                if(objTask.Status == 'Completed') {
                    completed++;
                }
            }
            Decimal percentage = contactRec.Tasks.size() > 0 ?((completed * 100 ) / contactRec.Tasks.size()) : 0;
            String contentVersionId = contentVersionIdMap.containsKey(contactRec.Id) ? '/sfc/servlet.shepherd/version/download/' + contentVersionIdMap.get(contactRec.Id)[0] : null;
            lstContactTaskWrappers.add(new ContactTaskWrapper(contactRec, contactRec.Tasks.size(), percentage, contactRec.Tasks, contentVersionId)); 
        }
        return lstContactTaskWrappers;
    }
    // wrapperClass
    public class ContactTaskWrapper{
        @AuraEnabled
        public contact objContact{get;set;}
        @AuraEnabled
        public Decimal totalTasks{get;set;}
        @AuraEnabled
        public Decimal completedPercentage{get;set;}
        @AuraEnabled
        public List<Task> tasks {get;set;}
        @AuraEnabled
        public String conVersionId;
        
        public ContactTaskWrapper(contact objContact, Decimal totalTasks, Decimal completedPercentage, List<Task> tasks, String conVersionId){
            this.objContact = objContact;
            this.totalTasks = totalTasks;
            this.completedPercentage = completedPercentage;
            this.tasks =tasks;
            this.conVersionId = conVersionId;
        }
    }
 /******************************************************************************************************************/
    // Task Records Create
    @AuraEnabled
    public static void createTaskRecords(String contactRecId, String description){
        Task taskRecord = new Task();
        taskRecord.WhoId = contactRecId;
        taskRecord.Description = description;
       // taskRecord.CreatedDate = System.now();
        Insert taskRecord;
    }
    // Delete Task Records
    @AuraEnabled
    public static void deleteTaskRecord(String deleteId){
        List<Task> deleteTaskRec= [SELECT Id FROM Task WHERE Id =: deleteId];
        if(!deleteTaskRec.isEmpty()){
            DELETE deleteTaskRec;
        }
    }
    // Task Update
    @AuraEnabled
    public static void updateTaskRecords(String taskId){
        List<Task> updateTask = [SELECT Id, Status FROM Task WHERE Id =: taskId AND Status != 'Completed'];
        if(updateTask.size() > 0 ){
            updateTask[0].Status = 'Completed';
            update updateTask;
        }
    }
    
}