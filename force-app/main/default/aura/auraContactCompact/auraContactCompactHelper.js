({
    contactRecords: function(cmp, event, helper){
        var action = cmp.get("c.contactFieldSetRecords");
        action.setCallback(this, function(response){
            
            if(response.getReturnValue()){
                var data = response.getReturnValue();
                var contactRecs = data[0].contactList;
                var columns = [];
                for(let element of data[0].columns) {
                    columns.push(element.fieldName);
                }
                cmp.set("v.fields", columns);
            }
        });
        $A.enqueueAction(action);
    },
})