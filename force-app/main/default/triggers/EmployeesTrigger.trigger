trigger EmployeesTrigger on Employees__c (After Insert, After update) {
    
    Set<String> setEmp= new Set<String>();
    if(Trigger.isInsert && Trigger.isAfter){
        for(Employees__c objEmployee : Trigger.New){
            setEmp.add(objEmployee.Id);
        }
        EmployeesTriggerHelper.upDateEmployees(setEmp);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        for(Employees__c objEmployee : Trigger.New){
            setEmp.add(objEmployee.Id);
        }
        EmployeesTriggerHelper.upDateEmployees(setEmp);
    }
}