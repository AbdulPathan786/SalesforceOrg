@isTest
private class GoogleCalendarCalloutsTest {
    
    @isTest static void testCalloutQueueable(){ 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());        
        Test.startTest();
        GoogleCalendarCalloutsQueueable obj = new GoogleCalendarCalloutsQueueable();
        //System.enqueueJob(obj);
        ID jobID = System.enqueueJob(obj);
        Test.stopTest();
    }  
    /*
    @isTest static void testCallouts(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator()); 
        Test.startTest();
        GoogleCalendarCallouts googleCalendar = new GoogleCalendarCallouts();
        GoogleCalendarCallouts.GoogleCalendarWrapper  myresponse =  googleCalendar.getMyCalendar();
        List<GoogleCalendarCallouts.ItemsDetails> itemResponce = myresponse.items;
        Test.stopTest();
    }
    
    */
    /* 
HttpResponse res = new  HttpResponse();
// Verify response received contains fake values
String contentType = res.getHeader('Content-Type');
System.assert(contentType == 'application/json');
String actualValue = res.getBody();
String expectedValue = '{"example":"test"}';
System.assertEquals(actualValue, expectedValue);
System.assertEquals(200, res.getStatusCode());
*/
    
    
}