public class PositionController{
    
   public List<WrapperPosition> lstWrapperPosition {get;set;} 
    public Position__c objpsn{get;set;}
    
    public PositionController(){
        reference(); 
    }
    
    public void Save(){
        objpsn = new Position__c();
        List<Position__c> lstPositionsDelete = new List<Position__c>();
        List<Position__c> lstPositionUpsert = new List<Position__c>();
        
        for(WrapperPosition wprObj : lstWrapperPosition){
            
            if(wprObj.Selected == true) {
                lstPositionsDelete.add(wprObj.objPosition);
                // System.debug('lstPositionsDelete :'+ lstPositionsDelete);
            }
            else{
                lstPositionUpsert.add(wprObj.objPosition);
                //  System.debug('lstPositionUpsert :'+ lstPositionUpsert);
            }
        } 
        if(lstPositionUpsert.size()>0){
            Upsert  lstPositionUpsert;
        }
        if(lstPositionsDelete.size()>0){
            delete lstPositionsDelete;
        }
        //insert objpsn;
        reference();
    }
    
    public void reference(){
        objpsn = new Position__c();
        lstWrapperPosition = new List<WrapperPosition>();
        List<Position__c> lstPosition = [SELECT Name, MaxPay__c, MinPay__c, Status__c FROM Position__c LIMIT 200];
        if ( lstPosition.size() > 0){
            
            for (Position__c objPosition : lstPosition){
                WrapperPosition objWrapperPosition = new WrapperPosition(objPosition);              
                lstWrapperPosition.add(objWrapperPosition);
            }
        }
        lstWrapperPosition.add(new WrapperPosition(objpsn));    
    }

    public class WrapperPosition {
        public Position__c objPosition{get;set;}
        public Boolean Selected{get;set;}
        
        public WrapperPosition(Position__c obj){
            this.objPosition = obj;
            Selected = false;
        }
    }
}