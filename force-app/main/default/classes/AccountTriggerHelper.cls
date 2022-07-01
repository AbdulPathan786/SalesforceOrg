/*
Name        :    AccountTriggerHelper 
Date        :    17, March 2021
Author      :	Abdul Pathan
Description :   

*/
public class AccountTriggerHelper {
    
    /************************ afterInsert ***********************************************************************************/
    public static void afterInsert(List<Account> accountRecords){
        accountRecordInsert(accountRecords); //Account insert then contact insert automatically
    }
    //Account insert then contact insert automatically
    public static void accountRecordInsert(List<Account> accountRecords){
        List<Contact> contactList = new List<Contact>();
        for(Account accountRec : accountRecords){
            if(accountRec.Contact_Information__c != null){
                Contact contactRecord = new Contact(AccountId=accountRec.Id);
                //Saniya Mirza,abc@gmail.com,9874563210,MCA
                List<String> accountRecs = accountRec.Contact_Information__c.split(',');
                List<String> contactName = accountRecs[0].split(' ');
                
                contactRecord.FirstName = contactName[0];
                contactRecord.LastName = contactName[1];
                contactRecord.Email = accountRecs[1];
                contactRecord.Phone = accountRecs[2];
                contactRecord.Description = accountRecs[3];
                contactList.add(contactRecord);
            }
        }
        if(contactList.size() > 0){
            Insert contactList;
        }
    }
    
    /************************ afterUpdate ***************************************************************************************************/
    public static void afterUpdate(List<Account> accountRecords, Map<Id, Account> oldMap){
        accountRecordUpdate(accountRecords, oldMap);  //Account website update then contact Profile update
        accountContactUpdate(accountRecords, oldMap); // account contact Information field update then Conatact Insert
        accountChildRecordUpdate(accountRecords, oldMap); // Account fax field update then contact fax field update 12 July 2021
    }
    /****************************************************************************************************************************/
    // afterUpdate method call  
    // Account website update then contact Profile update
    public static void accountRecordUpdate(List<Account> accountRecords, Map<Id, Account> oldMap){
        Set<String> accountIds = new Set<String>();
        if(accountRecords.size() > 0){
            for(Account accountRec : accountRecords){
                if(accountRec.Website != null){
                    if(oldMap != null && oldMap.get(accountRec.Id).Website != accountRec.Website){
                        accountIds.add(accountRec.Id);
                    }
                }
                /* 
if(accountRec.Contact_Information__c !=null){
if(oldMap != null && oldMap.get(accountRec.Id).Contact_Information__c != accountRec.Contact_Information__c){
accountIds.add(accountRec.Id);
}
}
*/
            }
        }
        if(accountIds.size() > 0){
            contactUpdateRecords(accountIds);
        }
    }
    /****************************************************************************************************************************/
    //Account website update then contact Profile update
    public static void contactUpdateRecords(Set<String> accountIds){
        List<Contact> contactUpdate = new List<Contact>();
        if(accountIds.size() > 0){
            List<Contact> contactProfileUpdate = [SELECT  Id, AccountId, Profile__c, Account.Website FROM Contact
                                                  WHERE AccountId IN : accountIds AND Account.Website != null
                                                 ];
            for(Contact contactRecord : contactProfileUpdate){
                if(Account.Website != null){
                    contactRecord.Profile__c = Account.Website + '/' + contactRecord.FirstName.left(1) + contactRecord.LastName;
                    contactUpdate.add(contactRecord);
                } 
            }
            if(contactUpdate.size() > 0){
                Update contactUpdate;
            }
        }
    }
    /****************************************************************************************************************************/
    // account contact Information field update then Contact Insert
    public static void accountContactUpdate(List<Account> accountRecords, Map<Id, Account> oldMap){
        List<Contact> contactList = new List<Contact>();
        if(accountRecords.size() > 0){
            List<Contact> contactRecords = [SELECT Id, AccountId, Name FROM Contact WHERE AccountId IN : accountRecords];
            
            for(Account accountRec : accountRecords){
                if(accountRec.Contact_Information__c !=null){
                    if(oldMap != null && oldMap.get(accountRec.Id).Contact_Information__c != accountRec.Contact_Information__c){
                        for(Contact contactRecord : contactRecords){
                            List<String> accountRecs = accountRec.Contact_Information__c.split(',');
                            List<String> contactName = accountRecs[0].split(' ');
                            contactRecord.AccountId = accountRec.Id;
                            contactRecord.FirstName = contactName[0];
                            contactRecord.LastName = contactName[1];
                            contactRecord.Email = accountRecs[1];
                            contactRecord.Phone = accountRecs[2];
                            contactRecord.Description = accountRecs[3];
                            contactList.add(contactRecord);
                        }  
                    }
                }
            }
        }
        if(contactList.size() > 0){
            Update contactList;
        }
    }  
    /****************************************************************************************************************************/
    // Account fax field update then contact fax field update 12 July 2021
    public static void accountChildRecordUpdate(List<Account> accountRecords, Map<Id, Account> oldMap ){
        Set<Id> accountIds = new Set<Id>();
        List<Contact> contactList = new List<Contact>();
        if(accountRecords.size() > 0){
            for(Account accRecord : accountRecords){
                if(accRecord.Fax != null){
                    if(oldMap != null && oldMap.get(accRecord.Id).Fax != accRecord.Fax){
                        accountIds.add(accRecord.Id);
                    }
                }
            }
        }
        List<Contact> contactRecords = [SELECT Id, AccountId, Account.Fax FROM Contact WHERE AccountId IN : accountIds];
        if(contactRecords.size() > 0){
            for(Contact contactRec : contactRecords){
                contactRec.Fax = Account.Fax + '92/786' ;
                contactList.add(contactRec);
            }
        }
        if(contactList.size() > 0){
            UPDATE contactList;
        }
    }
    
