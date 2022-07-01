import { LightningElement, wire } from 'lwc';
import accountFieldSetRecords from '@salesforce/apex/LwcAccountFieldSet.accountFieldSetRecords';

export default class FieldSetAccount extends LightningElement {
    accountRecords;
    accountlabelName;

    @wire(accountFieldSetRecords)
    accRecords({ error, data }) {
        if (data) {
            this.accountRecords = data[0].accountList;
            this.accountlabelName = data[0].columns;
        } else if (error) {
            console.log('error##', error);
        }
    }

    handleRowAction(event) {
        this.accoundRecordId = event.detail.row.Id;
    }
}