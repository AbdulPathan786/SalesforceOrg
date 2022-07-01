import { LightningElement, api } from 'lwc';

export default class DaughterComponent extends LightningElement {
    @api daughterName;
    
    handleChange(){
        const name = this.template.querySelector('lightning-input[data-id=txt]').value;
    
        const custEvent = new CustomEvent('callpasstoparent', {detail: name });
        this.dispatchEvent(custEvent);
    }
}