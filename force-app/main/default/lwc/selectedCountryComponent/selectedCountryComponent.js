import { LightningElement, track, api } from 'lwc';

export default class selectedCountryComponent extends LightningElement {
    selectCountry;
    value = '';

    constructor(){
        super();
        this.selectCountry="Select Country";
    }
   get options() {
        return [
            { label: 'Select Country', value: '' },
            { label: 'India', value: 'India' },
            { label: 'Pakisthan', value: 'Pakisthan' },
            { label: 'Afganistan', value: 'Afganistan' },
            { label: 'Bangladesh', value: 'Bangledesh' },
        ];
    }

    handleChange(){
       this.selectCountry= this.template.querySelector('lightning-combobox[data-id="first"]').value;
    }
}