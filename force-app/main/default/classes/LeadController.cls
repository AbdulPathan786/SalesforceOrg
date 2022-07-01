/*
* Developed By Abdul Pathan
* Controller LeadController
* vf lead.vfp
* Date 30/01/2020
*/
public class LeadController{
    public List<Lead> lstLead{get;set;} 
    
    public LeadController(){
        lstLead =new List<Lead>();
        lstLead.add(new Lead());
    } 
    
    public void submit(){
        if(lstLead.size() > 0){
            
            set<string> newNameSet = new set<string>();
            set<string> newEmailSet = new set<string>();
            Map<String, Lead> map1=new Map<String, Lead>();
            
            for(lead newLead : lstLead){
                newNameSet.add(newLead.LastName);
                newEmailSet.add(newLead.Email);
            }
            
            List<Lead>  lstSecondLead = [select id, LastName, email 
                                         from lead 
                                         where email IN: newEmailSet AND LastName IN: newNameSet
                                        ];
            for(Lead dLead :lstSecondLead ){
                String concat=dLead.LastName + dLead.Email;
                map1.put(concat, dLead);
            }
            
            for(lead newLead : lstLead){
                String concat=newLead.LastName + newLead.Email;
                if(map1.containsKey(concat)){
                    newLead.Id = map1.get(concat).id;
                }
            }
            
        } 
        upsert lstLead;
        lstLead =new List<Lead>();
        lstLead.add(new Lead()); 
    }
    
    public void addRow(){
        lstLead.add(new Lead());
    }
    /*public void addRowFunction(){
lstLead =new List<Lead>();
lstLead.add(new Lead());
}
*/
}