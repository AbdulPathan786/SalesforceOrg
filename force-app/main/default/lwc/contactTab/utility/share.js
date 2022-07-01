const contactColumns = [
                        { label: 'Name', fieldName: 'Name' },
                        { label: 'FirstName', fieldName: 'FirstName' },
                        { label: 'LastName', fieldName: 'LastName' },
                        { label: 'Phone', fieldName: 'Phone' },
                    ];

const oppColumns = [
                        { label: 'Name', fieldName: 'Name' },
                        { label: 'StageName', fieldName: 'StageName' },
                        { label: 'Amount', fieldName: 'Amount' },
                        { label: 'Probability', fieldName: 'Probability' },
                        //{ type: 'action', typeAttributes: { rowActions: actions }, },
                    ];

const taskcolumns = [
                        { label: 'Status', fieldName: 'Status' },
                        { label: 'Subject', fieldName: 'Subject' },
                    ];

const attachcolumns = [
                        { label: 'IsDeleted', fieldName: 'IsDeleted' },
                        { label: 'IsPrivate', fieldName: 'IsPrivate' },
                        { label: 'Description', fieldName: 'Description' },
                    ];

export { contactColumns, oppColumns, taskcolumns, attachcolumns }