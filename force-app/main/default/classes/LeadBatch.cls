global class LeadBatch implements Database.Batchable<sobject>, Database.Stateful{
    
    global Integer totalSize = 0;
    global Integer fails = 0 ;
    global Integer successfully = 0 ;
    
    global Database.Querylocator start (Database.BatchableContext BC){
        String query = 'SELECT Id, FirstName, LastName, Name, Title, Company, Phone, Fax FROM Lead';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Lead> lstLead){
        
        totalSize = totalSize + lstLead.size();
        
        for(Integer i=0; i<lstLead.size(); i++){
            Lead cnt=lstLead.get(i);
            
           /* if(cnt.MobilePhone  == null || cnt.MobilePhone  ==''){
                cnt.MobilePhone  =cnt.Account.Phone;
            }*/
            if(cnt.Fax != null || cnt.Fax != ''){
                cnt.Fax = '9876543210';
                System.debug('abcde' + cnt);
            }
        }
       // update lstContact;
       System.debug('lstLead' +lstLead);
        Database.SaveResult[] result = database.update(lstLead, false);
        for(Integer i=0; i< result.size(); i++){
            database.SaveResult databaseSave= result.get(i);
            if(databaseSave.isSuccess()){
                successfully = + 1;
            }
            else{
                fails = + 1;
            }
        }
    
    }  
    global void finish(Database.BatchableContext BC){
       
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject('Batch Processing : LeadBatch');
        email.setSenderDisplayName('SFDC Email Test');
        email.setHtmlBody('Dear User,<br/> Batch class Process'+
                          '<br/> totalSize : ' + totalSize +
                          '<br/> successfully count :' + successfully +
                         '<br/> fails count :' + fails
                         );
        
        List<String> sentTo=new List<String>();
        sentTo.add('abdul.hp2904@gmail.com');
        sentTo.add('tarunkumarsen91@gmail.com');
        sentTo.add('tahir1947khan@gmail.com');
        sentTo.add('chandnanishubham36@gmail.com');
        sentTo.add('gautamsoni403@gmail.com');
        sentTo.add('vickyvikassain@gmail.com');
        sentTo.add('imtiyazimi999@gmail.com');
        sentTo.add('pradhyumansh0510@gmail.com');
        email.setToAddresses(sentTo);
        
        List<Messaging.SingleEmailMessage>  lstEmail=new List<Messaging.SingleEmailMessage>();
        lstEmail.add(email);
        Messaging.sendEmail(lstEmail, false);  
    }
}

/*
   //Defoult batch Size 1;
    LeadBatch obj=new LeadBatch();
    Database.executeBatch(obj);


   //Defoult batch Size 200;
   final Integer batchsize=2;
   Database.executeBatch(obj);
   Database.executeBatch(obj, batchsize);
*/