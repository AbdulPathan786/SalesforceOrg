/*
Name        :    ContactTriggerHelper
Date        :    18th Jan 2021
Author      :    Abdul Pathan
Description :    If Account Have 70% or more of the Contacts on an Account are Dead
(dead__c field on contact), mark the need_intel field to TRUE on Account 
*/
public class ContactTriggerHelper {
    
    public static void afterUpdate(List<Contact> contactRecords, Map<Id, Contact> oldMap){
        // contact Dead field update then Account Need Intel field update
        contactUpdate(contactRecords, oldMap);
        // Contact Rating field update then Account Rating field automatically update
        updateContact(contactRecords, oldMap);
        // Account and Contact update
        accountContactUpdate(contactRecords, oldMap);
    }
    
    /********************************************************************************************************************************************/
    // contact Dead field update then Account Need Intel field update
    public static void contactUpdate(List<Contact> contactRecords, Map<Id, Contact> oldMap){
        Set<Id> conRecs=new Set<Id>();
        List<Account> accountRecs=new List<Account>();
        for(Contact conRec : contactRecords){
            if(conRec.Dead__c == true){
                if(oldMap != null && oldMap.get(conRec.Id).Dead__c != conRec.Dead__c){
                    conRecs.add(conRec.AccountId);
                }  
            }
        }
        List<Account> accRecs = [SELECT Id, Need_Intel__c, (SELECT Id, Dead__c FROM Contacts) FROM Account 
                                 WHERE Id IN : conRecs
                                ];
        if(accRecs.size() > 0){
            decimal count = 0;
            decimal totel = 0;
            for(Account accRec : accRecs){
                for(Contact objContact : accRec.Contacts){
                    totel++;
                    if(objContact.Dead__c == true){
                        count++;
                    }
                }
                if((count * 100)/totel > 70){
                    accRec.Need_Intel__c = true;
                    accountRecs.add(accRec);
                }
                else{
                    accRec.Need_Intel__c = false;
                    accountRecs.add(accRec);
                }
            }
        }
        if(accountRecs.size()>0){
            update accountRecs;
        }
    }
    
    /********************************************************************************************************************************************/
    // Contact Rating field update then Account Rating field automatically update
    public static void updateContact(List<Contact> contactRecords, Map<Id, Contact> oldMap){
        Set<Id> contactRecs=new Set<Id>();
        List<Account> accountRecords=new List<Account>();
        for(contact contRec : contactRecords){
            if(contRec.Rating__c != null) {
                if(oldMap != null && oldMap.get(contRec.Id).Rating__c != contRec.Rating__c){
                    contactRecs.add(contRec.AccountId);
                }
            }
        }
        List<Account> accRecs=[SELECT Id, Rating, (SELECT Id, Rating__c FROM Contacts) FROM Account 
                               WHERE Id IN : contactRecs];
        for(Account accRec : accRecs){
            for(Contact contRecord : accRec.contacts){
                if(contRecord.Rating__c == 1){
                    accRec.Rating = 'Hot';
                    accountRecords.add(accRec);
                }
                else if(contRecord.Rating__c == 2){
                    accRec.Rating = 'Warm';
                    accountRecords.add(accRec);
                }
                else if(contRecord.Rating__c == 3){
                    accRec.Rating = 'Cold';
                    accountRecords.add(accRec);
                }
            }
            if(accountRecords.size()>0){
                update accountRecords;
            }
        }
    }
    /********************************************************************************************************************************************/
    // Account and Contact update
    public static void accountContactUpdate(List<Contact> contactRecords, Map<Id, Contact> oldMap){
        Set<Id> contactRecs=new Set<Id>();
        List<Contact> contRecs=new List<Contact>(); 
        List<Account> accRecs=new List<Account>();
        
        if(contactRecords.size() > 0){
            for(Contact contRec : contactRecords){
                contactRecs.add(contRec.Id);
            }
        }
        
        List<Account> lstAccount = [SELECT Id, Rollup_Amount_X__c, Rollup_Amount_Y__c, MyDate__c,
                                    (SELECT AccountId, Amount_X__c, Amount_Y__c, Type__c,MyDate__c from Contacts) 
                                    FROM Account 
                                    WHERE Id IN : contactRecs 
                                   ];
        if(lstAccount.size() > 0){
            Integer i = 1;
            for(account acc : lstAccount){
                acc.Rollup_Amount_X__c = 0;
                acc.Rollup_Amount_Y__c = 0;
                
                for(contact objContact: acc.Contacts){
                    if(objContact.Type__c == 'Positive' && objContact.Amount_X__c != null){
                        acc.Rollup_Amount_X__c = acc.Rollup_Amount_X__c + objContact.Amount_X__c;
                        accRecs.add(acc);
                    }
                    else if(objContact.Type__c == 'Negative' && objContact.Amount_Y__c!=null){
                        acc.Rollup_Amount_Y__c = acc.Rollup_Amount_Y__c + objContact.Amount_Y__c;
                        accRecs.add(acc);
                    }
                    if(acc.Id == objContact.AccountId) {
                        objContact.MyDate__c = acc.MyDate__c.addMonths(i);
                        contRecs.add(objContact);
                        i++;
                    }  
                }
            }
        }
        if(accRecs.size() > 0 || contRecs.size() > 0){
            update accRecs;
            update contRecs;
        }
    }
    