    /*************** beforeDelete* 12 July 2021 *******************************************************************************/
    // Before Account record Not delete bcz more then two child available (error message) 12 July 2021
    public static void beforeDelete(List<Account> accountRecords){
        accountNotDelete(accountRecords);
    }
    // Before Account record Not delete bcz more then two child available (error message) 12 July 2021
    public static void accountNotDelete(List<Account> accountRecords){
        Set<Id> accountIds = new Set<Id>();
        if(accountrecords.size() > 0){
            for(Account accRecord : accountRecords){
                accountIds.add(accRecord.Id);
            }
        }
        List<Contact> contactRecords = [SELECT Id, AccountId FROM Contact WHERE AccountId IN : accountIds];
        if(contactRecords.size() > 1){
            for(Account accRecord : accountRecords){
                accRecord.addError('Account Records not delete bcz more then two child record available');
            }
        }
    }
    /****************************Salesforce to Salesforce Record Sharing************************************************************************************************/
     //AfterInsert
    public static void afterInsert2(List<Account> lstAccount){
        Set<String> accountIds = new Set<String>();
        if(lstAccount.size() > 0){
            for(Account accountRec: lstAccount){
                accountIds.add(accountRec.Id);
            }
        }
        if(accountIds.size() > 0){
            s2sRecordsSharing(accountIds);
        }
    }
    //AfterUpdate
    public static void afterUpdate2(List<Account> lstAccount, Map<Id, Account> oldMap){
        Set<String> accountIds = new Set<String>();
        if(lstAccount.size() > 0){
            for(Account accountRec: lstAccount){
                if(oldMap != null && oldMap.get(accountRec.Id).Id != accountRec.Id){
                    accountIds.add(accountRec.Id);
                }
            }
        }
        if(accountIds.size() > 0){
            s2sRecordsSharing(accountIds);
        }  
    }
    // Common Method
    public static void s2sRecordsSharing(Set<String> setAccountIds){
        List<PartnerNetworkRecordConnection> partnerNetworkRecordConList = new List<PartnerNetworkRecordConnection>();
        PartnerNetworkConnection connectionRecords = [SELECT Id, ConnectionStatus, ConnectionName FROM PartnerNetworkConnection WHERE ConnectionStatus = 'Accepted'
                                                      AND ConnectionName = 'ibirds software pvt ltd'
                                                     ];
        if(setAccountIds.size() > 0){
            for(String setId: setAccountIds){
                partnerNetworkRecordConList.add(new PartnerNetworkRecordConnection(ConnectionId = connectionRecords.Id,
                                                                                   LocalRecordId = setId,
                                                                                   RelatedRecords = 'Contact',
                                                                                   SendClosedTasks = false,
                                                                                   SendOpenTasks = false,
                                                                                   SendEmails = false));
            }
            for(Contact contactRec: [SELECT Id FROM Contact WHERE AccountId IN : setAccountIds]){
                partnerNetworkRecordConList.add(new PartnerNetworkRecordConnection( ConnectionId = connectionRecords.Id,
                                                                                   LocalRecordId = contactRec.Id,
                                                                                   SendClosedTasks = false,
                                                                                   SendOpenTasks = false,
                                                                                   SendEmails = false));
            } 
        }
        if(partnerNetworkRecordConList.size() > 0){
            Insert partnerNetworkRecordConList;
        }
    }
}