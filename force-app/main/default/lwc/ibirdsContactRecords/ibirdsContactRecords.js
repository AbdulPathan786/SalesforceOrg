import { LightningElement, wire, api, track } from 'lwc';
//import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { contactColumns } from './utility/share.js';
import contactRecs from '@salesforce/apex/AccountContactController.accountContactRecs';

export default class IbirdsContactRecords extends LightningElement {

    @api accountId;
    @api accountName;
    isModel;
    columns;
    @track wiredContactRecords;
    @track contactRecords;

    constructor() {
        super();
        this.isModel = false;
        this.columns = contactColumns;
        this.wiredContactRecords = [];
        this.contactRecords = [];
    }

    // contact records
    @wire(contactRecs, { accountRecId: '$accountId' })
    contactList(result) {
        this.wiredContactRecords = result;
        if (result.data) {
            this.contactRecords = result.data;
        } else if (result.error) {
            console.log('error', result.error);
        }
    }
    // open model
    handleNewClick() {
        this.isModel = true;
    }
    
 /*    //Contact Records Save
    handleSuccess(event) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: event.detail.apiName + ' created.',
                variant: 'success',
            }),
        );
        refreshApex(this.wiredContactRecords);
        this.isModel = false;
    } */
     // close model
     closeModel() {
        refreshApex(this.wiredContactRecords);
        this.isModel = false;
    }
   

}