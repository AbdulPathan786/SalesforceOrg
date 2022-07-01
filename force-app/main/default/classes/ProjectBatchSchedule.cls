/*
* @Name         : ProjectBatchSchedule
* @Author       : Abdul Pathan
* @Date         : 20 Feb, 2020
* @Description  : Project Batch Schedule
*/
global class ProjectBatchSchedule implements Schedulable{
    global void execute(SchedulableContext SC){
        ProjectBatch obj = new ProjectBatch();
        Database.executeBatch (obj);
    }
}

/*
Schedule Class Run Anonymous Window
ProjectBatchSchedule obj = new ProjectBatchSchedule();
String str = '0 28 17 * * ?';
String jobID = System.schedule('Remind Opp Owners', str, obj);
*/