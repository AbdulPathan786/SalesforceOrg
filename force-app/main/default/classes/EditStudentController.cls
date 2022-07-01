public class EditStudentController {
    private String recordId;
    public Student__c objStudent{get; set;}
    
    public EditStudentController(){
        recordId = ApexPages.currentPage().getParameters().get('uniqueId');
        System.debug('edit page :'+ recordId);
        objStudent = [ SELECT LastName__c,FirstName__c, Email__c, ContactNumber__c,Fee__c, BirthDate__c, States__c, City__c
                      FROM Student__c
                      WHERE ID = : recordId
                     ];
    }
    
    public void SaveButton(){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Record Update successfully.....'));
        update objStudent;
        
    }
    
    public PageReference CanselButton(){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Record Cancel'));
        PageReference pg=page.studentslist;
        return pg;
    }
    
}