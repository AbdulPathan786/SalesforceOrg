import { LightningElement, api } from 'lwc';

export default class IbirdsDaughter extends LightningElement {
    @api daughterName;
    @api sonMessage;

    flagURL = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7nlOqwsiqnm7i6pD7KyJcE-8-tbuxFht_rw&usqp=CAU";

    handleClick() {
        const messageDaughter = this.template.querySelector('lightning-input[data-id="daughter"]').value;

        const custEvent = new CustomEvent('callpasstoparentdaughter', { detail: messageDaughter });
        this.dispatchEvent(custEvent);
    }
}