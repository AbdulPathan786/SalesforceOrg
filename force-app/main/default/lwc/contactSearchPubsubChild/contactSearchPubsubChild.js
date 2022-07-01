import { LightningElement, wire } from 'lwc';
import {columns } from './utility/share.js';
import {registerListener, unregisterAllListeners} from 'c/pubSubComponent';
import {CurrentPageReference} from 'lightning/navigation';
import ContactCityRecords from '@salesforce/apex/LwcContactRecs.ContactSearchCityRecords';

export default class SearchContactCityRecord extends LightningElement {
    contacts;
    columns;
    selectedCity;
    
    constructor(){
        super()
        this.selectedCity = "All"
        this.columns = columns;
    }

    //@wire(ContactCityRecords)lstContacts;

    @wire (CurrentPageReference) pageRef;

    connectedCallback() {
        registerListener('sendSearchCity', this.handelSearchCity, this);
    }

    handelSearchCity(parcel){
        const searchCityName = parcel.cityName; 
       ContactCityRecords({cName: searchCityName})
        .then(result => {
            this.contacts = result;
        })
        .catch(error => {
            console.log('Error : ', error);
        })
    }
    disconnectedCallback(){
        unregisterAllListeners(this);
    }
        
}