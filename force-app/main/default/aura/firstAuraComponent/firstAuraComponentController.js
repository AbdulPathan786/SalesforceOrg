({
    doInit : function(component, event, helper) {
        helper.getAccontRecord(component); // Calling Helper method
    },
    
    handleClick : function (cmp, event, helper) {
        alert("You clicked: Account Record Show :- " + event.getSource().get("v.label"));
        cmp.set("v.truthy", true);        
    },
    
    
    // Account Record view
    handleClickView : function (cmp, event, helper) {
        alert("Account Record View :-> " + event.getSource().get("v.value"));
        const selectedRecordId = event.getSource().get("v.value");
        cmp.set("v.modal", true);
    },
    
    modalClosed : function(cmp, event, helper){
        alert("Account Record Cancel :-> " + event.getSource().get("v.label"));
        cmp.set("v.modal", false);
    },
    
    
    
    
})