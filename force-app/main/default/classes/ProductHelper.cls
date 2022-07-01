/*
* Author  :  Abdul Pathan
* Name    :  ProductHelper
* Date    :  09, Nov 2021
* Description  : I create the product record, then automatically five child records (Required Pards) created
*/
public class ProductHelper {
    //afterInsert
    public static void onAfterInsert(List<Product2> productRecords){
        afterInsert(productRecords);
    }
    
    public static void afterInsert(List<Product2> productRecords){
        List<Required_Parts__c> requiredPardsList = new List<Required_Parts__c>();
        Map<Id, String> mapProduct = new Map<Id, String>();
        Map<String, List<Motor_Parts__mdt>> mapMotorParts = new Map<String, List<Motor_Parts__mdt>>();
        
        if(productRecords.size() > 0){
            for(Product2 product : productRecords){ 
                String recordTypeName = Schema.SObjectType.Product2.getRecordTypeInfosById().get(product.RecordTypeId).getName();
                mapProduct.put(product.Id, recordTypeName);
            }
        }
        if(mapProduct.size() > 0 ){            
            for(Motor_Parts__mdt moterParts : [SELECT Id, Cost__c, Type__c, Label FROM Motor_Parts__mdt WHERE Type__c IN : mapProduct.values()]){  
                if(mapMotorParts.containsKey(moterParts.Type__c)){
                    List<Motor_Parts__mdt> motorPartList = mapMotorParts.get(moterParts.Type__c);
                    motorPartList.add(moterParts);
                    mapMotorParts.put(moterParts.Type__c, motorPartList);
                }else{
                    mapMotorParts.put(moterParts.Type__c, new List<Motor_Parts__mdt>{moterParts});
                }
            }
            for(Id product : mapProduct.keyset()){
                if(mapProduct.containskey(product) && mapMotorParts.containsKey(mapProduct.get(product))){
                    for(Motor_Parts__mdt metaDataObj : mapMotorParts.get(mapProduct.get(product))){
                        requiredPardsList.add(new Required_Parts__c(Motor_Type__c = product , Name = metaDataObj.Label, Cost__c = metaDataObj.Cost__c));
                    }
                }
            }
        }
        if(requiredPardsList.size() > 0){
            Insert requiredPardsList; // Insert RequiredParts Records
        }
    }
}