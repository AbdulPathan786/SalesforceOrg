public class ProjectPathPicklist {
    
    public List<String> options{get; set;}
    public string opts {get; set;}
    
    public ProjectPathPicklist(ApexPages.StandardController controller) {
        
        options = new List<String>();       
        //Getting The Object's Picklist's Values     
        Schema.DescribeFieldResult fieldResult = Project__c.Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        //Adding the Picklist Values into An Array           
        for(Schema.PicklistEntry f : ple){
            options.add(f.getLabel());
        }      
        //Stringifying The Array and Assigning It To A String 
        opts = JSON.serialize(options);       
    }
}