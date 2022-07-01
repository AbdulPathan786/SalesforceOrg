public class GoogleDriveCallouts {
    
    public void fetchGoogleDrive(){
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:GoogleDrive/drive/v3/files');
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('GET');
            HTTPResponse response = http.send(request);
            GoogleDriveWrapper googledrive = (GoogleDriveWrapper)JSON.deserialize(response.getBody(), GoogleDriveWrapper.class);
            System.debug('googledrive' + googledrive);
        }
        catch(Exception e){
            system.debug('Error Message :' + e.getMessage());
        }
        
    }
    public class GoogleDriveWrapper{
        public String kind{get;set;}
        public Boolean incompleteSearch{get;set;}
        public List<filesDetails> files{get;set;}
    }
    public class filesDetails{
        public String kind{get;set;}
        public String id{get;set;}
        public String name{get;set;}
        public String mimeType{get;set;}
    }
}