/*
* Author : Abdul Pathan
* Description : Country State City and PostalCode
*/

public class CountryStateCitiesController{  
    
    private Map<String, Map<String, Map<String, String>>> countryStatesCitiesPostalCode; // Country State City PostalCode
    
    private Map<String, Map<String, String>> indiaStatesCitiesPostalCode; // India State City PostalCode
    private Map<String, Map<String, String>> pakisthanStatesCitiesPostalCode; // Pakisthan State City PostalCode
    private Map<String, Map<String, String>> bangladeshStatesCitiesPostalCode; // Bangladesh State City PostalCode
    
    private Map<String, String> rajasthanCitiesPostalCode; // Rajasthan City PostalCode
    private Map<String, String> karnatakaCitiesPostalCode; // Karnataka City PostalCode
    
    private Map<String, String> PanjabCitiesPostalCode; // Punjab City PostalCode
    private Map<String, String> islamabadCitiesPostalCode; // Islamabad City PostalCode
    
    private Map<String, String> dhakaCitiesPostalCode; // Dhaka City PostalCode
    private Map<String, String> khulnaCitiesPostalCode; // Khulna City PostalCode
    // Constructor
    public CountryStateCitiesController(){
        countryStatesCitiesPostalCode =new Map<String, Map<String, Map<String, String>>>();// India State City PostalCode
		// India
        indiaStatesCitiesPostalCode = new Map<String, Map<String, String>>();
        rajasthanCitiesPostalCode = new Map<String, String>{'Ajmer' => '5003001', 'Nagaur' => '341302', 'Jaipur' => '123'};
        karnatakaCitiesPostalCode = new Map<String, String>{'Bangalore' => '987', 'Mysore' => '654', 'Dharwad' => '321'};
        indiaStatesCitiesPostalCode.put('Rajasthan', rajasthanCitiesPostalCode);
        indiaStatesCitiesPostalCode.put('Karnataka', karnatakaCitiesPostalCode);   
        // Pakisthan       
        pakisthanStatesCitiesPostalCode = new Map<String, Map<String, String>>();
        PanjabCitiesPostalCode = new Map<String, String>{'Karachi' => '5003001', 'Multan' => '341302', 'Lahore' => '123', 'Rawalpindi' => '786'};
        islamabadCitiesPostalCode = new Map<String, String>{'Islamabad' => '786'};
        pakisthanStatesCitiesPostalCode.put('Panjab', PanjabCitiesPostalCode);
        pakisthanStatesCitiesPostalCode.put('Islamabad', islamabadCitiesPostalCode);   
        // Bangladesh
        bangladeshStatesCitiesPostalCode = new Map<String, Map<String, String>>();
        dhakaCitiesPostalCode = new Map<String, String>{'Dhaka' => '5003001', 'Narayanganj' => '341302', 'Jaipur' => '786'};
        khulnaCitiesPostalCode = new Map<String, String>{'Khulna' => '987', 'Jessore' => '654'}; 
        bangladeshStatesCitiesPostalCode.put('Dhaka', dhakaCitiesPostalCode);
        bangladeshStatesCitiesPostalCode.put('Khulna', khulnaCitiesPostalCode);
        // Country Name
        countryStatesCitiesPostalCode.put('India', indiaStatesCitiesPostalCode);
        countryStatesCitiesPostalCode.put('Pakisthan', pakisthanStatesCitiesPostalCode);
        countryStatesCitiesPostalCode.put('Bangladesh', bangladeshStatesCitiesPostalCode);
   }
    // Country Name
    public Map<String, Map<String,String>> getStates(String countryName){
        
        if(countryStatesCitiesPostalCode.containsKey(countryName)){
            return countryStatesCitiesPostalCode.get(countryName);
        }
        else{
            return null;
        }
    }
    
    // Country Name and State Name 
    public Map<String, String> getCountryStates(String countryName, String stateName){
        
        if(countryStatesCitiesPostalCode.containsKey(countryName)){
            Map<String, String> cities;
            Map<String, Map<String,String>> countryStates = countryStatesCitiesPostalCode.get(countryName);
            if(countryStates.containsKey(stateName)){
                cities = countryStates.get(stateName);
            }
            return cities;
        }
        else{
            return null;
        }
    }
    
    // Country Name , State Name and City Name
    public String getCountryStateCities(String countryName, String stateName, String cityName){
        
        if(countryStatesCitiesPostalCode.containsKey(countryName)){
            String cityPostalCode;
            Map<String, Map<String, String>> countryStates = countryStatesCitiesPostalCode.get(countryName);
            if(countryStates.containsKey(stateName)){
                Map<String, String> cities = countryStates.get(stateName);
                if(cities.containsKey(cityName)){
                    cityPostalCode = cities.get(cityName);
                }
            }
            return cityPostalCode;
        }
        else{
            return null;
        }
    }
}


/* 
CountryStateCitiesController obj = new CountryStateCitiesController();
System.debug('Country Name : ' +  obj.getCountries('India'));
*/