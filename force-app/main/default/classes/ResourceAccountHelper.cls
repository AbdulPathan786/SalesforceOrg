/*
* @Name         : ResourceAccountHelper
* @Author       : Abdul Pathan
* @Date         : 06 jan, 2021
* @Description  : 
*/
global class ResourceAccountHelper{
    // Insert Account Records
    public String insertAccountRecords(AccountModel accountDetails){
        Account accountRec = new Account();
        accountRec.Name = accountDetails.Name;
        accountRec.Phone = accountDetails.Phone;
        Insert accountRec;
        return accountRec.Id;
    }
    // Upsert Records (Insert and Update Record)
    public String upsertRecord(AccountModel accRecord){
        Account accRec=new Account();
        if(String.isNotEmpty(accRecord.id)){
            accRec.Id = accRecord.Id;
        }
        accRec.Id = accRecord.Id;
        accRec.Name = accRecord.Name;
        accRec.Phone = accRecord.Phone;
        upsert accRec;
        return accRec.Id;
    }
    // delete Record
    /*
    public static void deleteRec(AccountModel deleteRecord){
        List<Account> accountRec = [SELECT Id, Name FROM Account WHERE Id =: deleteRecord.Id];
        if(accountRec.size() > 0){
            delete accountRec;
        }
    }*/
    
    // Reads or Retrieves Records.
    public Account getAccounts(Id accId){
        List<Account> accRecList = [SELECT Id, Name, Phone FROM Account WHERE Id =: accId];
        if(accRecList.size() > 0){
            return accRecList[0];
        }        
        return null;
    }
    public List<AccountModel> fillAccountModels(){
        List<Account> accountList = [SELECT Id, Name, Phone FROM Account LIMIT 100];
        List<AccountModel> accountModelList = new List<AccountModel>();
        for(Account accRec : accountList){
            AccountModel accModel = new AccountModel();
            accModel.Id = accRec.Id;
            accModel.Name = accRec.Name;
            accModel.Phone = accRec.Phone;
            accountModelList.add(accModel);
        }
        return accountModelList;
    }
}