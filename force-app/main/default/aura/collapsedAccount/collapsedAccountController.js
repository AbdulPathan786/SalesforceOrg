({    
    doInit: function(component){
        var action = component.get("c.getAccount");
        action.setCallback(this, function(response){
            if(response.getReturnValue()){
                var data = response.getReturnValue();
                let mapRecords = data[0].mapRecs;
                let arrayMapKeys = [];
                for(var key in mapRecords){
                    arrayMapKeys.push({key: key, values : mapRecords[key]})
                }
                component.set('v.accountRecords', arrayMapKeys);
                // console.log('value....',arrayMapKeys[0].values.length);
                
                // columnsHorizontal
                var columnsNameHorizontal = [];
                for(let element of data[0].columnsHorizontal) {
                    columnsNameHorizontal.push(element.fieldName);
                }
                component.set("v.fieldApiNameHorizontal", columnsNameHorizontal);
                
                 // columnsVartical
                var columnsNameVartical = [];
                for(let element of data[0].columnsVartical) {
                    columnsNameVartical.push(element.fieldName);
                }
                component.set("v.fieldApiNameVartical", columnsNameVartical);
                
                 // columnsDetails
                var columnsNameDetails = [];
                for(let element of data[0].columnsDetails) {
                    columnsNameDetails.push(element.fieldName);
                }
                component.set("v.fieldApiNameDetails", columnsNameDetails);
            }
        });
        $A.enqueueAction(action);
    },
})