//Process Builder

public class AccountInsertContactCreateProcessBuilder {
    @InvocableMethod(label='Get Account Names' description='Returns the list of account names corresponding to the specified account IDs.')
    public Static void insertContactRecords(List<Account> lstAccount){
        
        for(Account objAccount : lstAccount){
            
            if(objAccount.Comma_Separated_Values__c != null){
                
                List<Contact> lstContact=new List<Contact>();
                //String[] strList = objAccount.Comma_Separated_Values__c.split(',');
                for(String lstAcc : objAccount.Comma_Separated_Values__c.split(',')){
                    
                    Contact objContact=new Contact();
                    objContact.AccountId = objAccount.id;
                    
                    List<String> lstString =lstAcc.split(' ');
                    
                    if(lstString.size()==2){
                        objContact.FirstName = lstString[0];
                        objContact.LastName = lstString[1];
                    }
                    if(lstString.size() == 1){
                        objContact.LastName = lstString[0];
                    }
                    lstContact.add(objContact);
                } 
                
                if(lstContact.size() > 0 || lstContact.size() != null){
                    //system.debug('Contacgt List :' + lstContact);
                    insert lstContact;    
                }
            } 
        }
    }
}