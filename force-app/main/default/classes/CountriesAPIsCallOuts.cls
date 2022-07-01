public class CountriesAPIsCallOuts {
    @AuraEnabled(cacheable=true)
    public static List<CountryResponse> retriveCountry(){
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String countryUrl = 'https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries+states+cities.json';
            request.setEndpoint(countryUrl);
            request.setHeader('Accept', '*/*');
            //request.setHeader('Content-Type', 'application/json');
            request.setMethod('GET');
            HTTPResponse response = http.send(request);
            String responcebody = response.getBody();
            
            List<CountryResponse> countyResponse = (List<CountryResponse>)JSON.deserialize(responcebody, List<CountryResponse>.class);
            //List<permissionDataWrapper>  delegationMap = (List<permissionDataWrapper>)JSON.deserialize(RestContext.request.requestBody.toString(), List<permissionDataWrapper>.class);
            System.debug('countyResponse '  + countyResponse);
            return countyResponse;
        }
        catch(Exception e){
            System.debug('error: ' + e.getMessage());
            return null;
        }
    }
    public class CountryResponse{
        public String id{get;set;}
        public String name{get;set;}
        public String iso3{get;set;}
        public String capital{get;set;}
        public List<StatesName> states{get;set;}
    }
    public class StatesName{
        public String name{get;set;}
        public String state_code{get;set;}
        public List<CitiesName> cities{get;set;}
    }
    public class CitiesName{
        public String name{get;set;}
    }
}