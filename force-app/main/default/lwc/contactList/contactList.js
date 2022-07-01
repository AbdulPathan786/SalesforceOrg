import { LightningElement, wire } from 'lwc';
//import { reduceErrors } from 'c/ldsUtils';
import NAME_FIELD from '@salesforce/schema/Contact.Email';
import REVENUE_FIELD from '@salesforce/schema/Contact.FirstName';
import INDUSTRY_FIELD from '@salesforce/schema/Contact.LastName';
import getContacts from '@salesforce/apex/ContactController.getContacts';
const COLUMNS = [
    { label: 'FirstName', fieldName: NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'LastName', fieldName: REVENUE_FIELD.fieldApiName, type: 'currency' },
    { label: 'Email', fieldName: INDUSTRY_FIELD.fieldApiName, type: 'text' }
];
export default class ContactList extends LightningElement {

    columns = COLUMNS;
    @wire(getContacts)
    accounts;

  /*   get errors() {
        console.log('this.contacts.error: ', this.contacts.error);
        return (this.contacts.error) ? reduceErrors(this.contacts.error) : [];
    } */
}