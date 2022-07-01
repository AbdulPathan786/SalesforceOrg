public class LwcContactDemo {    
    @AuraEnabled(cacheable=true)
    public static List<String> contactRecord(){
        Set<String> setContact=new Set<String>(); 
        
        List<String> lstContactRecord=new List<String>();
        
        List<Contact> lstContact =[Select MailingCity, name From Contact];
        
        for(Contact contactRecord : lstContact) {
            setContact.add(contactRecord.MailingCity);	
        }
        if(setContact != null){
            for(Contact contactRecord : lstContact){
                if(setContact.contains(contactRecord.MailingCity)){
                    if(contactRecord.MailingCity != null)
                        lstContactRecord.add(contactRecord.MailingCity);   
                }	
            }
        }
        return lstContactRecord;
    } 
}