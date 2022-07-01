public class StudentTableController {
   
   public List<WrapperStudent> lstWrapperStudents {get;set;}
   public student__c stuobj{get;set;}
   
   public studentTableController(){
       refreshList();          
   }
   public void refreshList(){
       
       lstWrapperStudents =new  List<WrapperStudent>();
       stuobj = new student__c();
       List<student__c> lstStudent = [SELECT  FirstName__c, LastName__c, Gender__c
                                      FROM Student__c
                                      LIMIT 100
                                     ];
       if (lststudent.size() > 0){
           for(Student__c objStu : lstStudent){
               WrapperStudent objWrapperStudent = new WrapperStudent(objStu);              
               lstWrapperStudents.add(objWrapperStudent);
           }
       }
       system.debug('Wrapper list elements are =' + lstWrapperStudents );
   }
   public void save(){
       List<Student__c> deleteStudent = new List<Student__c>();
       List<Student__c> updateStudent = new List<Student__c>();
       for(WrapperStudent obj : lstWrapperStudents){
           if(obj.selected == true){
               deleteStudent.add(obj.objStudent);  
           }else{
               updateStudent.add(obj.objStudent);
           }
       }
       if(deleteStudent.size()>0)
           delete deleteStudent;
       if(updateStudent.size()>0)
           update updateStudent;
       
       if(stuobj.FirstName__c != null){
           insert stuobj;
       }
       refreshList();
   }
    
   public class WrapperStudent {
       public Student__c objStudent {get;set;}
       public Boolean selected {get;set;}
       
       public WrapperStudent(Student__c obj){
           this.objStudent = obj;
           selected = false;  
       }  
   }
}