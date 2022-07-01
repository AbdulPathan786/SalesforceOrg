@isTest
private class CalendarEventTriggerTest {
    @isTest 
    static void testCalendarEvent(){
        Calendar_Event__c calendarEventRecord = new Calendar_Event__c();
        calendarEventRecord.External_Id__c = '2pdh2u8hf81e7uj7qg7hm5phot';
        calendarEventRecord.Email_Address__c = 'abhishek.s@ibirdsservices.com,abdul.h@ibirdsservices.com';
        calendarEventRecord.Description__c = 'Hi Pathan';
        calendarEventRecord.Location__c = 'Team\'s';
        calendarEventRecord.StartDateTime__c = system.now();
        calendarEventRecord.EndDateTime__c = system.now().AddDays(3);
        calendarEventRecord.IsAllDayEvent__c = false;
        calendarEventRecord.DurationInMinutes__c = 12;
        calendarEventRecord.IsReminderSet__c = false;
        calendarEventRecord.Summary__c = 'Just A Meeting Test';
        calendarEventRecord.Status__c = 'Confirmed';
        test.StartTest();
        Insert calendarEventRecord;
        test.StopTest();
        
        Set<String> emailAll = new Set<String>();
        Calendar_Event__c calendarEventList = [SELECT Id, Name, External_Id__c, Email_Address__c,Description__c, StartDateTime__c,Location__c,EndDateTime__c,IsAllDayEvent__c,DurationInMinutes__c,IsReminderSet__c,Summary__c,Status__c 
                                               FROM Calendar_Event__c WHERE Id =:calendarEventRecord.Id
                                              ];  
        emailAll.add(calendarEventList.Email_Address__c);
        calendarEventList.EndDateTime__c = system.now().AddDays(5);
        calendarEventList.IsAllDayEvent__c = true;
        Update calendarEventList;
        CalendarEventReminderSchedulable calendar = new CalendarEventReminderSchedulable(emailAll);
        String sch = '0 0 5 ? * * * ' ;
        String jobId = System.schedule('Calendar Event', sch, calendar);
        
    }
    
}