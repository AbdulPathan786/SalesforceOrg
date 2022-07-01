/*
* Name         : UserChatApplicationController
* Author       : Abdul Pathan
* Date         : 29 jan, 2020
* Description  : use by Lightning Web Component folder name : chatUserApp and chatApp 
*/
public without sharing class UserChatApplicationController {
    // User Records List
    @AuraEnabled(cacheable=true)
    public static List<User> activeChatUsers(){
        String currentUser = userinfo.getuserId();
        List<User> userList = [ SELECT Id, CreatedDate, Name, MediumPhotoUrl FROM User
                               WHERE Id !=: currentUser
                              ]; 
        return userList;
    }
    
    // Messege Records Create
    @AuraEnabled
    public static void createRecords(String userId, String input){
        System.debug('userId'+ userId + 'input'+ input);
        String currentUserId = userinfo.getuserId();
        List<Chat_Message__c> createRecs=new List<Chat_Message__c>();
        List<Chat_Message__c> chatRecs = [SELECT Id, Content__c, User__r.Name, User__r.MediumPhotoUrl, CreatedDate
                                        FROM Chat_Message__c
                                        WHERE (User__r.Id =: currentUserId AND User2__r.Id =: userId) OR (User__r.Id =: userId  AND User2__r.Id =: currentUserId) 
                                        ORDER BY CreatedDate DESC
                                       ];
          System.debug('chatRecs'+chatRecs);
        if(chatRecs.size()>0){
            String oldContant = chatRecs[0].Content__c;
            chatRecs[0].Content__c = oldContant + ','+ input;
            createRecs.add(chatRecs[0]);
        }
        else{
            Chat_Message__c chatRecord = new Chat_Message__c();
            chatRecord.Content__c = input;
            chatRecord.User__c = currentUserId;
            chatRecord.User2__c = userId;
            Insert chatRecord;
        }
        if(createRecs.size()>0){
            Update createRecs;
        }
    }
    
    // chat msg user details
    @AuraEnabled(cacheable=true)
    public static List<Chat_Message__c> userChatMessages(String userId){
        String currentUserId = userinfo.getuserId();
        return [SELECT Id, Content__c, CreatedDate FROM Chat_Message__c 
                WHERE (User__r.Id =: userId AND User2__r.Id =: currentUserId) OR (User__r.Id =: currentUserId AND User2__r.Id =: userId)
                ORDER BY CreatedDate DESC 
               ]; 
    } 
}