@isTest
private class LeadBatchTest {
    
    @TestSetup static void LeadBatchTestMethod(){
        List<Lead> lsts=new List<Lead>();
        
        Lead lst=new Lead();
        lst.LastName = 'pathan';
        lst.Company = 'ibirds';
        lst.Status = 'closed-Converted';
        lst.Fax = '2135241654';
        lsts.add(lst);
        insert lsts;
    }
    @isTest static void LeadBatchTest(){
        LeadBatch obj=new LeadBatch();
        Database.executeBatch(obj);
    }
    
    @isTest static void LeadBatchTest2(){
        LeadBatchSchedule reminder = new LeadBatchSchedule();
        String sch = '0 0 15 ? * *';
        String jobID = System.schedule('Remind Opp Owners', sch, reminder);
    }
}