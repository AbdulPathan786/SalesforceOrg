import { LightningElement, wire, api } from 'lwc';
import accountRecordList  from '@salesforce/apex/AccountContactController.accountRecordList';
import { refreshApex } from '@salesforce/apex';
import { updateRecord, deleteRecord } from 'lightning/uiRecordApi';
import { columns } from './utility/share.js';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE from '@salesforce/schema/Account.Phone';
import ACCOUNT_City from '@salesforce/schema/Account.BillingCity';
import ID_FIELD from '@salesforce/schema/Account.Id';

import { registerListener, unregisterAllListeners} from 'c/pubSubComponent';
import {CurrentPageReference} from 'lightning/navigation';

export default class accountRecordTable extends LightningElement {
    row;
    columns = columns;
    draftValues = [];
    actionName;


    // pubSub start
    @wire (CurrentPageReference) pageRef;
    connectedCallback() {
        registerListener('sendSearchCountry', this.handelSearchCountry, this);
    }
    disconnectedCallback(){
        unregisterAllListeners(this);
    }
    handelSearchCountry(parcel){
        return refreshApex(this.lstRecords);
    }
    // pubSub End

    @wire(accountRecordList)lstRecords;

    // Update Record
    handleSave(event) {
        const fields = {}; 
        fields[ID_FIELD.fieldApiName] = event.detail.draftValues[0].Id;
        fields[ACCOUNT_NAME.fieldApiName] = event.detail.draftValues[0].Name;
        fields[ACCOUNT_PHONE.fieldApiName] = event.detail.draftValues[0].Phone;
        fields[ACCOUNT_City.fieldApiName] = event.detail.draftValues[0].BillingCity;

        const recordInput = {fields};

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
            // Display fresh data in the datatable
            return refreshApex(this.lstRecords)

        }).catch(error => {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Error updating or reloading record',
                                    message: error.body.message,
                                    variant: 'error'
                                })
            );
        });
    }

        // handle Row Action Id
        handleRowAction(event){
            this.row = event.detail.row.Id;
            this.actionName = event.detail.action.name;

            // Account Record Delete
            if ( this.actionName === 'Delete' ){
                    deleteRecord(this.row)
                            .then(resultDelete => {
                                    this.dispatchEvent( new ShowToastEvent({
                                                                            title: 'Success',
                                                                            message: 'Record is  Deleted',
                                                                            variant: 'success',
                                                                        }),
                                    );
                                    return refreshApex(this.lstRecords)
                            })
                            .catch(error => {
                                this.dispatchEvent( new ShowToastEvent({
                                                                        title: 'Error While Deleting record',
                                                                        message: error.message,
                                                                        variant: 'error',
                                                                    }),
                                );
                            });
            }
         }
  
}