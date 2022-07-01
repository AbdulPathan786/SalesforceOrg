public class ExportContactsCSVController {
    String accountId;
    public List<Contact> lstContact{set;get;}
    Map<String, String> mapAllFieldName;
    List<String> allRightFields;
    Public SObject sobj;
    
    Public List<String> selectedFieldsList {get;set;}
    Public List<String> rightSelected {get;set;}
    Public List<String> leftSelected {get;set;}
    Set<String> leftValues = new Set<String>();
    Set<String> rightValues= new Set<String>();
    public String newLine {get {return '\r';} private set;}
    /*************Constructor*******************************************************************************************/
    public ExportContactsCSVController(ApexPages.StandardController controller){
        accountId = ApexPages.currentPage().getParameters().get('Id'); //AccountId fetch
        getAllContactsFields();
        leftSelected = new List<String>();
        rightSelected = new List<String>();
        leftValues.addAll(mapAllFieldName.Keyset());
    }
    
    /*************Multi-Select value*******************************************************************************************/
    public PageReference getSelect(){
        rightSelected.clear();
        for(String s : leftSelected){
            leftValues.remove(s);
            rightValues.add(s);
        }
        return null;
    }
    public PageReference getDeselect(){    
        leftSelected.clear();
        for(String s : rightSelected){
            rightValues.remove(s);
            leftValues.add(s);
        }
        return null;
    }
    public List<SelectOption> getDeselectedValues(){
        List<SelectOption> options = new List<SelectOption>();
        List<String> objList = new List<String>();
        objList.addAll(leftValues);
        //objList.sort();
        for(String s : objList){
            options.add(new SelectOption(s,s));
        }
        return options;
    }
    public List<SelectOption> getSelectedValues(){
        List<SelectOption> options = new List<SelectOption>();
        List<String> objList = new List<String>();
        objList.addAll(rightvalues);
        // objList.sort();
        for(String s : objList){
            options.add(new SelectOption(s,s));
        }
        return options;
    }
    
    /************************fetch Contact Records*********************************************************************/
    public void fetchRecords(){
        String objectName = 'Contact';
        String condition = 'AccountId =: accountId';
        selectedFieldsList = New List<String>();
        allRightFields = new List<String>();
        
        if(rightValues.size() > 0){
            for(String str : rightValues){
                allRightFields.add(mapAllFieldName.get(str));
            }  
            String fieldName = String.join(allRightFields,',');
            // String fieldName = String.join(new List<String>(rightValues),',');
            if(String.isNotBlank(fieldName)){
                String query = 'SELECT '+ fieldName +' FROM ' + objectName + ' WHERE '+ condition;
                lstContact = Database.query(query);
            }
            if(allRightFields.size() > 0){
                selectedFields();
            }
        }       
    }
    public void selectedFields(){
        if(allRightFields.size() > 0){
            for(String allfields : allRightFields){
                selectedFieldsList.add(allfields);
            }
        }
    }
    
    /******************all Contact fields, call method constructor************************************************************************************/
    public Map<String, String> getAllContactsFields(){
        sobj = Schema.getGlobalDescribe().get('Contact').newSObject();
        mapAllFieldName = new Map<String, String>();
        Map<String, Schema.SobjectField> allMap = Schema.SobjectType.Contact.fields.getMap();
        //Set<string> mapset = allMap.keyset();
        for(Schema.SobjectField field : allMap.values()){
            Schema.DescribeFieldResult dfr = field.getDescribe();
            if(dfr.isCreateable()){
                mapAllFieldName.put(dfr.getLabel(), dfr.getName());
            }
        } 
        return mapAllFieldName;
    }
    /***********************Send contact Record CSV files******************************************************************************************/
    Public PageReference ExportToCSV(){
        PageReference pgRef = New Pagereference('/apex'+'/ContactExportToExcel');
        pgRef.setRedirect(false); 
        return pgRef;
    }
    public List<Contact> getContactRecords(){
        String objectName = 'Contact';
        String condition = 'AccountId =: accountId';
        selectedFieldsList = New List<String>();
        allRightFields = new List<String>();
        
        if(rightValues.size() > 0){
            for(String str : rightValues){
                allRightFields.add(mapAllFieldName.get(str));
            }  
            String fieldName = String.join(allRightFields,',');
            // String fieldName = String.join(new List<String>(rightValues),',');
            if(String.isNotBlank(fieldName)){
                String query = 'SELECT '+ fieldName +' FROM ' + objectName + ' WHERE '+ condition;
                lstContact = Database.query(query);
            }
        }
        return lstContact;
        //return  [SELECT FirstName, LastName, Email, Phone FROM Contact WHERE AccountId =: accountId];
    }
    
    public List<String> getColumnName(){
        selectedFieldsList = New List<String>();
        if(rightValues.size() > 0){
            for(String allfields : rightValues){
                selectedFieldsList.add(mapAllFieldName.get(allfields));
            } 
        }
        return selectedFieldsList;
    }
    /**********************************************************************/
}