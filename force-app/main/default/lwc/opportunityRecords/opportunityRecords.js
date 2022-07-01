import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import opportunityRecs from '@salesforce/apex/AccountOpportunityController.opportunityRecords';
export default class OpportunityRecords extends LightningElement {
    @api recordId;
    @api objectApiName;
    accountRecords;
    error;
    isModel = false;
    isEditModel = false;
    wiredAccountList = [];
    oppLenght;
    oppRecordId;

    @wire(opportunityRecs, { accountId: '$recordId' }) accList(result) {
        this.wiredAccountList = result;
        if (result.data) {
            this.accountRecords = result.data;
            this.oppLenght = this.accountRecords.length;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.accountRecords = [];
        }
    }

    // New button click open model
    handleNewClick() {
        this.isModel = true;
        this.isEditModel = false;
    }

    // closeModel
    closeModel() {
        this.isModel = false;
        this.isEditModel = false;
    }

    // handleSuccess opportunity create successfully 
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Opportunity created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
        refreshApex(this.wiredAccountList);
        this.closeModel();
    }
    // Edit Record save
    handleSubmit(event) {
        const evt = new ShowToastEvent({
            title: "Opportunity Record update",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
        refreshApex(this.wiredAccountList);
        this.closeModel();
    }
    // Edit Record open model
    handleClick(event) {
        this.isEditModel = true;
        this.oppRecordId = event.target.value;
        console.log('handleClick', event.target.value);
    }
}