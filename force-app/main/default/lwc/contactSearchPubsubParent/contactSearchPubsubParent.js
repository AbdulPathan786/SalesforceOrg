import { LightningElement, wire } from 'lwc';
import {cityList } from './utility/share.js';
import {fireEvent} from 'c/pubSubComponent';
import {CurrentPageReference} from 'lightning/navigation';


export default class SearchContactCityCombobox extends LightningElement {
    selectedCity;
    
    constructor(){
        super();
        this.selectedCity = 'All';
        this.cityOptions = cityList;
    }
    @wire (CurrentPageReference) pageRef;

    handleChange(event){
        this.selectedCity = event.target.value;
        console.log('handleChange', this.selectedCity);

        fireEvent(this.pageRef, 'sendSearchCity', {'cityName': this.selectedCity});
    }
}