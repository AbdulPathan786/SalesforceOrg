({
    doInit: function(component){
        var action = component.get("c.getOpportunity");
        action.setCallback(this, function(response){
            
            if(response.getReturnValue()){
                 var data = response.getReturnValue();
                
                // columnsDetails
                var columnsNameDetails = [];
                for(let element of data[0].columnsHorizontal) {
                    columnsNameDetails.push(element.fieldName);
                }
                component.set("v.fieldApiName", columnsNameDetails);
            }
           
        });
        $A.enqueueAction(action);
    },
    
})