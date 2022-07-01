@isTest
private class AccountBatchTest {
    @isTest static void TestAccountRecord(){
        List<Account> accountRecord=new List<Account>();
        List<Contact> contactRecord=new List<Contact>();
        for(Integer i =0; i<200; i++){
            Account accRec=new Account();
            accRec.Name = 'Youtube';
            accountRecord.add(accRec);
        }
        insert accountRecord;
        for(Integer i=0; i<200; i++){
            Contact cntRec=new Contact();
            cntRec.Email = 'abdul.hp2904@gmail.com';
            contactRecord.add(cntRec);
        }
        //insert contactRecord;
       
        
    }
}