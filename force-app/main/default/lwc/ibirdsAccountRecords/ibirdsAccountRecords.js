import { LightningElement, wire } from 'lwc';
import { columns } from './utility/share.js';
import accountRecordList from '@salesforce/apex/AccountContactController.accountRecordList';


export default class IbirdsAccountRecords extends LightningElement {
    accoundRecordId;
    accoundRecordName;
    columns = columns;
    // Account Records
    @wire(accountRecordList) accountRecords;
    // handle Row Id 
    handleRowAction(event) {
        this.accoundRecordId = event.detail.row.Id;
        this.accoundRecordName = event.detail.row.Name
    }

}