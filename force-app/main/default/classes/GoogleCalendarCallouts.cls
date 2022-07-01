/*
* Name        :  GoogleCalendarCallouts 
* Date        :  6, Dec 2021
* Author      :  Abdul Pathan
* Description :  Google Calendar Callouts
*/
public class GoogleCalendarCallouts {
    // Method to fetch Records from Google Calendar Drive.
    public GoogleCalendarWrapper getMyCalendar(){
        try{
            Http http = new Http();
            String calendarValue = 'calendars/primary/events';
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:GoogleCalendar/calendars/primary/events');
            request.setHeader('Accept', 'application/json');
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('GET');
            HTTPResponse response = http.send(request);
            
            String responcebody = response.getBody();
            responcebody = responcebody.replaceAll('"end":', '"endDate_x":');
            responcebody =responcebody.replaceAll('"dateTime":', '"dateTime_x":');
            GoogleCalendarWrapper googleCalendars = (GoogleCalendarWrapper)JSON.deserialize(responcebody, GoogleCalendarWrapper.class);
            return googleCalendars;
        }
        catch(Exception e){
            System.debug('error: ' + e.getMessage());
            System.debug('error: ' + e.getStackTraceString());
            return null;
        }
    } 
    //wrapperClass
    public class GoogleCalendarWrapper{
        //public String accessRole {get;set;}
        public List<ItemsDetails> items{get;set;}
    }   
    public class ItemsDetails {
        public String id {get;set;}
        public String status {get;set;}
        //public String htmlLink {get;set;}
        //public DateTime created {get;set;}
        //public DateTime updated {get;set;}
        public String summary {get;set;}
        public String description {get;set;}
        public String location {get;set;}
        public CreatorsDetails creator{get;set;}
        public OrganizerDetails organizer{get;set;}
        public StartDeatils start{get;set;}
        public EndDetails endDate_x{get;set;}
        public List<AttendeesDetials> attendees{get;set;}
        public RemindersDeatils reminders{get;set;}
    }   
    public class CreatorsDetails{
        public String email{get;set;}
    }
    public class OrganizerDetails{
        public String email{get;set;}
    }
    public class StartDeatils{
        public String dateTime_x{get;set;}
    }
    public class EndDetails{
        public String dateTime_x{get;set;}
    }
    public Class AttendeesDetials{
        public String email{get;set;}
        //public String responseStatus{get;set;}
        //public String displayName{get;set;}
    }
    public class RemindersDeatils{
        public Boolean useDefault{get;set;}
    }
}