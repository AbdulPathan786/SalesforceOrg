({
    recordUpdated : function(component, event, helper) {
        
        var changeType = event.getParam('changeType');
        //console.log('changeType',changeType);
        
        if(changeType==='LOADED'){
            component.set('v.currentVal',component.get('v.accountRecord').Industry);
        }
        else if(changeType==='CHANGED'){ 
            helper.fireworks(component, event, helper);
        } else if (changeType === "REMOVED") { 
            // handle record removal 
        }
    }
})