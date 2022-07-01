/*
Author : Abdul Pathan
Date :14 July 2021 
Lwc : parentComponent
*/

public class ChatMessageController {
    
    @AuraEnabled(cacheable=true)
    public static List<Chat_Message__c> chatMessage(){
        return [SELECT Id FROM Chat_Message__c WHERE Id =: 'a032w00000FJRJOAA5'];
    }
    
}