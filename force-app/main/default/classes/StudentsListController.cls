public class StudentsListController {
    public List<WrapperStudent> lstWrapperStudents {get;set;}
    private List<Student__c> lstStudents;
    public String recordEditId {get;set;}
    public String recordDeleteId {get;set;}
   
    public StudentsListController(){
        recordEditId = '';
        recordDeleteId = '';
        lstWrapperStudents = new List<WrapperStudent>();
        lstStudents = [ SELECT Name, FullName__c, Gender__c,admissionDate__c 
                        FROM Student__c
                        ORDER By Name
                      ];
        // , course__r.course__c
       
        if ( lstStudents.size() > 0){
            for (Student__c objStudent : lstStudents){
              //System.debug('lstStudent :' + objStudent);
                WrapperStudent objWrapperStudent = new WrapperStudent(objStudent);              
                lstWrapperStudents.add(objWrapperStudent);
            }
        }
    }
         /* PageReference
            We will create an object of this PageRefernce Class
         */
    public PageReference editStudent(){
        System.debug('Edit Button Clicked....' + recordEditId);
      //PageReference pgEdit=new PageReference;
        PageReference  pgEdit=Page.editstudent;
        pgEdit.getParameters().put('uniqueId', recordEditId);
        return pgEdit;
      //return objPage;
      // return null; 
    }
   
    public PageReference deleteStudent(){
        System.debug('Delete Button Clicked....' + recordDeleteId);
        PageReference pgDelete=Page.deleteStudent;
        pgDelete.getParameters().put('uniqueId', recordDeleteId);
        return pgDelete;
    }
       
    public class WrapperStudent {
        public Student__c objStudent {get;set;}
        public Boolean selected {get;set;}
        public Integer days {get;set;}
       
        public WrapperStudent(Student__c obj){
            this.objStudent = obj;
            selected = false;
            if(obj.admissionDate__c != null)
            days = (obj.AdmissionDate__c).daysBetween(System.today());
            else
                days = 0;
        }
    }
}