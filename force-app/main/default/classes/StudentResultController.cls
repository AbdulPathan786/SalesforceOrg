public class StudentResultController {
    
    public List<AggregateResult> lstAggregareResult{get;set;}
    public List<Student__c> lstStudent{get;set;}
    
     Schema.DescribeFieldResult dfr = Student__c.Hobbies__c.getDescribe();
    List < Schema.PicklistEntry > pickVals = dfr.getPicklistValues();
    Map < String, Integer > map1 = new Map < String, Integer > ();
    Set<String> strImpLik = new Set<String>(); 
    Integer count = 0;
    
    public StudentResultController(){
        lstStudent = [SELECT  Name, Fee__c , Hobbies__c FROM Student__c];
        lstAggregareResult = [SELECT  Max(Fee__c) Max, Count(Name) cnt FROM Student__c];
        //System.debug('lstAggregareResult' + lstStudent);
         for(Schema.PicklistEntry picklist1:pickVals) {
             map1.put(picklist1.getLabel(), 0);
        }
   System.debug('map1 keySet '+map1.keySet());

       for (Schema.PicklistEntry picklist1: pickVals) {
            
              //  strImpLik.put(picklist1.getLabel());
            
        }
        List<Student__c> lstArticle =  [Select id, Hobbies__c from Student__c];
        for (String key: strImpLik){
            count = 0;
            for (Student__c article: lstArticle) {
                if(key.equals(article.Hobbies__c)){
                    count++;
                }
            }
            map1.put(key, count);
        }
    }
}