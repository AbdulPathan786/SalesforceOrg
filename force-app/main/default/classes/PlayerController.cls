public with sharing class PlayerController {
    
     @AuraEnabled(cacheable=true)
    public static List<Player__c> playerRecords(String countryName){
        String search = '%' + countryName + '%';
         if(search == '')
             return [SELECT FirstName__c, LastName__c, Email__c, Country__c, ImageUrl__c, Phone__c FROM Player__c LIMIT 10];
             else
        	return [SELECT FirstName__c, LastName__c, Email__c, Country__c, ImageUrl__c, Phone__c FROM Player__c WHERE Country__c LIKE : search];
       
	}
    
      @AuraEnabled(cacheable=true)
    public static List<Player__c> playerRecordList(){
        return [SELECT FirstName__c, LastName__c, Email__c, Country__c, ImageUrl__c, Phone__c FROM Player__c];
	}
    
    
    
    
     @AuraEnabled(cacheable=true)
    public static List<Player__c> playerDetails(String playerId){
        System.debug('playerId' + playerId);
        return [SELECT FirstName__c, LastName__c, Email__c, Country__c, ImageUrl__c, Phone__c FROM Player__c WHERE Id =: playerId];
	}
}