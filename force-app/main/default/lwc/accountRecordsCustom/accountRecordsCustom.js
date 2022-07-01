import { LightningElement, api, wire, track } from 'lwc';
import accountRecs from '@salesforce/apex/AccountContactController.accountDetails';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountRecordsCustom extends LightningElement {
    @api recordId;
    @api objectApiName;
    @track accountRecords;
    isModel = false;
    isEditModel = false;
    logo = '';

    // account Record data show
    @wire(accountRecs, { accId: '$recordId' })
    wiredAccount({ data, error }) {
        if (data) {
            this.accountRecords = data[0];
            if (this.accountRecords.conVersionId) {
                this.logo = `/sfc/servlet.shepherd/version/download/${this.accountRecords.conVersionId}`;
            }
        }
        else if (error) {
            console.log('error#', error);
        }
    }

    // handle edit click
    handleEditClick(event) {
        this.isEditModel = true;
    }
    // handle New Click
    handleNewClick() {
        this.isModel = true;
    }
    // closeModel
    closeModel() {
        this.isModel = false;
        this.isEditModel = false;
    }

    // handleSuccess Account create successfully
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Account created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
        this.closeModel();
    }
    
    // account update successfully
    handleSubmit(event) {
        const evt = new ShowToastEvent({
            title: "Account update",
            message: "Record id: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
        this.closeModel();
    }

}