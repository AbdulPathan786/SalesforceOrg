global class AccountBatch implements Database.Batchable <sobject>{
    /*
public Date notificationDate;
global AccountBatch(Integer notifyDays){
notificationDate =system.today().addDays(notifyDays);
//System.debug('notificationDate' + notificationDate);
}*/
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Name (SELECT Name, Email FROM Contacts WHERE Email != null) FROM Account WHERE Name = \'Google\'';
        return Database.getQueryLocator(query);       
    }
    global void execute(Database.BatchableContext bc, List<Account> accRecords){
        System.debug('Account Records : ' + accRecords);
        List<Contact> ContactRecords=new List<Contact>();
        
        List<EmailTemplate> EmailTemplates =[ SELECT Id, Name, Body ,Subject, OwnerId, DeveloperName FROM EmailTemplate
                                             WHERE DeveloperName = 'Test_Account_Contact_Email'
                                            ];
        List<Messaging.SingleEmailMessage> allMsg = new List<Messaging.SingleEmailMessage>();
        
        for(Account accRec : accRecords){
            for(Contact contRecord : accRec.Contacts){
                System.debug('contatcEmail' + contRecord.Email);
                if(EmailTemplates.size()> 0){
                    System.debug('EmailTemplates' + EmailTemplates.size());
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.setTargetObjectId(contRecord.Email);
                    message.setTemplateId(EmailTemplates[0].id);
                    message.setWhatId(contRecord.id);
                    message.setSaveAsActivity(false);
                    allMsg.add(message);
                }
            }
        }
        System.debug('ContactRecords' + ContactRecords);
        if(allMsg.size()>0){
            List<Messaging.SendEmailResult> sendEmailResult = Messaging.sendEmail(allMsg);
        }
    }
    global void Finish(Database.BatchableContext cntx){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject('Batch Processing : Account');
        email.setSenderDisplayName('SFDC Email Test');
        email.setHtmlBody('Dear User,<br/> Batch class Process');
        List<String> sentTo=new List<String>();
        sentTo.add('abdul.hp2904@gmail.com');
        email.setToAddresses(sentTo);
        /*
List<Messaging.SingleEmailMessage>  lstEmail=new List<Messaging.SingleEmailMessage>();
lstEmail.add(email);
Messaging.sendEmail(lstEmail, false); 
*/
    }
}

/*
AccountBatch obj=new AccountBatch();
Database.executeBatch(obj);

//Defoult batch Size 1;
LeadBatch obj=new LeadBatch();
Database.executeBatch(obj);


//Defoult batch Size 200;
final Integer batchsize=2;
Database.executeBatch(obj);
Database.executeBatch(obj, batchsize);


global class UpdateAccountBillingStateBatch implements Database.Batchable <sObject>, Database.stateful{
Private String accLists;
global UpdateAccountBillingStateBatch(){
accLists  = 'SELECT BillingCountry , BillingState ';
accLists += 'FROM Account ';
accLists += 'WHERE BillingCountry = \'USA\' and BillingState = \'\'';
}
global Database.QueryLocator Start(Database.BatchableContext cntx){
return Database.getQueryLocator(accLists);
}
global void Execute(Database.BatchableContext cntx, List<Account> lstAccounts){
system.debug('Account Records : ' + lstAccounts);
for(Account objAccount : lstAccounts){
objAccount.BillingState = 'California';
}
update lstAccounts;
system.debug('Account Records Update : ' + lstAccounts);
}
global void Finish(Database.BatchableContext cntx){

}
}*/