import { LightningElement, wire } from 'lwc';
import { columns } from './utility/share.js';
import contactRecsList from '@salesforce/apex/LwcContactRecs.contactList';
import contactCity from '@salesforce/apex/LwcContactRecs.contactCities';
    let i=0;
export default class SearchContactRecordPickList extends LightningElement {
    columns= columns;
    value= 'All';
    contacts;
    error;
    items= [];
  //  contactList  = [];
    //contactList;
    searchValue='All';
    allRecords;

    @wire(contactRecsList, {cName: '$searchValue'})lstcontactList;
       
    /*
        // contactRecordList data show in table form start
        @wire(contactRecordList, {cName: '$searchValue'})
        wiredContacts({ error, data }) {
            if (data) {
                this.contactList = data;
                this.allRecords = data;
            }
        }
        // contactRecordList data show in table form end
        */

         //pickListValue lightning combobox show start Method
         @wire(contactCity)
         wiredContactRecord({ error, data }) {
             if (data) {
                this.items = [{label: 'All Cities', value: 'All' }]
                 for(i=0; i<data.length; i++) {
                 // console.log('id=' + data[i]);
                     this.items = [...this.items ,{value: data[i], label: data[i]}];                                   
                 }  
             // console.log('items', JSON.stringify(this.items));
                 this.contacts = data;
             }
             else if (error) {
                 console.log(error);
                 this.error = error;
             }
         }
         get cityOptions() {
             return this.items;
         }
         //pickListValue lightning combobox show End Method
 
        handleChange(event) {
            this.searchValue = event.detail.value;
           // this.contactList = this.allRecords.filter(conRec => conRec.MailingCity.toLowerCase().includes(this.searchValue.toLowerCase()));
        }
}