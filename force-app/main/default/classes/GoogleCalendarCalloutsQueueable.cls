/*
Name        :  GoogleCalendarCalloutsQueueable 
Date        :  6, Dec 2021
Author      :  Abdul Pathan
Description :   
*/
public class GoogleCalendarCalloutsQueueable implements Queueable, Database.AllowsCallouts {
    public void execute(QueueableContext context) {
        try{
            upsertCalendarEventRecords();
        }
        catch(Exception e) {
            System.debug('error' + e.getMessage());
        }
    }
    // Upsert Calendar Event Records
    public static void upsertCalendarEventRecords(){
        List<Calendar_Event__c> upsertCalendarEventList = new List<Calendar_Event__c>();
        
        GoogleCalendarCallouts googleCalendar = new GoogleCalendarCallouts();
        GoogleCalendarCallouts.GoogleCalendarWrapper  myresponse =  googleCalendar.getMyCalendar();
       // System.debug('myresponse====>' + myresponse);
        for(GoogleCalendarCallouts.ItemsDetails itemResponce: myresponse.items){
            Set<String> allEmail = new Set<String>();
            Calendar_Event__c calendarEventRecord = new Calendar_Event__c();
            calendarEventRecord.Summary__c = itemResponce.summary;
            calendarEventRecord.External_Id__c = itemResponce.id;
            calendarEventRecord.Description__c = itemResponce.description;
            calendarEventRecord.Location__c = itemResponce.location;
            calendarEventRecord.IsAllDayEvent__c = false;
            calendarEventRecord.Status__c = itemResponce.status;
            calendarEventRecord.DurationInMinutes__c = 12;
            String  dateStart = itemResponce.start.dateTime_x;
            String  dateEnd = itemResponce.endDate_x.dateTime_x;
            DateTime startDate = (DateTime)Json.deserialize('"'+ dateStart +'"', DateTime.class);
            DateTime endDate = (DateTime)Json.deserialize('"'+ dateEnd +'"', DateTime.class);
            if(itemResponce.start.dateTime_x != null){
                calendarEventRecord.StartDateTime__c = startDate;
            }
            if(itemResponce.endDate_x.dateTime_x != null){
                calendarEventRecord.EndDateTime__c = endDate;
            }
            calendarEventRecord.IsReminderSet__c = itemResponce.reminders.useDefault;
            allEmail.add(itemResponce.creator.email);
            allEmail.add(itemResponce.organizer.email);
            if(itemResponce.attendees.size() > 0){
                for(GoogleCalendarCallouts.AttendeesDetials attendeesEmails : itemResponce.attendees){
                    allEmail.add(attendeesEmails.email);
                }
            }
            //System.debug('Size'+allEmail.size()); // System.debug('length'+String.join(new list<string>(allEmail), ',' ).trim().length());
            if(allEmail.size() > 0){
                calendarEventRecord.Email_Address__c = String.join(new list<string>(allEmail), ',' ).trim();
            } 
            upsertCalendarEventList.add(calendarEventRecord);
        }
        if(upsertCalendarEventList.size() > 0){
            Upsert upsertCalendarEventList External_Id__c;//Upsert Calendar Event Records
        }
    }
}