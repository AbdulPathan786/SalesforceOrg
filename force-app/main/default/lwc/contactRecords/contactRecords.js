import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import contactRecordList from '@salesforce/apex/LwcContactController.getcontactRecords';
import createContactRecords from '@salesforce/apex/LwcContactController.createContactRecords';
export default class ContactRecords extends LightningElement {
    isModel;
    contactRecords;
    wiredContactRec;

    // Contact Records
    @wire(contactRecordList)
    wiredTasksMehods(result) {
        this.wiredContactRec = result;
        if (result.data) {
            this.contactRecords = result.data;
        } else if (result.error) {
            console.log('error#', result.error);
        }
    }
    // Create Contact Record Method
    saveRecords(event) {
        const firstName = this.template.querySelector('lightning-input[data-id="firstName"]').value;
        const lastName = this.template.querySelector('lightning-input[data-id="lastName"]').value;
        const email = this.template.querySelector('lightning-input[data-id="email"]').value;
      // let emaila = this.template.querySelector('lightning-input[data-id="email"]').value;
        const phone = this.template.querySelector('lightning-input[data-id="phone"]').value;
        const mailingCity = this.template.querySelector('lightning-input[data-id="city"]').value;
       /*  let searchCmp = this.template.querySelector(".nameCmp");
        let searchvalue = searchCmp.value;
        //let email = email.value;

        if (!email) {
            emaila.setCustomValidity("Name value is required");
            console.log('dsfds',email);
        } 
        emaila.reportValidity(); */
//=====
        if(lastName) {
            createContactRecords({ firstName: firstName, lastName: lastName, email: email, phone: phone, city: mailingCity })
                .then(result => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Contact Records Insert Successfully',
                            variant: 'success',
                        }),
                    );
                    return refreshApex(this.wiredContactRec);
                })
                .catch(error => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Records Insertion failled',
                            message: error.body.fieldErrors.Email[0].message,
                            variant: 'error',
                        }),
                    );
                });
        } else {
             this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Records Insertion failled',
                    message: 'Please enter Last Name',
                    variant: 'error',
                }),
            ); 
        }
    }
    // refresh 
    refresh() {
        this.template.querySelector('lightning-input[data-id="firstName"]').value = '';
        this.template.querySelector('lightning-input[data-id="lastName"]').value = '';
        this.template.querySelector('lightning-input[data-id="email"]').value = '';
        this.template.querySelector('lightning-input[data-id="phone"]').value = '';
        this.template.querySelector('lightning-input[data-id="city"]').value = '';
    }

    //=============Standard functionallty===========
    handleClick(event) {
        this.isModel = true;
    }
    closeModel(event) {
        this.isModel = false;
    }
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
    }
}