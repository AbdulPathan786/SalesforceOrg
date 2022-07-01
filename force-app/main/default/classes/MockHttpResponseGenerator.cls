@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
         //String responseBody = '{"accessRole": "owner","items": [{ "id": "2pdh2u8hf81e7uj7qg7hm5phot", "status": "confirmed", "created": "2021-12-03T13:28:39.000Z", "updated": "2021-12-03T13:29:10.083Z","summary": "Just A Meeting Test", "creator": { "email": "abhishek.s@ibirdsservices.com" }, "organizer": { "email": "abhishek.s@ibirdsservices.com"}, "start": { "dateTime": "2021-12-04T07:00:00+05:30", "timeZone": "Asia/Kolkata" }, "end": {"dateTime": "2021-12-04T08:00:00+05:30", "timeZone": "Asia/Kolkata"}, "attendees": [ {"email": "abhishek.s@ibirdsservices.com", "organizer": true, "responseStatus": "accepted"}, {"email": "abdul.h@ibirdsservices.com","self": true,"responseStatus": "accepted" } ]}],"reminders": { "useDefault": true}}';
         String responseBody = '{ "accessRole": "owner","items": [ {"kind": "calendar#event", "id": "2pdh2u8hf81e7uj7qg7hm5phot","status": "confirmed","htmlLink": "https://www.google.com/calendar/event?eid=MnBkaDJ1OGhmODFlN3VqN3FnN2htNXBob3QgYWJkdWwuaEBpYmlyZHNzZXJ2aWNlcy5jb20", "created": "2021-12-03T13:28:39.000Z", "updated": "2021-12-03T13:29:10.083Z","summary": "Just A Meeting Test", "description": "Hi Abdul","location": "Teams", "creator": { "email": "abhishek.s@ibirdsservices.com", "self": true },"organizer": { "email": "abhishek.s@ibirdsservices.com"}, "start": { "dateTime": "2021-12-04T07:00:00+05:30", "timeZone": "Asia/Kolkata" }, "end": { "dateTime": "2021-12-04T08:00:00+05:30", "timeZone": "Asia/Kolkata"}, "attendees": [ { "email": "abhishek.s@ibirdsservices.com", "organizer": true, "responseStatus": "accepted" },{ "email": "abdul.h@ibirdsservices.com", "self": true, "responseStatus": "accepted" } ], "reminders": {"useDefault": true } }]}';
        res.setHeader('Content-Type', 'application/json');
        res.setBody(responseBody);
        res.setStatusCode(200);
        res.setStatus('Ok');
        return res;
    }
}