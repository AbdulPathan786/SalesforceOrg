/*
* Name        :  GoogleCalendarCalloutsSchedule 
* Date        :  6, Dec 2021
* Author      :  Abdul Pathan
* Description :   
*/
global class GoogleCalendarCalloutsSchedule implements Schedulable {
    global void execute(SchedulableContext sc) {
       // ID jobID = System.enqueueJob(new GoogleCalendarCalloutsQueueable());
    }
}

/*
GoogleCalendarCalloutsSchedule google = new GoogleCalendarCalloutsSchedule();
String sch = '0 00 01 * * ?';
String jobID = system.schedule('Google Calendar', sch, google);
*/