/*
* @Name         : ResourceAccount
* @Author       : Abdul Pathan
* @Date         : 06 jan, 2022
* @Description  : 
* callback url : https://www.postman.com/oauth2/callback
* getRequestPostman : https://na50.salesforce.com/services/apexrest/serveraccounts
* postRquestPostman : https://na50.salesforce.com/services/data/v39.0/sobjects/Account
*/
@RestResource(urlMapping='/serveraccounts/*')
global with sharing class ResourceAccount{
    // Creates Records  
    @HttpPost  
    global static void doPostAccountRecords(AccountModel accountDetails){ 
        RestResponse response = RestContext.response; 
        response.addHeader('Content-Type','application/json');
        try{
            ResourceAccountHelper accountHelper = new ResourceAccountHelper(); 
            String accId = accountHelper.insertAccountRecords(accountDetails);
            response.responseBody = Blob.valueOf(JSON.serialize(new SuccessResponse(true, 'Successfully Inserted Record', 201, accId)));
        }catch(Exception e){
            System.debug(e.getMessage());
            response.responseBody = Blob.valueOf(JSON.serialize(new ErrorResponse(e.getMessage(), 500, e.getStackTraceString())));
        }
    }   
    // Reads or Retrieves Records. 
    @HttpGet  
    global static void doGetAccountRecords(){
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response; 
        response.addHeader('Content-Type','application/json');
        try{
            String url = request.requestURI;
            System.debug('url : ' + url);
            String accountId = url.substring(url.lastIndexOf('/')+1);
            System.debug('accountId : ' + accountId);
            ResourceAccountHelper accountHelper = new ResourceAccountHelper(); 
            GetAccountListResponse accountListResponse = new GetAccountListResponse();
            
            List<AccountModel> accountModelList;
            if(accountId.equals('serveraccounts')){
                accountListResponse.success = true; 
                accountListResponse.accounts = accountHelper.fillAccountModels();
                accountListResponse.total_account = accountListResponse.accounts.size();
            }
            response.responseBody = Blob.valueOf(JSON.serialize(accountListResponse)); 
        }
        catch(Exception e){
            System.debug(e.getMessage());
            response.responseBody = Blob.valueOf(JSON.serialize(new ErrorResponse(e.getMessage(), 500, e.getStackTraceString())));
        }
    }
    
    @HttpPut // Upsert
    global static void doPutMethod(AccountModel accRecord){
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response; 
        response.addHeader('Content-Type','application/json');
        try{
            String accId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
            ResourceAccountHelper accountHelper = new ResourceAccountHelper(); 
            String accIds = accountHelper.upsertRecord(accRecord);
            response.responseBody = Blob.valueOf(JSON.serialize(new SuccessResponse(true, 'Record Save Successfully', 201, accIds)));
        }
        catch(Exception e){
            System.debug(e.getMessage());
            response.responseBody = Blob.valueOf(JSON.serialize(new ErrorResponse(e.getMessage(), 500, e.getStackTraceString())));
        }
    }
    @HttpDelete  // delete Record
    global static void deleteRecord(){
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response; 
        try{
            String accId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
            //ResourceAccountHelper accHelper=new ResourceAccountHelper();
            // String accIds = accHelper.deleteRec(deleteRecord);
            List<Account> accountRec = [SELECT Id, Name FROM Account WHERE Id =: accId];
            if(accountRec.size() > 0){
                delete accountRec;
            }
            response.responseBody = Blob.valueOf(JSON.serialize(new SuccessResponse(true, 'Record Deleted Successfully', 201, accId)));
        }
        catch(Exception e){
            System.debug(e.getMessage());
            response.responseBody = Blob.valueOf(JSON.serialize(new ErrorResponse(e.getMessage(), 500, e.getStackTraceString())));
        }
    }
    
    @HttpPatch  //  Update 
    global static void doPatchMethod(){
        
    }
}