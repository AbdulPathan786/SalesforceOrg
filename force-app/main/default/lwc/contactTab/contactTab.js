import { LightningElement, wire, api } from 'lwc';
import { contactColumns } from './utility/share.js';
import contactRecs from '@salesforce/apex/LwcContactRecs.contactRecs';
import labelContact from '@salesforce/label/c.Contacts';

export default class ContactTab extends LightningElement {

   contactColumns = contactColumns;

   contacts = labelContact;
   
   @wire(contactRecs) contactRecords;
}