/*
* Name         : UserSearchController
* Author       : Abdul Pathan
* Date         : 4 jan, 2020
* Description  : use by Lightning Web Component folder name : userTaskRecords
*/
public with sharing class UserTaskRecordsController {
    // wrapper
    @AuraEnabled(cacheable=true)
    public Static List<UserTaskWrapper> userTaskRecordList(){
        Set<Id> userIds = new Set<Id>();
        List<User> lstUser = [SELECT Id, Name, Email, MediumPhotoUrl  FROM User LIMIT 20];
        if(lstUser.size() > 0){
            for(User userRec : lstUser){
                userIds.add(userRec.Id);  		            
            }
        }        
        Map<Id, List<task>> userTaskMap = new Map<Id, List<task>>();
        Map<Id, List<task>> completedTaskMap = new Map<Id, List<task>>();
        
        List<Task> lstTasks = [SELECT Id, OwnerId, Status, Subject FROM Task WHERE OwnerId IN: userIds];
        
        for(Task objTask : lstTasks){ 
            if(userTaskMap.containsKey(objTask.OwnerId)){   
                userTaskMap.get(objTask.OwnerId).add(objTask);
                if(objTask.Status == 'Completed' && completedTaskMap.containsKey(objTask.OwnerId)){
                    completedTaskMap.get(objTask.OwnerId).add(objTask);
                }
            }else {   
                userTaskMap.put(objTask.OwnerId, new list<Task>{objTask}); 
                if(objTask.Status == 'Completed'){
                    completedTaskMap.put(objTask.OwnerId, new list<Task>{objTask} );
                }
            }
        }
        
        List<UserTaskWrapper> lstUserTaskWrappers = new List<UserTaskWrapper>();
        for(User userRec : lstUser){
            Decimal completed = (completedTaskMap.get(userRec.Id) != null) ? completedTaskMap.get(userRec.Id).size() : 0;
            Decimal totalTask = (userTaskMap.get(userRec.Id) != null) ? userTaskMap.get(userRec.Id).size() : 0;
            Decimal percentage ;
            if(totalTask != 0) {
                percentage = ((completed / totalTask ) * 100); 
            }
            lstUserTaskWrappers.add(new UserTaskWrapper(userRec, totalTask, percentage, userTaskMap.get(userRec.Id)));  		            
        }
        return lstUserTaskWrappers;
    }
    // WrapperClass    
    public class UserTaskWrapper {
        @AuraEnabled
        public User objUser {get;set;}
        @AuraEnabled
        public Decimal totalTasks {get;set;}
        @AuraEnabled
        public Decimal completedPercentage {get;set;}
        @AuraEnabled
        public List<Task> tasks {get;set;}
        
        public UserTaskWrapper(User objUser, Decimal totalTasks, Decimal completedPercentage, List<Task> tasks){
            this.objUser = objUser;
            this.totalTasks = totalTasks;
            this.completedPercentage = completedPercentage;
            this.tasks = tasks;
        }
    }
    /******************************************************************************************************************/
    // Show display click event User Task Records
    @AuraEnabled(cacheable=true)
    public static List<Task> taskRecords(String ownerIdUser){
        List<Task> taskRecs=[SELECT Id, Subject, Status, OwnerId FROM Task WHERE OwnerId =: ownerIdUser];
        return taskRecs;
    }
    // Insert User Task Records
    @AuraEnabled
    public static void createTaskRecords(String userId, String subRec){
        List<Task> taskRecList=new List<Task>();
        Task taskRec=new Task();
        taskRec.OwnerId = userId;
        taskRec.Subject = subRec;
        taskRecList.add(taskRec);
        if(!taskRecList.isEmpty()){
            INSERT taskRecList;
        }
    }
    // delete User Task Records
    @AuraEnabled
    public Static void deleteTaskRecord(String deleteId){
        List<Task> deleteTaskRec= [SELECT Id FROM Task WHERE Id =: deleteId];
        if(!deleteTaskRec.isEmpty()){
            DELETE deleteTaskRec;
        }
    }   
}