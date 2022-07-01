global class LeadBatchSchedule implements Schedulable{
    
    global void execute(SchedulableContext SC){
        LeadBatch obj=new LeadBatch();
        Database.executeBatch (obj);
    }
}