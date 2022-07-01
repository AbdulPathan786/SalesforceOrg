({
    doInit: function(component, event, helper) {
        var action = component.get("c.getStatusFieldValue");
        action.setCallback(this, function(response) {
            var state = response.getState();
            alert('accId' + state);
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                  //alert("From fieldMap: " + JSON.stringify(result));
                var fieldMap = [];
                for(var key in result){
                    fieldMap.push({key: key, value: result[key]});
                }
                component.set("v.fieldMap", fieldMap);
            }
        });
        $A.enqueueAction(action);
    },

})