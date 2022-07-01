@isTest
private class EmployeesTriggerHelperTest {
    
    @TestSetUp static void testingTriggerEmployeeData (){
        
        List<Employees__c> lstemp = new List<Employees__c>();
        
        Employees__c emp1=new Employees__c();
        emp1.Name = 'Tarun';
        emp1.Status__c = 'active';
        lstemp.add(emp1);
        
        Employees__c emp2=new Employees__c();
        emp2.Name = 'Vikash';
        emp2.Status__c = 'Inactive';
        lstemp.add(emp2);
        
        insert lstemp;
        
        List<Log__c> lstLog=new List<Log__c>();
        
        Log__c logObj1 = new Log__c(Incident__c='New Employee', Employees__c=emp1.id);
        lstLog.add(logObj1);
        
        Log__c logObj2 = new Log__c(Incident__c='Removed Employee', Employees__c=emp2.id);
        lstLog.add(logObj2);
    }
    
    @isTest static void testDatas(){
        
        List<Employees__c> lstem=new List<Employees__c>();
        
        Employees__c em1= [select id from Employees__c where name = 'Vikash'];
        em1.Status__c = 'Inactive';
        lstem.add(em1);
        
        Employees__c em2= [select id from Employees__c where name = 'Tarun'];
        em2.Status__c = 'active';
        lstem.add(em2);
        
        update lstem;
    }
}