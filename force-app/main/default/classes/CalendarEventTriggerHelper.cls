/*
* Name      :  CalendarEventTriggerHelper 
* Date      :  22, Dec 2021
* Author    :  Abdul Pathan
Description :  Reminder Emails send when Calendar Event Records Insert & Update
*/
public class CalendarEventTriggerHelper {
    /*********************************After Insert*****************************************/
    public static void onAfterInsert(List<Calendar_Event__c> calendarEventList){
        Set<Id> calendarEventIds = new Set<Id>();
        if(calendarEventList.size() > 0){
            for(Calendar_Event__c calendarEventRecord : calendarEventList){
                if(calendarEventRecord.EndDateTime__c != null){
                    calendarEventIds.add(calendarEventRecord.Id);
                }
            }
        }
        if(calendarEventIds.size() > 0){
            SchedulableCalendarEventReminder(calendarEventIds);
        }
    }
    /**********************************After Update***************************************/
    public static void onAfterUpdate(List<Calendar_Event__c> calendarEventList, Map<Id, Calendar_Event__c> oldMap){
        Set<Id> calendarEventIds = new Set<Id>();
        if(calendarEventList.size() > 0){
            for(Calendar_Event__c calendarEventRecord : calendarEventList){
                if(calendarEventRecord.EndDateTime__c != null){
                    if(oldMap != null && oldMap.get(calendarEventRecord.Id).EndDateTime__c !=  calendarEventRecord.EndDateTime__c ){
                        calendarEventIds.add(calendarEventRecord.Id);
                    }
                }
            }
        }
        if(calendarEventIds.size() > 0){
            SchedulableCalendarEventReminder(calendarEventIds);
        }
    }
    
    /**********Common Method*******Calendar Event Reminder email send************************************/
    public static void SchedulableCalendarEventReminder(Set<Id> calendarEventIds){
        Set<String> calendarEmailsIds = new set<String>();
        List<Calendar_Event__c> calendarEventRecords = [SELECT Id, Name, Email_Address__c, StartDateTime__c, EndDateTime__c FROM Calendar_Event__c 
                                                        WHERE Id IN : calendarEventIds
                                                       ];
        for(Calendar_Event__c calendarRecord : calendarEventRecords){
            calendarEmailsIds.add(calendarRecord.Email_Address__c);
            String cronJobDetailsName = 'Send Reminder Email:'+ calendarRecord.Name;
            DateTime newDateTime = calendarRecord.StartDateTime__c.addHours(-2);
            Integer year = newDateTime.year();
            Integer month = newDateTime.month();
            Integer day = newDateTime.day();
            Integer hour = newDateTime.hour();
            Integer minute = newDateTime.minute();
            Integer second = newDateTime.second();
            Integer millisecond = newDateTime.millisecond();
            if(calendarEmailsIds.size() > 0){
                List<CronTrigger> lstJobs = [SELECT Id, CronJobDetail.Name FROM CronTrigger WHERE State = 'WAITING' AND CronJobDetail.Name =: cronJobDetailsName];
                if(lstJobs.size() > 0){
                    for(CronTrigger job : lstJobs) {
                        System.abortJob(job.Id);
                    }
                }
                //CalendarEventReminderSchedulable calendar = new CalendarEventReminderSchedulable(calendarEmailsIds);
              //  String chronExpression = ' '+second +' '+ minute +' ' + hour + ' ' + day + ' ' + month + ' ? ';
                //String chronExpression = '0 29 15 * * ?';
               // String jobID = system.schedule(cronJobDetailsName, chronExpression, calendar);
            }
        }
    }
}