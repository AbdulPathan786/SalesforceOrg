public with sharing class RandomUserData {
    @AuraEnabled(cacheable=true)
    public static results getUserData(){
        try {
            string endpoint='https://randomuser.me/api/';
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            ///system.debug('request'+request);
            HttpResponse response = http.send(request);
            //System.debug('===>Response : '+response.getBody());
            Results getUser = new Results();
            getUser = (Results)System.JSON.deserialize(response.getBody(), Results.class);
            return getUser;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class Results{
      @AuraEnabled public List<ResultsWrapper> results;
    }
    public class Picture{
        @AuraEnabled public String large;
    }
    public class Name{
        @AuraEnabled public String first;
        @AuraEnabled public String last;
    }
    public class DOB{
        @AuraEnabled public String age;
    }
    
    public class ResultsWrapper{
      @AuraEnabled public String gender;
      @AuraEnabled public String email;
      @AuraEnabled public Picture picture;
      @AuraEnabled public Name name;
      @AuraEnabled public String phone;
      @AuraEnabled public DOB dob;
    }
}