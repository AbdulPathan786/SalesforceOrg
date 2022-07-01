({
    doInit : function(cmp, evt) {
        // columnsName
        cmp.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Created Date', fieldName: 'CreatedDate', type: 'date'},
            {label: 'Created By', fieldName: 'CreatedBy', type: 'text'}
        ]);
        
        var action = cmp.get("c.setViewStat"); // apex Class method call
        action.setParams({ "accountId": cmp.get("v.recordId") }); // account Id send apex method
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                //console.log('rows' + JSON.stringify(rows));
                for ( var i = 0; i < rows.length; i++ ) {
                    var row = rows[i];
                    if ( row.Claim ) {
                        row.Claim.Name = row.Claim.Name;
                    }
                    if ( row.CreatedBy ) {
                        row.CreatedBy = row.CreatedBy.Name;
                    }
                }
                cmp.set( "v.claims", rows );
            }
        });
        $A.enqueueAction(action);
    },
})