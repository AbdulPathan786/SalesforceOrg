/*
* Name         : ContactSearchController
* Author       : Abdul Pathan
* Date         : 03 Feb, 2020
* Description  : This page is used to find contacts based on search criteria.
                 Search Contacts On click of Search button, it will
                 search contacts based on name and email (contains) and show in bottom table.
*/

public class ContactSearchDemo{
    
    public List<WrapperContact> lstWrapperContact {get;set;}
    List<Contact> lstContact {get;set;}
    public String textSearch {get;set;}
    public Boolean status {get;set;}
    public Boolean selectRendered {get;set;}
    public String selectPicklistValue {get;set;}
    
    public Integer record { get;set;}
    public Integer totalRecors {get;set;}
    public Integer totalSize;                    //used to show user the total size of the list  
    private Integer listSize = 5;               //to set the page size to show the rows/records
    private integer counter = 0;                 //to keep track of offset
    private String SortingExpression = 'Name';
    private String DirectionOfSort = 'ASC';
    
    public String recordId {get;set;}
    public String FirstName {get;set;}
    public String LastName {get;set;}
    public String FullName{get;set;}
    public id imageId{get;set;}
    public string selectedValue {get;set;}
    public id NoImageContact{get;set;}
    public Boolean attachRender {get;set;}
    public String ShowMassage{get;set;}
    public String Subject{get;set;}
    public Contact attach{get;set;}
    public List<Contact> lstContactChild{get;set;}
    public String deleteId{get;set;}
    private List<Contact> deleteContactChild {get;set;}
    public Integer removeRow{get;set;}
    
    
    // Constructor calling  method
    public ContactSearchDemo(){
        
        attachRender = false;
        //imageId = '00P2w000000RXc8';
        selectRendered = true;
        deleteContactChild = new List<Contact>();
       // updateContactChild = new List<Contact>();
        refreshList(); 
        getPickList();
        totalRecors = totalSize = [SELECT count() FROM Contact];
        lstContactChild = new List<Contact>();
        lstContactChild.add(new Contact(Contact_Self_Lookup__c = recordId));
    }
    
    
    // Method when call Constructor
    public void refreshList(){
        status = true;
        lstContact = [SELECT Name, FirstName, LastName, Email, Type__c, Phone, Account.Name
                      FROM Contact
                      limit : listSize OFFSET : counter
                     ];
        if (lstContact.size() > 0){
            wrapperAddList(lstContact);
        }
    }
    
