/*
Author : Abdul Pathan
Date : 15 July 2021
Description : AccountTrigger call Batch Class (wrapperAddList) Account update then contact insert automatic
*/
global class AccountBatchController implements Database.Batchable <sobject>, Database.Stateful{
    global List<Account> accountIds;
    
    global AccountBatchController(List<Account> lstAccount){
        accountIds = new List<Account>();
        accountIds = lstAccount;
    }
    // start Method
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, LastName, AccountId, Email, Phone FROM Contact WHERE accountId IN :accountIds]);       
    }
    // execute Method
    global void execute(Database.BatchableContext bc, List<Contact> contactRecords){
        System.debug('accountRecords ===> : ' + contactRecords);
        
        List<Messaging.SingleEmailMessage> allMsg = new List<Messaging.SingleEmailMessage>();
        List<EmailTemplate> EmailTemplates =[ SELECT Id, Name, Body ,Subject, OwnerId, DeveloperName FROM EmailTemplate
                                             WHERE DeveloperName = 'Contact_Email_Testing'
                                            ];
        for(Contact contRec : contactRecords){
            allMsg.add(emailContact(EmailTemplates[0] , contRec));
        }
        if(allMsg.size()>0){
            List<Messaging.SendEmailResult> sendEmailResult = Messaging.sendEmail(allMsg);
        }
    }
    
    // this method call execute methos and send email
    public Messaging.SingleEmailMessage emailContact(EmailTemplate emailTempRec, Contact contactRec){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {contactRec.Email};
            
        message.setTargetObjectId(contactRec.id);
        message.setToAddresses(toAddresses);
        message.setTemplateId(emailTempRec.id);
        message.setSenderDisplayName('Ibirds Software Services Pvt. Lmt.');
        message.setSaveAsActivity(false);
        // message.setTargetObjectId('00303000009pFDX');
        // message.setWhatId(contactRec.id);
        return message;
    }
    
    // Finish Method
    global void Finish(Database.BatchableContext cntx){
        
    }
}