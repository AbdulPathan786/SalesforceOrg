/*
* Author : Abdul Pathan
* Date   : 16-August-2021
* Description : Opportunity Amount field Insert and Update then Account Field (xyz...) Update
*/
public class opportunityTriggerHelper {
    
    /*************************************Before Insert****************************************************************/
    // Before Insert
    public static void onBeforeInsert(List<Opportunity> opportunityRecords){
        opportunityInsert(opportunityRecords);
    }
    // Before Insert calculate the total amount of opportunity Records by Abdul Pathan 16-Aug-2021
    public static void opportunityInsert(List<Opportunity> opportunityRecords){   
        Map<String, Decimal> accountIdsOfOpp = new Map<String, Decimal>();
        if(opportunityRecords.size() > 0){
            for(Opportunity oppRecord : opportunityRecords){
                if(oppRecord.AccountId != null && oppRecord.Amount != null){
                    accountIdsOfOpp.put(oppRecord.AccountId, oppRecord.Amount);
                }
            }
        }
        List<Account> accountRecords = [SELECT Id, Name, (SELECT Id, Amount, AccountId FROM Opportunities) FROM Account WHERE Id IN : accountIdsOfOpp.keySet()];
        if(accountRecords.size() > 0){
            for(Account accRec : accountRecords){
                List<Decimal> myDecimal = accountIdsOfOpp.values();
                // System.debug('myDecimal ' + myDecimal);
            }
        }
    }
    /**************************************************After Update*********************************************************************************************/
    // After Update
    public static void onAfterUpdate(List<Opportunity> OpportunityRecords, Map<Id, Opportunity> oldMap){
        opportunityUpdate(OpportunityRecords, oldMap);
        
    }
    // After Update calculate the total amount of opportunity Records by Abdul Pathan 16-Aug-2021
    public static void opportunityUpdate(List<Opportunity> OpportunityRecords, Map<Id, Opportunity> oldMap){
        Set<String> accountIdsOfopp = new Set<String>();
        if(OpportunityRecords.size() > 0){
            for(Opportunity oppRecord : OpportunityRecords){
                if(oppRecord.AccountId != null && oppRecord.Amount != null){
                    if(oldMap != null && oldMap.get(oppRecord.Id).Amount != oppRecord.Amount){
                        accountIdsOfopp.add(oppRecord.AccountId);
                    } 
                }
            }
        }
        if(accountIdsOfopp.size() > 0){
            //Map<String, Decimal> accountIdsOfOppAmounts = new Map<String, Decimal>();
            Decimal amountValues = 0;
            List<Account> accountRecords = [SELECT Id, Name, (SELECT Id, Amount, AccountId FROM Opportunities) FROM Account WHERE Id IN : accountIdsOfopp];
            
            if(accountRecords.size() > 0){
                for(Account accRec : accountRecords){                
                    for(Opportunity opp : accRec.Opportunities){
                        amountValues += opp.Amount;
                        System.debug('amountValues' + amountValues);
                       // accountIdsOfOppAmounts.put(accRec.Id, amountValues);
                    }
                }
            }
        }
    }
    
}