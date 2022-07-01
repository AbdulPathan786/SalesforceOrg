import { LightningElement, wire } from 'lwc';
import { columnsAccount, columnsContact } from './utility/share.js';
import { deleteRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import accountChildRecord from '@salesforce/apex/AccountContactController.accountChildRecord';
import accountSearchCityName from '@salesforce/apex/AccountContactController.accountSearchCityName';

import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE from '@salesforce/schema/Account.Phone';
import ACCOUNT_City from '@salesforce/schema/Account.BillingCity';
import ID_FIELD from '@salesforce/schema/Account.Id';

export default class AccountContactRecordDetails extends LightningElement {
    columnsAccount;
    columnsContact;
    //lstAccountRecord;
    row;
    actionName;
    contactRecords;
    errorMessage;
    openDialogBox;
    childRecord;
    draftValues = [];
    searchInput;
    accountRecord;
    isDataTable;
    accountRecs;
    // constructor
    constructor() {
        super();
        this.columnsAccount = columnsAccount;
        this.columnsContact = columnsContact;
        this.searchInput = 'All';
        this.openDialogBox = false;
        this.childRecord = false;
        this.isDataTable = true;

    }

    // Child Record and  Delete Record
    handleRowAction(event) {
        this.row = event.detail.row.Id;
        this.actionName = event.detail.action.name;

        if (this.actionName == 'Details') {
            this.openDialogBox = true;
            accountChildRecord(
                { accId: this.row }
            )
                .then(result => {
                    this.childRecord = false;
                    this.contactRecords = result;
                    if (this.contactRecords.length > 0) {
                        this.contactRecords = result;
                        this.childRecord = true;
                    }
                })
                .catch(error => {
                    this.errorMessage = error;
                    console.log('Error : ', error);
                })
        }

        // deleteRecord
        if (this.actionName == 'Delete') {
            this.openDialogBox = false;
            deleteRecord(this.row)
                .then(result => {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted',
                        variant: 'success'
                    })
                    );
                    return refreshApex(this.lstAccount);
                })
                .catch(error => {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                    );
                });
        }
    }


    // Update Record
    handleSave(event) {
        const fields = {};
        fields[ID_FIELD.fieldApiName] = event.detail.draftValues[0].Id;
        fields[ACCOUNT_NAME.fieldApiName] = event.detail.draftValues[0].Name;
        fields[ACCOUNT_PHONE.fieldApiName] = event.detail.draftValues[0].Phone;
        fields[ACCOUNT_City.fieldApiName] = event.detail.draftValues[0].BillingCity;
        const recordInput = { fields };
        // updateRecord
        updateRecord(recordInput)
            .then(recordUpdate => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account updated',
                        variant: 'success'
                    })
                );
                return refreshApex(this.lstAccount).then(() => {
                    this.draftValues = [];
                }
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating or reloading record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }


    closeDialogBox() {
        this.openDialogBox = false;
    }

    handleClick(event) {
        this.searchInput = this.template.querySelector('lightning-input[data-id ="searchInput"]').value;
        accountSearchCityName(
            { searchCity: this.searchInput }
        )
            .then(result => {
                this.accountRecord = result;
                if (this.accountRecord.length > 0) {
                    this.isDataTable = true;
                }
                else {
                    this.isDataTable = false;
                }
            })
            .catch(error => {
                console.log('error', error);
            })

    }

}