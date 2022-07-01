public class MyContact{

    public MyContact(){
        
        //debug code       MyContact obj=new MyContact();
        
    /*
        Integer count = [ SELECT count()
                          FROM Contact
                        ];
        system.debug('Total Contact Record of the Count ' + count);
    */
        
        
        
        
        
                      /*
        
                            sObject cnn=new Contact(lastName = 'Azeeb', email='azeeb@gmail.com');
                         //  cnn.put('email', 'azeeb@gmail.com');
                             System.debug('Contact Record : ' + cnn);
                             insert cnn;
                     */

     
        
        
/*        
    Contact cnn=new Contact(lastName = 'Khan', email='azeen@gmail.com');
 // cnn.email='azeen@gmail.com';
     System.debug('Contact Record : ' + cnn);
     insert cnn;

*/      
        
        
        
        
        /*
        
                 //  Contact lstContact = [  SELECT firstName, lastName, email  FROM Contact ];
        
                   List<Contact> lstContact = [  SELECT firstName, lastName, email
                                                 FROM Contact
                                               ];
                   System.debug('Total Contact Records Size : = ' + lstContact.size());
       
                               //for(contact obj : lstContact) {System.debug('Contact email' + obj.email);}
                       
            
                             if(lstContact.size()>0)
                             {
                                 for(Integer i=0; i<lstContact.size(); i++)
                                   {
                                      System.debug('LastName : ' + lstContact[i].lastName);
                                   //   System.debug('LastName : ' + lstContact.get(i).lastName);
                                    }  
                                       // System.debug('Total Contact Records Size : ='+ lstContact.size());
                              } 
        
                   */
        
        
        
        
        
        
        
        
        
        
/* 
   Set<String> st=new Set<String>();
   st.add('Tarun');
   st.add('Tahir');
   st.add('Vikash');
   st.add('Shubham');
   st.add('Deepak');
   st.add('Pathan');
        System.debug('Add of the Names' + st);
    
*/
        
        
        
        
        
        
      /* 
        Map<String, Integer> mp=new Map<String, Integer>();
        mp.put('111', 999);
        mp.put('222', 888);
        mp.put('333', 777);
              System.debug('key and vakue: = ' + mp);
        
        */
        
        
        

        
        
        
                             Map<String, Integer> mp=new Map<String, Integer>();
                               Set<String> rollNo = mp.keySet();
                               List<Integer> value= mp.values();
        
                                  System.debug(rollNo);
                                  System.debug(value);
        
        
        
     /*
      
      // Testing Code Account Object
         
        Account store = new Account();
        store.Name = 'The Tea Factory';
        store.AccountNumber = '356281';
        store.Phone = '555-0158';
        insert store;
    
    */
    
    
    }  
}