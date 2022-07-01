export const columnsAccount = [
                                { label: 'Name', fieldName: 'Name', editable: 'true' },
                                { label: 'Phone', fieldName: 'Phone', editable: 'true' },
                                { label: 'BillingCity', fieldName: 'BillingCity', editable: 'true' },
                                {label:'Details', type: "button", typeAttributes: {  
                                                                                    label: 'ChildRecord',  
                                                                                    name: 'Details',  
                                                                                    title: 'Details',
                                                                                    variant: "base",  
                                                                                    disabled: false,  
                                                                                    value: 'Details',  
                                                                                    iconPosition: 'left'  
                                                                                }},
                                {label:'Delete', type: "button", typeAttributes: {  
                                                                                    label: 'Delete',  
                                                                                    name: 'Delete',  
                                                                                    title: 'Delete',
                                                                                    variant: "base",  
                                                                                    disabled: false,  
                                                                                    value: 'Delete',  
                                                                                    iconPosition: 'left'  
                                                                                }},
                                                                                
                            ];

export const columnsContact = [
                                { label: 'Name', fieldName: 'Name' },
                                { label: 'Email', fieldName: 'Email' },
                                { label: 'Phone', fieldName: 'Phone' },
                            ];