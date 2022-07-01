/*
* Name        :  GoogleBooksCallouts 
* Date        :  29, Dec 2021
* Author      :  Abdul Pathan
* Description :  Google Books Callouts
*/
public class GoogleBooksCallouts {
    /*******************fetch Records from Google Books API.*********************************/
    @AuraEnabled(cacheable=true)
    public static GoogleBooksResponse getGoogleBooks(){
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String booksName = 'users/108403919774072470233/bookshelves/1001/volumes';
            request.setEndpoint('callout:GoogleBooks/' + booksName );
            request.setHeader('Accept', 'application/json');
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('GET');
            HTTPResponse response = http.send(request);
            String responcebody = response.getBody();
            GoogleBooksResponse googleBooksList = (GoogleBooksResponse)JSON.deserialize(responcebody, GoogleBooksResponse.class);
            //System.debug('google Books List'  + googleBooksList);
            return googleBooksList;
        }
        catch(Exception e){
            System.debug('error: ' + e.getMessage());
            return null;
        }
    } 
    /*****************Search Book from Google Books API****************************************/
    @AuraEnabled(cacheable=true)
    public static GoogleBooksResponse searchBooks(String bookId){
        try{
            String booksName = bookId;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:GoogleBooks/volumes?q=' + booksName );
            request.setHeader('Accept', 'application/json');
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('GET');
            HTTPResponse response = http.send(request);
            String responcebody = response.getBody();
            GoogleBooksResponse googleBooksList = (GoogleBooksResponse)JSON.deserialize(responcebody, GoogleBooksResponse.class);
            // System.debug('Search Books Response' + googleBooksList);
            return googleBooksList;
        }
        catch(Exception e){
            System.debug('error: ' + e.getMessage());
            return null;
        }
    }   
    /******************Insert Book from Google Books API***********************************/
    @AuraEnabled
    public static void insertBooks(String volumeId){
        try{
            String bookNumber = '1001';
            String BookId = volumeId;
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:GoogleBooks/mylibrary/bookshelves/1001/addVolume?volumeId='+BookId);
            request.setHeader('Accept', '*/*');
            request.setHeader('Content-Length', '0');
            request.setMethod('POST');
            Http http = new Http();
            HTTPResponse response = http.send(request);
            // System.debug('Insert Books Response' + response.getBody());
        }
        catch(Exception e){
            System.debug('error: ' + e.getMessage());
        }
    } 
    /******************delete Book from Google Books API***********************************/
    @AuraEnabled
    public static void deleteBooks(String volumeId){
        try{
            String bookNumber = '1001';
            String BookId = volumeId;
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:GoogleBooks/mylibrary/bookshelves/1001/removeVolume?volumeId='+BookId);
            request.setHeader('Accept', '*/*');
            request.setHeader('Content-Length', '0');
            request.setMethod('POST');
            Http http = new Http();
            HTTPResponse response = http.send(request);
            System.debug('Delete Books Response' + response.getBody());
        }
        catch(Exception e){
            System.debug('error: ' + e.getMessage());
        }
    } 
    /*************************************************************************************/
    public class GoogleBooksResponse{
        @AuraEnabled
        public String kind{get;set;}
        @AuraEnabled
        public Integer totalItems{get;set;}
        @AuraEnabled
        public List<GoogleBooks> items{get;set;}        
        
    }
    public class GoogleBooks{
        @AuraEnabled
        public String kind {get;set;} 
        @AuraEnabled
        public String id {get;set;} 
        @AuraEnabled
        public String etag {get;set;}
        @AuraEnabled
        public String selfLink {get;set;}
        @AuraEnabled
        public volumeDetails volumeInfo;
    }
    public class volumeDetails{
        @AuraEnabled
        public String title {get;set;} 
        @AuraEnabled
        public List<String> authors {get;set;} 
        @AuraEnabled
        public String publishedDate {get;set;}
        @AuraEnabled
        public String description {get;set;}
        @AuraEnabled
        public Integer pageCount {get;set;}
        @AuraEnabled
        public String printType {get;set;}
        @AuraEnabled
        public List<String> categories{get;set;}
        @AuraEnabled
        public String averageRating {get;set;}
        @AuraEnabled
        public String ratingsCount {get;set;}
        @AuraEnabled
        public String maturityRating {get;set;}
        @AuraEnabled
        public ImageLinks imageLinks{get;set;}
    }
    public class ImageLinks{
        @AuraEnabled
        public String smallThumbnail {get;set;}
        @AuraEnabled
        public String thumbnail {get;set;} 
    }   
}