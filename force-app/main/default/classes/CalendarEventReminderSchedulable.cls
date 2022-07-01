/*
* Name      :  CalendarEventReminderSchedulable 
* Date      :  22, Dec 2021
* Author    :  Abdul Pathan
Description :  Reminder Emails send
*/
global class CalendarEventReminderSchedulable implements Schedulable{
    Set<String> calendarEventAllEmails; 
    global CalendarEventReminderSchedulable(Set<String> calendarEmailsIds){
        calendarEventAllEmails = new Set<String>();
        calendarEventAllEmails = calendarEmailsIds;
    }
    global void execute(SchedulableContext SC) {
        sendmail(calendarEventAllEmails);
    }
    public void sendmail(Set<String> allEmailAddress){
        List<Messaging.SingleEmailMessage> allEmails = new List<Messaging.SingleEmailMessage>();	
        if(allEmailAddress.size() > 0){
            List<String> toAddresses = new List<String>();
            for(String mail : allEmailAddress){
                toAddresses.addAll(mail.split(','));
            }
            EmailTemplate templateId = [SELECT Id, Name, Body, Subject, OwnerId, DeveloperName FROM EmailTemplate
                                        WHERE DeveloperName = 'Reminder_Email_For_Calendar_Event'                                               
                                       ];
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(toAddresses);
            email.setTemplateId(templateid.Id);
            email.setTargetObjectId(UserInfo.getUserId());
            email.setSaveAsActivity(false);
            allEmails.add(email); 
        }
        if(allEmails.size() > 0){
            Messaging.sendEmail(allEmails);
        }
    }
}