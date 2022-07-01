/*
export const columns = [
                        { label: 'Name', fieldName: 'Name', editable: true },
                        { label: 'Phone', fieldName: 'Phone', editable: true },
                        { label: 'BillingCity', fieldName: 'BillingCity', editable: true },
                        {label:'Edit', type: "button", typeAttributes: {  
                                                                            label: 'Edit',  
                                                                            name: 'Edit',  
                                                                            title: 'Edit',
                                                                            variant: "base",  
                                                                            disabled: false,  
                                                                            value: 'edit',  
                                                                            iconPosition: 'left'  
                                                                        }},

                        {label:'Delete', type: "button", typeAttributes: {  
                                                                            label: 'Delete',  
                                                                            name: 'Delete',  
                                                                            title: 'Delete',
                                                                            variant: "base",  
                                                                            disabled: false,  
                                                                            value: 'delete',  
                                                                            iconPosition: 'left'  
                                                                        }} 

                    ];
*/

export const columns = [
                        { label: 'Name', fieldName: 'Name', editable: true },
                        { label: 'Phone', fieldName: 'Phone', type: 'phone', editable: true },
                        { label: 'BillingCity', fieldName: 'BillingCity', editable: true },
                        {label:'Delete', type: "button", typeAttributes: {  
                                                                            label: 'Delete',  
                                                                            name: 'Delete',  
                                                                            title: 'Delete',
                                                                            variant: "base",  
                                                                            disabled: false,  
                                                                            value: 'delete',  
                                                                            iconPosition: 'left'  
                                                                        }} 
                    ];