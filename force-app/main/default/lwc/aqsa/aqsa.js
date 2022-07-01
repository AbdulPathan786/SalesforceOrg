import { LightningElement, track, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ChildSherani extends LightningElement {

    @track msg;
    @api elisa;
    @track statusAqsa;
    @api statusElisa;

    // send to parent message (Child to parent message send)
    handleSendMessage() {
        this.msg = this.template.querySelector('lightning-input[data-id="textId"]').value;
        if (this.msg) {
            this.statusAqsa = true;
            const custEvent = new CustomEvent('aqsa', { detail: { aqsaMsg: this.msg, statusAqsa: this.statusAqsa } });
            this.dispatchEvent(custEvent);
            const event =
                new ShowToastEvent({
                    title: 'Aqsa',
                    message: 'Send to message Elisa',
                    variant: 'success',
                    mode: 'dismissable'
                });
            this.dispatchEvent(event);
            this.template.querySelector('lightning-input[data-id="textId"]').value = '';
        }
        else {
            // The form is not valid
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Something is wrong',
                    message: 'Check your input and try again.',
                    variant: 'error'
                })
            );
        }
    }

}