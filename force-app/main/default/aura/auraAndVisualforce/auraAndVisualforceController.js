({ 
    openSingleFile : function (cmp, event, helper) {
        //var fileRecordId = cmp.get("v.ContentDocumentId");
        
        alert('Ajmer');
        console.log('get  :-  '+$A.get('e.lightning:openFiles'));     
        var openPreview = $A.get('e.lightning:openFiles');
        openPreview.fire({  
            recordIds: ['0692w000009tRqQAAU']  
        });
        
        console.log('test');
    },
})