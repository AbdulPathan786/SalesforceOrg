public with sharing class Pagenation1Controller {
    
    public Integer record { get; set; }
    
    public Integer tot { get; set; }
    
    integer totalRecs = 0;
    integer count= 0;
    integer limitsize = 1;
    
    public Pagenation1Controller()
    { 
        tot=totalRecs = [select count() from account];
    }
    
    public List<Lead> leads=new List<Lead>();
    public List<Lead> getLeads() {
        List<Lead> ld=[select Name,Email,Company from Lead LIMIT:limitsize OFFSET:count];
        
        return ld;
    }
    
    
    public void updatePage() {
        leads.clear();
        limitsize =record;
        leads=[select Name,Email,Company from Lead LIMIT:record OFFSET:count];
    }
    
    public PageReference Firstbtn() {
        count=0;
        return null;
    }
    
    public PageReference prvbtn() {
        count=count-limitsize;
        return null;
    }
    
    public PageReference Nxtbtn() {
        count=count+limitsize;
        return null;
    }
    public PageReference lstbtn() {
        count= totalrecs - math.mod(totalRecs,LimitSize);
        return null;
    }
    
    
    public Boolean getNxt() {
        if((count+ LimitSize) > totalRecs)
            return true;
        else
            return false;
        
    }
    public Boolean getPrv() {
        if(count== 0)
            return true;
        else
            return false;
    }
}