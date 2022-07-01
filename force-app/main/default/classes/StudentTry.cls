public class StudentTry {
    
    public StudentTry(){
       List<Course__c> lstCourses =new List<Course__c>([SELECT Id, Fee__c, Duration__c, Name FROM Course__c WHERE Name = 'MCA']);
        for ( Course__c obj : lstCourses){
            System.debug( obj.Id);
        }
       
        if ( lstCourses.size() > 0){
            ID acc= lstCourses[0].Id;
            System.debug('First Id :  ' + acc);
        }
       
        /*Course__c  cs =new Course__c();
        cs.Name='MCA';
        cs.Fee__c='300000';
        cs.Duration__c='3 Year';
        insert cs;*/
        
       Student__c st=new Student__c();
         st.FirstName__c='Rohit';
         st.LastName__c='Sharma';
         st.Gender__c='Male';
         st.ContactNumber__c='9828652314';
         st.Email__c='virats@gmail.com';
         st.City__c='Ajmer';
         st.States__c='Rajasthan';
         st.Fee__c=60000;
         st.MDRCourse__c=lstCourses[0].Id;
        //st.MDRCourse__c=cs;
          insert st;
    }
}