    // Method when call Constructor pickList Value
    public List<SelectOption> getPickList(){
        //This function get the dynamic picklist value.
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', 'Select type'));
        Schema.DescribeFieldResult fieldResult = contact.Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }      
        return options;
    }
    
    
    
    // Search Contact Record
    public void searchContact(){
        attachRender = false;
        lstWrapperContact = new  List<WrapperContact>();
        status = true;
        String text ='%' + textSearch + '%';
        selectRendered = true;
        counter = 0;
        lstContact = [SELECT Name, Account.Name, Phone, Email, Type__c
                      FROM Contact 
                      WHERE Name Like : text or Email like : text
                      limit : listSize OFFSET : counter
                     ];
        
        if (lstContact.size() > 0){
            wrapperAddList(lstContact);
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Contact Record Not Found'));
            selectRendered = false;
        }
    }
    
    
    
    // Positive and Nagetive value update
    public void save(){
        attachRender = false;
        List<Contact> lstContactUpdate = new List<Contact>();
        for(WrapperContact objWrapper : lstWrapperContact){
            if(objWrapper.selected){
                objWrapper.selected = false;
                objWrapper.objContact.type__c = selectPicklistValue;
                lstContactUpdate.add(objWrapper.objContact);
            }
        }
        update lstContactUpdate;
    }
    
    
    // updatePage According Size Page
    public void updatePage(){
        attachRender = false;
        lstContact.clear();
        listSize = record ;
        lstContact = [SELECT Name, Account.Name, Phone, Email, Type__c 
                      FROM Contact  
                      limit : record OFFSET : counter
                     ];
        if (lstContact.size() > 0){
            wrapperAddList(lstContact);
        }
    }
    
    
    
    // Pagination 
    public void pagination(){
        attachRender = false;
        String query = 'SELECT Name, Account.Name, Phone, Email, Type__c FROM Contact limit : listSize OFFSET : counter';
        if(totalSize != null && totalSize == 0){
            List<Contact> conTemp = Database.query(Query);
            totalSize = (conTemp != null && conTemp.size()>0) ? conTemp.size() : 0;
        }
        lstContact = Database.query(query);
        if (lstContact.size() > 0){
            wrapperAddList(lstContact);
        }
    }
   
    
    public void beginning() {  
        counter = 0;
        pagination();
    } 
    public void previous() { 
        counter = counter - listSize;
        if(counter < 0){
            counter = 0;
        }
        pagination();
    }
    public void next() {   
        counter = counter + listSize;
        pagination();
    }
    public void  end() {      
        counter = totalSize - math.mod(totalSize, listSize); 
        pagination();
    }
    
    public Boolean getDisabledPrevious() {      
        if(counter > 0)
            return false;
        else 
            return true;
    }
    public Boolean getDisabledNext() {      
        if ((counter + listSize) > totalSize || lstContact.size() < listSize) 
            return true; 
        else 
            return false;
    }
    public Integer getTotalSize() {
        return totalSize;
    }
    public Integer getPageNumber() {
        return counter/listSize + 1;
    }
    public Integer getTotalPages() {
        if (math.mod(totalSize, listSize) > 0) {
            return totalSize/listSize + 1;
        } 
        else {
            return (totalSize/listSize);
        }
    }
    
     
    // Sorting code  
    public String expressionSort {
        get {
            return SortingExpression;
        }
        set {
            If(value == SortingExpression) {
                DirectionOfSort = (DirectionOfSort == 'ASC')? 'DESC' : 'ASC';
            }
            else {
                DirectionOfSort = 'ASC';
                SortingExpression = value;
            }
        }
    }
    
    public String getDirectionOfSort() {
        If(SortingExpression == Null || SortingExpression == '') {
            return 'Asc';
        }
        else {
            return DirectionOfSort;
        }
    }
    
    public void setDirectionOfSort(String value) {
        DirectionOfSort = value;
    }
    
    public void sortData() {
        String FullSortExpression = SortingExpression + ' ' + DirectionOfSort;
        String Queryitem = 'SELECT Name, Account.Name, Phone, Email, Type__c FROM Contact ORDER BY ' + FullSortExpression +' Limit : listSize';
        lstContact = DataBase.query(Queryitem);
        if (lstContact.size() > 0){
            wrapperAddList(lstContact);
        }
    }
    
    
    
    // wrapperAddList Contact
    public void wrapperAddList(List<Contact> lstCon){
        lstWrapperContact = new  List<WrapperContact>();
        for(Contact allContact : lstContact){
            WrapperContact objWrapperContact = new WrapperContact(allContact);              
            lstWrapperContact.add(objWrapperContact);
        }
    }
    
    
    // Wrapper Class
    public class WrapperContact{
        public Contact objContact {get;set;}
        public Boolean selected {get;set;}
        
        public WrapperContact(Contact obj){
            this.objContact = obj;
            selected = false; 
        }  
    }
    
    
    // attachmentImage
    public void attachmentImage(){
        childRecord();
        imageId = null;
        attachRender = true;
        attach = [SELECT Name 
                  from Contact 
                  WHERE id =: recordId
                 ];
        Integer attachCount =  [SELECT count() 
                                from Attachment 
                                WHERE parentid =: recordId
                               ];
        if(attachCount > 0){
            attach = [SELECT id, Name, (SELECT id, Name from Attachments)
                      FROM Contact
                      WHERE Id =: recordId
                     ];
            imageId = attach.Attachments.get(0).id; 
        }
        
        List<Task> lstTask = [SELECT WhoId, Subject, ActivityDate, Status 
                              FROM Task 
                              WHERE WhoId =: recordId
                             ];
        
        if(lstTask.size() > 0){
            for(Task objTask : lstTask){
                System.debug('objTaskobjTask' + objTask);
                Subject =  objTask.Subject;
                ShowMassage = 'you have responded ' + objTask.Subject + ' on ' + objTask.ActivityDate; 
            }
        }
        else{
            Subject = null;
            ShowMassage = ' ' ;
        }
    }
    
    // Save Method Task Assign
    public void saveTask(){
        if(Subject != null && recordId != null){
            List<Task> lstTask1 = [SELECT WhoId, Subject, ActivityDate, Status
                                   FROM Task
                                   WHERE WhoId =: recordId
                                  ];
            
            if(lstTask1.size() > 0){
                Task objTask = new Task(id = lstTask1.get(0).id, Subject = Subject, ActivityDate = System.today());
                update objTask;
                System.debug('objTask' + objTask);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,' Successfully Task update'));
            }
            else{
                Task objTask = new Task(WhoId = recordId, Subject = Subject, ActivityDate = System.today());
                insert objTask;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,' Successfully Task Assign'));
            }
        }
        attachmentImage();
    }
    
    
    //  ChildRecord Method Call attachmentImage() and Show and Add child Record 
    public void childRecord(){
        Contact objContact = [select id, FirstName, LastName, Email, Phone, 
                              (Select id ,  FirstName, LastName, Email, Phone from contacts__r) 
                              from contact 
                              WHERE id =: recordId
                             ];
        lstContactChild = objContact.contacts__r;
    }
    
    public void addRow(){
        lstContactChild.add(new Contact(Contact_Self_Lookup__c = recordId));
    }
    
    public void submit(){
        List<Contact> updateContactChild = new  List<Contact>();
        if(lstContactChild.size() > 0){
            for(Contact objCont : lstContactChild){
                if(objCont.LastName != null){
                    updateContactChild.add(objCont);
                }
            }
        }
        
        
        if(updateContactChild.size() > 0){
            upsert updateContactChild;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,' Insert and Update Record Success'));
        }
        
        if(deleteContactChild.size() > 0){
            delete deleteContactChild;
            deleteContactChild.clear();
        }
    }
    
    public void deleteRow(){
       // List<Contact> deleteContactChild = new  List<Contact>();
        if(lstContactChild.size() > 0){
            for(Contact objCont : lstContactChild){
                if(String.isNotBlank(lstContactChild[removeRow].id)){
                    if(deleteId == objCont.id){
                        deleteContactChild.add(objCont);
                    }
                }
            }
            lstContactChild.remove(removeRow);
        }      
    } 
    
}