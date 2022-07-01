public class CountryStateCitiesWrapperController {
	private List<Country> countryList;// List Of Country
    
    public CountryStateCitiesWrapperController(){
         List<Contact> contactRecs =[SELECT Id, Name FROM Contact ORDER By CreatedDate DESC];
        countryList = new List<Country>(); // List Of Country
        //========================== State of Rajasthan ===============================================
        List<String> postalCodeOfAjmer = new List<String>{'123','456', '789'}; // Ajmer Postal Code
        List<String> postalCodeOfNagaur = new List<String>{'000','92', '786'}; // Nagaur Postal Code
        
           Cities cityOfAjmer = new Cities();
                cityOfAjmer.cityName = 'Ajmer';
                cityOfAjmer.postalCodeList = postalCodeOfAjmer;
           Cities cityOfNaguar = new Cities();
                cityOfNaguar.cityName = 'Naguar';
                cityOfNaguar.postalCodeList = postalCodeOfNagaur;
            
            states statesOfRajasthan = new states(); // States of Rajasthan
                statesOfRajasthan.statesName = 'Rajasthan';
                statesOfRajasthan.citiesList.add(cityOfAjmer);
        		statesOfRajasthan.citiesList.add(cityOfNaguar);
        //============================ State of Karnataka ==============================================
        List<String> bangalorePostalCode = new List<String>{'786','456', '789'};
        List<String> mysorePostalCode = new List<String>{'789','786', '222'};
        
        Cities cityOfBangalore = new Cities();
            cityOfBangalore.cityName = 'Bangalore';
            cityOfBangalore.postalCodeList = bangalorePostalCode;
       
        Cities cityOfMysore = new Cities();
            cityOfMysore.cityName = 'Mysore';
            cityOfMysore.postalCodeList = mysorePostalCode;
           
        states stateOfKarnataka = new states(); // State of Karanataka
            stateOfKarnataka.statesName = 'Karanataka';
            stateOfKarnataka.citiesList.add(cityOfBangalore);
			stateOfKarnataka.citiesList.add(cityOfMysore);
        
        Country countryOfIndia = new Country();  // Country of India
            countryOfIndia.countryName = 'India';
            countryOfIndia.statesList.add(statesOfRajasthan);
            countryOfIndia.statesList.add(stateOfKarnataka);
        
       //=======================================Country Of Pakisthna =====================================================
        //================================== States of punjab ================================= 
        List<String> postalCodeOfkarachi = new List<String>{'123','456', '789'}; 
        List<String> postalCodeOfLahore = new List<String>{'000','92', '786'}; 
        
            Cities cityOfKarachi = new Cities();
                cityOfKarachi.cityName = 'Karachi';
                cityOfKarachi.postalCodeList = postalCodeOfkarachi;

            Cities cityOfLahore = new Cities();
                cityOfLahore.cityName = 'Lahore';
                cityOfLahore.postalCodeList = postalCodeOfLahore;
            
            states statesOfPunjab = new states(); // States of Punjab
                statesOfPunjab.statesName = 'Punjab';
                statesOfPunjab.citiesList.add(cityOfKarachi);
        		statesOfPunjab.citiesList.add(cityOfLahore);
            
        //==================== States of Islamabad ================================
        List<String> postalCodeOfIslamabad = new List<String>{'786','456', '789'};
        List<String> postalCodeOfMultan = new List<String>{'789','786', '222'};
                
        Cities cityOfIslamabad = new Cities();
            cityOfIslamabad.cityName = 'Islamabad';
            cityOfIslamabad.postalCodeList = postalCodeOfIslamabad;
        
        Cities cityOfMultan = new Cities();
            cityOfMultan.cityName = 'Multan';
            cityOfMultan.postalCodeList = postalCodeOfMultan;
        
        states statesOfIslamabad = new states(); // Islamabad States
            statesOfIslamabad.statesName = 'Islamabad';
            statesOfIslamabad.citiesList.add(cityOfIslamabad);
        	statesOfIslamabad.citiesList.add(cityOfMultan);
        
        Country countryOfPakisthan = new Country(); // Pakisthan Country
            countryOfPakisthan.countryName = 'Pakisthan';
         	countryOfPakisthan.statesList.add(statesOfPunjab);
            countryOfPakisthan.statesList.add(statesOfIslamabad);
        
        //====================================== Country data fill ================================
        	countryList.add(countryOfIndia);
        	countryList.add(countryOfPakisthan);
                
    }
    // Return List of States
    public List<States> getStates(String country){
        List<States> statesOfShowMessage = new List<States>();
            States showMsg = new States();
                showMsg.showMessageStates = 'Country Name not found Please Enter different Country';
                statesOfShowMessage.add(showMsg);
        
        for(Country countryRecord : countryList){
            if(countryRecord.countryName == country){
                return countryRecord.statesList;
            }
        }
        return statesOfShowMessage;
    }
    
    // Return List of Cities
    public List<Cities> getCities(String country, String state){
        List<Cities> cityOfShowMessage = new List<Cities>();
            Cities showMsg = new Cities();
                showMsg.showMessageCity = 'Country and State Name not found Please Enter different Country';
                cityOfShowMessage.add(showMsg);
        
        for(Country countryRecord : countryList){
            if(countryRecord.countryName == country){
                for(States statesRecord: countryRecord.statesList){
                    if(statesRecord.statesName == state){
                        return statesRecord.citiesList;
                    }
                }
            }
        }
        return cityOfShowMessage;
    }
    
    // Return List of Postal Code
    public List<String> getPostalCode(String country, String state, String city){
        List<String> errorMsg = new List<String>{'Country, State and City Name not found Please Enter different Country'};
            
            for(Country countryRecord : countryList){
                if(countryRecord.countryName == country){
                    for(States statesRecord: countryRecord.statesList){
                        if(statesRecord.statesName == state){
                            for(Cities cityRecord : statesRecord.citiesList){
                                if(cityRecord.cityName == city){
                                    return cityRecord.postalCodeList;
                                }
                            }
                        }
                    }
                }
            }
        return errorMsg;
    }    
    
    // Country Name wrapper Class
    public class Country{
        public String countryName;
        public List<States> statesList = new List<States>();
    }
    
    // State Name wrapper Class
    public class States{
        public String statesName;
        public String showMessageStates;
        public List<Cities> citiesList = new List<Cities>();
    }
    
    // Cities Name wrapper Class
    public class Cities{
        public String cityName;
        public String showMessageCity;
        public List<String> postalCodeList = new List<String>(); 
    }
    
    
    public List<Contact> contactRecords(){
        List<Contact> contactRecs =[SELECT Id, Name FROM Contact ORDER By CreatedDate DESC]; 
        System.debug('Contact records : ' + contactRecs); 
        return contactRecs;
    }
    
}