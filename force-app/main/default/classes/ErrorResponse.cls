/*
* @Name         : ErrorResponse
* @Author       : Abdul Pathan
* @Date         : 23 jan, 2021
* @Description  : 
*/
global class ErrorResponse {
    public String error_message;
    public integer error_code;
    public String error_detail; 
    
    global ErrorResponse(String error_message, integer error_code, String error_detail){
        this.error_message = error_message;
        this.error_code = error_code;
        this.error_detail = error_detail;
    } 
}