import { LightningElement } from 'lwc';

export default class visitedCountryComponent extends LightningElement{
    
     totelCount;
     countryName;
 
    handleCustomEvent(event) {
        this.totelCount = event.detail.count;
        this.countryName = event.detail.countryName;
     }
}