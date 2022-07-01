import { LightningElement, wire } from 'lwc';
import {fireEvent} from 'c/pubSubComponent';
import {CurrentPageReference} from 'lightning/navigation';


export default class PlayerSearchInputBox extends LightningElement {
    searchCountry = '';
    
    //CurrentPageReference
    @wire (CurrentPageReference) pageRef;


    // Searching 
    handleClick(event){
        this.searchCountry = this.template.querySelector('lightning-input[data-id=txt]').value;  
        console.log('Search Country', this.searchCountry);


        fireEvent(this.pageRef, 'sendSearchCountry', {'countrySerachName': this.searchCountry});
    }
}