    /********************************************************************************************************************************************/
    //  Duplicate Email id not insert in Contact Records
    public static void onBeforeInsert(List<Contact> contactRecords){
        Set<String> contactEmail = new Set<String>();        
        if(contactRecords.size() > 0){
            for(Contact objContact : contactRecords){
                contactEmail.add(objContact.Email);
            }
        }
        List<Contact> contactList = [SELECT Id, Email FROM Contact WHERE Email IN : contactEmail];
        if(contactList.size() > 0){
            for(Contact contactRec : contactRecords){
                contactRec.Email.addError( 'Duplicate email insert.... plz enter different email id...' );
            }
        }
    } 
    /********************************************************************************************************************************************/
    // Duplicate Email id not update in Contact Records(check Before)
    public static void onBeforeUpdate(List<Contact> contactRecords, Map<Id, Contact> oldMap){
        Set<String> contactEmail = new Set<String>();
        for(Contact conRec : contactRecords){
            if(conRec.Email != null){
                if(oldMap != null && oldMap.get(conRec.Id).Email != conRec.Email){
                    contactEmail.add(conRec.Email);
                }
            }
        }
        List<Contact> contactList = [SELECT Id, Email FROM Contact WHERE Email IN : contactEmail];
        if(contactList.size() > 0){
            for(Contact contactRec : contactRecords){
                contactRec.Email.addError( 'Duplicate email insert.... plz enter diff. email id...' );
            }
        }
    }
    
    /********************************************************************************************************************************************/
    // how to delete contact record then contact Record associate with Account record add error message (contact delete then account automatic delete)
    public static void onAfterDelete(List<Contact> contactRecs){
        Set<Id> accountIds = new Set<Id>();
        if(contactRecs.size() > 0){
            for(Contact contactRec : contactRecs){
                accountIds.add(contactRec.AccountId);
            }
        }
        List<Account> lstAccount = [SELECT Id FROM Account WHERE Id In : accountIds];
        if(lstAccount.size() > 0){
            // delete lstAccount;
            for(Contact objContact : contactRecs){
                objContact.addError('Contact not delete bcz contact object associate with Account object');
            }
        }
    }
    /*********************Account Related Count Contact Records**********25 Aug 2021**************************************************/  
    public static void contactCountRecords(List<Contact> contactRecords){
        Set<Id> setAccountIds = new Set<Id>();
        if(contactRecords.size() > 0){
            for(Contact contactRecs : contactRecords){
                setAccountIds.add(contactRecs.AccountId);
            }
        }
        if(setAccountIds.size() > 0){
            List<Account> accountRecordsUpdate = new List<Account>();
            List<Account> accountRecords = [SELECT Id, (SELECT id, AccountId FROM contacts) FROM Account WHERE Id in : setAccountIds];
            if(accountRecords.size() > 0){
                for(Account accRec : accountRecords) {
                    accRec.Total_Count_Contacts__c = accRec.contacts.size();
                    accountRecordsUpdate.add(accRec);
                } 
            }
            if(accountRecordsUpdate.size() > 0){
                Update accountRecordsUpdate;
            }
        }
    }
    /*************************************************************************************************************/    
}