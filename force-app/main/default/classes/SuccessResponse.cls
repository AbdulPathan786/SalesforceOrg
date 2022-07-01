/*
* @Name         : SuccessResponse
* @Author       : Abdul Pathan
* @Date         : 23 jan, 2021
* @Description  : 
*/
global class SuccessResponse {
    public boolean success;
    public String message;
    public integer code;
    public String id;
    
    global SuccessResponse(boolean success, String message, integer code, String id){
        this.success = success;
        this.message = message;
        this.code = code;
        this.id = id;
    }
}