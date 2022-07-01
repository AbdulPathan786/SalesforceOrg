public class EmployeesTriggerHelper {
    
    public   static void upDateEmployees(Set<String> setEmp){
        List<Log__c> lstLog = new List<Log__c>();
        List<Employees__c>  lstEmployees = [SELECT Id, Status__c , (SELECT  Employees__c, Incident__c FROM Logs__r) FROM Employees__c
                                            WHERE Id in : setEmp];
        if(lstEmployees.size() > 0){
            
            for(Employees__c emp : lstEmployees){
                if(emp.Logs__r.size() > 0){
                    for(Log__c log : emp.Logs__r){
                        if(emp.Status__c == 'Active'){
                            log.Incident__c = 'new employee';
                            lstLog.add(log);
                        }
                        if(emp.Status__c == 'Inactive'){
                            log.Incident__c = 'removed employee';
                            lstLog.add(log);
                        }
                    }
                }
                else{
                    Log__c objLog = new Log__c();
                    objLog.Employees__c = emp.id;
                    if(emp.Status__c == 'Active'){
                        objLog.Incident__c = 'new employee';
                        lstLog.add(objLog);
                    }
                    if(emp.Status__c == 'Inactive'){
                        objLog.Incident__c = 'removed employee';
                        lstLog.add(objLog);
                    }
                    insert objLog;
                }
            }
        }
        if(lstLog.size() > 0){
            update lstLog;
        }
        
    }
}