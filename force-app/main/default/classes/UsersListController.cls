/*
* Author  :  Abdul Pathan
* Name    :  UserRecordsController
* Date    :  20,October 2021
* Description  : fetch user Record and Search by Name & Lwc folder name : usersList
*/
public class UsersListController {
    @AuraEnabled(cacheable=true)
    public Static List<UserTaskWrapper> fetchUserList(){
        List<UserTaskWrapper> userTaskWrapperList = new List<UserTaskWrapper>();// wrapperList
        Set<Id> userIds = new Set<Id>(); // Users Ids
        Map<Id, List<task>> userTaskMap = new Map<Id, List<task>>();// userTaskMap
        Map<Id, List<task>> completedTaskMap = new Map<Id, List<task>>();// completedTaskMap
        
        List<User> userList = [SELECT Id, Name, Email, MediumPhotoUrl  FROM User LIMIT 20]; // Users List
        System.debug('userList-----' + userList);
        if(userList.size() > 0){
            for(User userRecord : userList){
                userIds.add(userRecord.Id);  		            
            }
        }
        List<Task> taskList = [SELECT Id, OwnerId, Status, Subject, CreatedDate  FROM Task WHERE OwnerId IN: userIds]; // Tasks List
        
       for(Task objTask : taskList){ 
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
        
        for(User userRec : userList){
            Decimal completed = (completedTaskMap.get(userRec.Id) != null) ? completedTaskMap.get(userRec.Id).size() : 0;
            Decimal totalTask = (userTaskMap.get(userRec.Id) != null) ? userTaskMap.get(userRec.Id).size() : 0;
            Decimal percentage ;
            if(totalTask != 0) {
                percentage = ((completed / totalTask ) * 100); 
            }
            userTaskWrapperList.add(new UserTaskWrapper(userRec, totalTask, percentage, userTaskMap.get(userRec.Id)));  
           
        } System.debug('userTaskWrapperList'+userTaskWrapperList);
        return userTaskWrapperList;
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
    /***********************************************************************************************************************************/
    // Show display click event User Tasks List
    @AuraEnabled(cacheable=true)
    public static List<Task> fetchtasksList(String ownerIdUser){
        List<Task> tasksList=[SELECT Id, Subject, Status, OwnerId, CreatedDate FROM Task WHERE OwnerId =: ownerIdUser];
        return tasksList;
    }
    // Create Task
    @AuraEnabled
    public static void createTasks(String userId, String sub){
        List<Task> taskRecList=new List<Task>();
        Task taskRec=new Task();
        taskRec.OwnerId = userId;
        taskRec.Subject = sub;
        taskRecList.add(taskRec);
        if(!taskRecList.isEmpty()){
            INSERT taskRecList;
        }
    }
    // delete Task
    @AuraEnabled
    public Static void deleteTask(String deleteId){
        Task objTask = new Task();
        objTask.Id = deleteId;
        DELETE objTask;
    } 
    // Update Task 
    @AuraEnabled
    public static void updateTask(String taskId){
        List<Task> updateTask = [SELECT Id, Status FROM Task WHERE Id =: taskId AND Status != 'Completed'];
        if(updateTask.size() > 0 ){
            updateTask[0].Status = 'Completed';
            UPDATE updateTask;
        }
    }
}