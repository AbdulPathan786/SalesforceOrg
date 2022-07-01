public class NewsAPIsCallOuts {
    @AuraEnabled(cacheable=true)
    public static NewsResponse retriveNews(){
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String newsName = 'https://newsapi.org/v2/top-headlines?country=IN&apiKey=f94648c6e3a94ce18fab2b64a1ae7738';
            request.setEndpoint(newsName);
            request.setHeader('Accept', 'application/json');
            request.setHeader('Content-Type', 'application/json');
            request.setMethod('GET');
            HTTPResponse response = http.send(request);
            String responcebody = response.getBody();
            System.debug('responcebody....' + responcebody);
            NewsResponse newsResponse = (NewsResponse)JSON.deserialize(responcebody, NewsResponse.class);
            System.debug('newsResponse '  + newsResponse);
            return newsResponse;
        }
        catch(Exception e){
            System.debug('error: ' + e.getMessage());
            return null;
        }
    } 
    public class NewsResponse{
        @AuraEnabled
        public Integer totalResults{get;set;}
        @AuraEnabled
        public SourceId source{get;set;}
        @AuraEnabled
        public List<ArticlesList> articles{get;set;}
    }
    public class SourceId{
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String name{get;set;}
    }
    public class ArticlesList{
        @AuraEnabled
        public String author{get;set;}
        @AuraEnabled
        public String title{get;set;}
        @AuraEnabled
        public String description{get;set;}
        @AuraEnabled
        public String url{get;set;}
        @AuraEnabled
        public String urlToImage{get;set;}
        @AuraEnabled
        public String publishedAt{get;set;}
        @AuraEnabled
        public String content{get;set;}
    }
    
}