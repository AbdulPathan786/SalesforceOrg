public class DeleteStudentController {
    public Student__c objStudent{get;set;}
    private String deleteRecordId;
    
    public DeleteStudentController(){
        deleteRecordId = ApexPages.currentPage().getParameters().get('uniqueId');
        System.debug('delete page :'+ deleteRecordId);
        objStudent = [
                        SELECT LastName__c,FirstName__c, Email__c, ContactNumber__c,Fee__c, BirthDate__c, States__c, City__c
                        FROM Student__c
                        WHERE ID = : deleteRecordId
                     ];
        System.debug('delete record page :'+ deleteRecordId);
        
    }
    
    
    public PageReference DeleteButton(){
        System.debug('Record Deleted : '+ deleteRecordId);
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Record Delete successfully.....'));
  //    DELETE objStudent;
        PageReference pg=page.studentslist;
        return pg;
         
    }
    public pageReference CancelButton(){
         PageReference pg=page.studentslist;
        return pg;
    }
}