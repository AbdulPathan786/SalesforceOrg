import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord  } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_Phone from '@salesforce/schema/Account.Phone';
import ACCOUNT_City  from '@salesforce/schema/Account.BillingCity';

import {fireEvent} from 'c/pubSubComponent';
import {CurrentPageReference} from 'lightning/navigation';

export default class CreateAccountRecord extends LightningElement {
    accountId;
    message;
    isVisible = false;
    isErrorMessage = false;
    buttonIcon = true;
  //CurrentPageReference
  @wire (CurrentPageReference) pageRef;

    accountSave(event){
        const accName = this.template.querySelector('lightning-input[data-id=texName]').value;
        const accPhone = this.template.querySelector('lightning-input[data-id=texPhone]').value;
        const accCity = this.template.querySelector('lightning-input[data-id=texBillingCity]').value;
        
        if(accName != '' && accPhone != '' && accCity != ''){
        
            const fields = {};
            fields[ ACCOUNT_NAME.fieldApiName] = accName;
            fields[ACCOUNT_Phone.fieldApiName] = accPhone;  
            fields[ACCOUNT_City.fieldApiName] = accCity;      

            const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };

            createRecord(recordInput)
                .then(account => {
                        this.isVisible = true;
                        this.isErrorMessage = false;
                        this.buttonIcon = false;
                        this.accountId = account.id;
                    this.dispatchEvent( new ShowToastEvent({
                                                                title: 'Success',
                                                                message: 'Account created',
                                                                variant: 'success',
                                                            }),
                                    );
                         fireEvent(this.pageRef, 'sendSearchCountry', {'countrySerachName': this.searchCountry});
                })
                .catch(error => {
                    this.dispatchEvent( new ShowToastEvent({
                                                                title: 'Error creating record',
                                                                message: error.body.message,
                                                                variant: 'error',
                                                        }),
                                    );
                });
        } 

        else{
            if(accName == ''){
                 this.isErrorMessage = true;
                 this.message="Account Name Required";
             }
             else if(accPhone == ''){
                 this.isErrorMessage = true;
                 this.message="Account Phone Number Required";
             }
             else{
                 this.isErrorMessage = true;
                 this.message="Account City Name Required";
             }
        }
    }

    // clear 
    handleClear(event){       
        this.template.querySelector('lightning-input[data-id=texName]').value = '';
        this.template.querySelector('lightning-input[data-id=texPhone]').value = '';
        this.template.querySelector('lightning-input[data-id=texBillingCity]').value = '';
        this.buttonIcon = true;
        this.isVisible = false;
        isErrorMessage = false;
        this.accountId = null;
    }

}