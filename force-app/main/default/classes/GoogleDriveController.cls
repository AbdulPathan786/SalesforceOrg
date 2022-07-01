public class GoogleDriveController {  
    //Fetched from URL  
    public String accessToken;  
    public String refreshToken; 
    private String code ;
    private string key ;
    private string secret ;
    private string redirect_uri ;
    GoogleDrive__c googleCusSetting = new GoogleDrive__c();
    // constructor
    public GoogleDriveController(){
        code = ApexPages.currentPage().getParameters().get('code') ; 
    }
    
    // pageReference
    public PageReference init(){ //Authenticating  
        PageReference pg;
        try{
            googleCusSetting = [Select id,Client_Id__c,Client_secret__c,Refresh_Token__c,Access_token__c,GoogleAccountDomain__c,Redirect_Url__c from GoogleDrive__c limit 1];  
            if(googleCusSetting != null){
                accessToken = googleCusSetting.Access_token__c;
                key = googleCusSetting.Client_Id__c;  
                secret = googleCusSetting.Client_secret__c;  
                redirect_uri = googleCusSetting.Redirect_Url__c; 
                code = ApexPages.currentPage().getParameters().get('code') ; 
                //Get the access token once we have code  
                if(code == '' || code == null){  
                    pg = new PageReference(GoogleDriveAuthUri (key, redirect_uri)) ;  
                }else{
                    getToken();
                }  
            }
        }catch(exception e){
            system.debug('error :- ' + e.getMessage());
            system.debug('error :- ' + e.getLineNumber());
        }
        return pg ;
    }  
    
    public String GoogleDriveAuthUri(String Clientkey, String redirect_uri){  
        String key = EncodingUtil.urlEncode(Clientkey, 'UTF-8');  
        String uri = EncodingUtil.urlEncode(redirect_uri, 'UTF-8');  
        String authuri = '';  
        authuri = 'https://accounts.google.com/o/oauth2/auth?'+
            'client_id='+key+
            '&response_type=code'+
            '&scope=https://www.googleapis.com/auth/drive'+
            '&redirect_uri='+uri+
            '&state=security_token%3D138r5719ru3e1%26url%3Dhttps://oa2cb.example.com/myHome&'+
            '&login_hint=abdul.hp2904@gmail.com&'+
            'access_type=offline';
        return authuri;  
    }  
    // accessToken
    public void getToken(){
        //Getting access token from google 
        HttpRequest req = new HttpRequest();  
        req.setMethod('POST');  
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');  
        req.setHeader('content-type', 'application/x-www-form-urlencoded');  
        String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';  
        
        req.setHeader('Content-length', String.valueOf(messageBody.length()));  
        req.setBody(messageBody);  
        req.setTimeout(60*1000);  
        Http h = new Http();  
        String resp;  
        HttpResponse res = h.send(req);  
        resp = res.getBody();  
        
        if(res.getBody() != null && res.getStatusCode()==200){  
            //You can parse the response to get the Access token and Refresh token  
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());  
            //Access Token   
            if(results.get('access_token') != null){ 
                saveAccessToken(string.valueOf(results.get('access_token'))); // call saveAccessToken method
            }  
        }
    }
    public static void saveAccessToken(String accessToken){
        GoogleDrive__c googleRecord = [SELECT id, Access_token__c FROM GoogleDrive__c where name = 'Google Drive' LIMIT 1];
        googleRecord.Access_token__c = accessToken;
        update googleRecord;
    }
    
    
    // Method to fetch Records from G Drive.
    public  void fetchRecords(){ 
        googleCusSetting = [Select id, Refresh_Token__c, Access_token__c from GoogleDrive__c limit 1];  
        if(googleCusSetting != null){
            accessToken = googleCusSetting.Access_token__c;
        }
        System.debug('Records == > '+ accessToken);
        Http http = new Http();
        // Initialize the request Instance
        HttpRequest request = new HttpRequest();
        // Set the REST method
        request.setMethod('GET');
        // Set the endpoint 
        request.setEndpoint('https://www.googleapis.com/drive/v3/files');
        request.setHeader('Authorization', 'Bearer ' + accessToken);  
        request.setHeader('content-type', 'application/json');  
        String body = '{"name" : "FolderName","mimeType" : "application/vnd.google-apps.folder"}';  
        request.setTimeout(60*1000);   
        request.setBody(body); 
        
        HTTPResponse response = http.send(request);
        System.debug('Response =: ' + response.getBody()); 
    } 
    
    public void createRecords(){
        googleCusSetting = [Select id, Refresh_Token__c, Access_token__c from GoogleDrive__c limit 1];  
        if(googleCusSetting != null){
            accessToken = googleCusSetting.Access_token__c;
        }
        System.debug('create records'+ accessToken);
        HttpRequest req = new HttpRequest();   
        
        req.setMethod('POST');  
        
        req.setEndpoint('https://www.googleapis.com/upload/drive/v3/files');   
        
        req.setHeader('Authorization', 'Bearer ' + accessToken);  
        
        req.setHeader('content-type', 'application/json');  
        
        String body = '{"name" : "FolderNameT","mimeType" : "application/vnd.google-apps.folder"}';  
        
        req.setTimeout(60*1000);   
        
        req.setBody(body);  
        
        Http http = new Http();  
        
        HttpResponse res = http.send(req);    
        
        System.debug('===== Response==='+ res.getBody()); 
        
        
    }
}