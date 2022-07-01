import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ChildSherani extends LightningElement {
    @api aqsa;
    @track msg;
    @track statusElisa
    @api statusAqsa
    // send to parent message (Child to parent message send)
    handleSendMessage() {
        this.msg = this.template.querySelector('lightning-input[data-id="textId"]').value;
        if (this.msg) {
            this.statusElisa = true;
            const custEvent = new CustomEvent('elisa', { detail: { elisaMsg: this.msg, statusElisa: this.statusElisa } });
            this.dispatchEvent(custEvent);
            const event =
                new ShowToastEvent({
                    title: 'Elisa',
                    message: 'Send to message Aqsa',
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