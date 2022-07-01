/*
* @Name         : TimecardManagementController
* @Author       : Abdul Pathan
* @Date         : 02 March, 2020
* @Description  : This Class is useful for search the assign project to a specific user and get
                  to known about that a user how many hour work in a weak.
*/

public class TimecardManagementController {
    public Timecard__c timecardRecord{get;set;}
    public String selectedResource{get;set;}
    public String textArea{get;set;}
    public List<TimecardModel> lstTimecardModel{get;set;}
    private Integer rowIndex = 0;
    public String deleteRowIndex{get;set;}
    private Integer folderIndex = 0;
    public String descriptionIndex{get;set;}
    private List<Timecard__c> deleteRecord;
    // private Set<id> deleteRecord;
    // Constructor 
    public TimecardManagementController(){
        textArea = '';
        deleteRecord = new List<Timecard__c>();
        // deleteRecord = new Set<id>();
        timecardRecord = new Timecard__c();
        timecardRecord.Week_Start__c = System.today().toStartOfWeek();
        init();
    }
    
    Private void init(){
        lstTimecardModel = new List<TimecardModel>();
        try{
            timecardRecord.Week_Start__c = timecardRecord.Week_Start__c.toStartofWeek();
            timecardRecord.Week_End__c =  timecardRecord.Week_Start__c.addDays(7);
        }
        catch(exception e){}
        
        for(Timecard__c timeRecord : [SELECT Id, Name, Week_Start__c, Week_End__c, hours__c, Project_Resource__c, Project_Description__c,
                                      Hours_Mon__c, Hours_Tue__c, Hours_Wed__c, Hours_Fri__c, Hours_Thu__c, Hours_Sat__c, Hours_Sun__c 
                                      FROM Timecard__c
                                      WHERE Project_Resource__r.Resource__c =: selectedResource AND
                                      Week_Start__c >=: timecardRecord.Week_Start__c AND Week_End__c <=: timecardRecord.Week_End__c 
                                     ]){
                                         TimecardModel tcm = new TimecardModel(timeRecord);
                                         tcm.index = rowIndex++;
                                         tcm.indexFolder = folderIndex++;
                                         // tcm.timeRecord = timeRecord;
                                         tcm.selectedProjectResource = timeRecord.Project_Resource__c;
                                         lstTimecardModel.add(tcm);
                                     }
    }
    
    // SelectOption PicklistValue 
    public List<SelectOption> getResource(){
        List<SelectOption> option = new List<SelectOption>();
        option.add(new SelectOption('', 'Select type'));
        for(Contact contactResource : [SELECT id, Name FROM Contact Limit 10]){
            option.add(new SelectOption(contactResource.id, contactResource.Name));
        }
        return option;
    }
    //  Project SelectOption
    public List<SelectOption> getProjects(){
        List<SelectOption> option = new List<SelectOption>();
        option.add(new SelectOption('', 'Select type'));
        for(Project_Resource__c projectResource : [SELECT id, Project2__c, Project2__r.Name  FROM Project_Resource__c 
                                                   WHERE Resource__c =: selectedResource Limit 10]){
                                                       option.add(new SelectOption(projectResource.id, projectResource.Project2__r.Name));
                                                   }
        return option;
    }
    
    // save Button
    public void save(){
        List<Timecard__c> saveRecords = new List<Timecard__c>();
        for(TimecardModel tm : lstTimecardModel){
            tm.timeRecord.Project_Resource__c = tm.selectedProjectResource;
            saveRecords.add(tm.timeRecord);
        }
        try{
            if(saveRecords.size() > 0)
                upsert saveRecords;
            if(deleteRecord.size() > 0)
                delete deleteRecord;
        }
        catch(exception e){
            System.debug('abc' + saveRecords + 'bh' + deleteRecord);
        }
        init();
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM,' Record save succesfully');
        ApexPages.addMessage(myMsg);
    }
    // Add Row Button
    public void addRow(){
        TimecardModel tcm = new TimecardModel(new Timecard__c(Week_Start__C =  timecardRecord.Week_Start__c,
                                                              Week_End__c  = timecardRecord.Week_End__c 
                                                             ));
        tcm.index = rowIndex++;
        tcm.indexFolder = folderIndex++;
        lstTimecardModel.add(tcm);
    }
    
    //  saveDescription submit button save record
    public void saveDescription(){
       // System.debug('updateRecord' + recordFolderIndex );
        List<TimecardModel> tempListss = new List<TimecardModel>();
        for(TimecardModel objTimecard : lstTimecardModel){
            // system.debug('index folder -> '+objTimecard.indexFolder);
            if(objTimecard.indexFolder == Integer.valueOf(descriptionIndex)) {
                objTimecard.timeRecord.Project_Resource__c = objTimecard.selectedProjectResource;
                objTimecard.timeRecord.Project_Description__c = textArea;
                tempListss.add(objTimecard);
            }
        } 
        if(tempListss.size() > 0){
            List<Timecard__c> lstNewTimeCards = new List<Timecard__c>();
            for(TimecardModel objTimeCardModel : tempListss){
                lstNewTimeCards.add(objTimeCardModel.timeRecord);
            }
            if(lstNewTimeCards.size() > 0){
                upsert lstNewTimeCards;
            }
        }  
    }
    
    // onclick function index description
    public void saveDescrip(){
        System.debug('descriptionIndex' + descriptionIndex );
    }
    
    // Delete Row Index
    public void deleteRow(){
        List<TimecardModel> tempList = new List<TimecardModel>();
        for(TimecardModel tm : lstTimecardModel){
            if(tm.index == Integer.valueOf(deleteRowIndex)){
                if(tm.timeRecord.id != null ){
                    //  deleteRecord.add(tm.timeRecord.id); 
                    deleteRecord.add(new Timecard__c(id = tm.timeRecord.id)); 
                }
            } 
            else{
                tempList.add(tm);
            }
        }
        lstTimecardModel = tempList;
    }
    
    // refreshTimecard
    public void refreshTimecard(){
        init();
    }
  		  /*  
        public String getMonHeading(){
        Date monDt = timecardRecord.Week_Start__c.addDays(1);
        return monDt.format();
		}*/
    
    // Wrapper Class
    public class TimecardModel{
        public Integer index{get;set;}
        public Integer indexFolder{get;set;}
        public Timecard__c timeRecord{get;set;}
        public Decimal totalHours{get;set;}
        public string selectedProjectResource{get;set;}
        
        public TimecardModel(Timecard__c timeRecord){
            this.timeRecord = timeRecord;
            if(timeRecord.id != null)
                totalHours = timeRecord.Hours_Mon__c + timeRecord.Hours_Tue__c + timeRecord.Hours_Wed__c + 
                timeRecord.Hours_Tue__c + timeRecord.Hours_Fri__c + timeRecord.Hours_Sat__c + 
                timeRecord.Hours_Sun__c;
        }
    }
   
}