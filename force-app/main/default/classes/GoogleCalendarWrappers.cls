public class GoogleCalendarWrappers {
    
    public String kind {get;set;}
    public String etag {get;set;}
    //  public String status {get;set;}
    public String summary {get;set;}
    //  public String description {get;set;}
    public DateTime updated {get;set;}
    public String nextSyncToken {get;set;}
    public String timeZone {get;set;}
    public String accessRole {get;set;}
    public List<defaultReminders> defaultReminders {get;set;}
    public class defaultReminders {
        public String method {get;set;}
        public Double minutes {get;set;}
    }
    
    public List<items> items {get;set;}
    public class items {
        public String kind {get;set;}
        public String status {get;set;}
        public String summary {get;set;}
        public String description {get;set;}
    } 
    
    public String creator{get;set;}
    public class crearor{
        public String email{get;set;}
    }
    public String organizer{get;set;}
    public class organizer{
        public String email{get;set;}
    }
    public List<start> start{get;set;}
    public class start{
        // public String dateTime{get;set;}
        public String timeZone{get;set;}
    }
    
    
}