/*
* Author  :  Abdul Pathan
* Name    :  RequiredPartsHelper
* Date    :  09, Nov 2021
* Description  : I create and update the Required Parts records, then automatically update the parent records (product2) field Total Price
*/
public class RequiredPartsHelper {
    // AfterInsert
    public static void onAfterInsert(List<Required_Parts__c> requiredPartsRecords){
        Set<String> productIds = new Set<String>();
        if(requiredPartsRecords.size() > 0){
            for(Required_Parts__c requiredPartRecord : requiredPartsRecords){
                if(requiredPartRecord.Cost__c != null){
                    productIds.add(requiredPartRecord.Motor_Type__c);
                }
            }
        }
        if(productIds.size() > 0){
            updateProducts(productIds);
        }
    }
    // AfterUpdate
    public static void oAfterUpdate(List<Required_Parts__c> requiredPartsRecords, Map<Id, Required_Parts__c> oldMap){
        Set<String> productIds = new Set<String>();
        if(requiredPartsRecords.size() > 0){
            for(Required_Parts__c requiredPartRecord : requiredPartsRecords){
                if(oldMap != null && oldMap.get(requiredPartRecord.Id).Cost__c != requiredPartRecord.Cost__c){
                    productIds.add(requiredPartRecord.Motor_Type__c);
                }
            }
        }
        if(productIds.size() > 0){
            updateProducts(productIds);
        }
    }
    // AfterDelete
    public static void onAfterDelete(List<Required_Parts__c> requiredPartsRecords){
        Set<String> productIds = new Set<String>();
        if(requiredPartsRecords.size() > 0){
            for(Required_Parts__c requiredPartRecord : requiredPartsRecords){
                if(requiredPartRecord.Cost__c != null){
                    productIds.add(requiredPartRecord.Motor_Type__c);
                }
            }
        }
        if(productIds.size() > 0){
            updateProducts(productIds);
        }
    }
    
    //Required Parts Record (Cost__c field) Insert, Update and Delete then Product Record field Total_Price__c update
    public static void updateProducts(Set<String> productIds){
        Map<String, Product2> updateProductMap = new Map<String, Product2>(); 
        if(productIds.size() > 0){
            for(String productId: productIds) {
                updateProductMap.put(productId, new Product2(Id=productId, Total_Price__c=0));
            }
            AggregateResult[] resultAggregate = [SELECT Motor_Type__c, Sum(Cost__c) totalCost FROM Required_Parts__c
                                                 WHERE Motor_Type__c IN : productIds  group by Motor_Type__c
                                                ];
            for(AggregateResult result: resultAggregate){
                updateProductMap.get((Id)result.get('Motor_Type__c')).Total_Price__c = (Decimal)result.get('totalCost');
            }
        }
        if(updateProductMap.size() > 0){
            Update updateProductMap.values();
        }
         /*
        if(productIds.size() > 0){
            AggregateResult[] aggResult = [SELECT  Motor_Type__c, Sum(Cost__c) totalCost FROM Required_Parts__c WHERE Motor_Type__c IN : productIds  group by Motor_Type__c];
            for (AggregateResult result: aggResult){
                Product2 productRecord = new Product2(Id=(Id)result.get('Motor_Type__c'), Total_Price__c=(Decimal)result.get('totalCost'));
                updateProductList.add(productRecord);
            }
        }
        if(updateProductList.size() > 0){
            Update updateProductList.values();
        }
        */
    }
}