({    
    doInit: function(component){
        var action = component.get("c.fatchAccountRecords");
        action.setCallback(this, function(response){
            console.log('response....',response.getReturnValue());
            if(response.getReturnValue()){
                var data = response.getReturnValue();
                
                var columnsNameDetails = [];
                for(let element of data[0].columns) {
                    columnsNameDetails.push(element.fieldName);
                }
                component.set("v.fields", columnsNameDetails);
            }
        });
        $A.enqueueAction(action);
    },
})