/*
* Author : Abdul Pathan
* Created At  : 23 November, 2021
* Description : 
*/
global class scheduledInvoiceBatch implements Schedulable {
    global void execute(SchedulableContext sc) {
        InvoiceBatch invoice = new InvoiceBatch(); 
        Database.executeBatch(invoice);
    }
}