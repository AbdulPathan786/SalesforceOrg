import { LightningElement, api } from 'lwc';
export default class IbirdsSon extends LightningElement {
    @api sonName;
    @api daughterMessage;

    flagURL = "http://www.pngpix.com/wp-content/uploads/2016/10/PNGPIX-COM-Shahrukh-Khan-PNG-Image.png";

    handleClick() {
        const messageSon = this.template.querySelector('lightning-input[data-id="son"]').value;

        const custEvent = new
            CustomEvent('callpasstoparentson', { detail: messageSon ,bubbles: true, composed: true}
            );
        this.dispatchEvent(custEvent);
    }

    /*  handleClickGrand() {
         const messageSon = this.template.querySelector('lightning-input[data-id="grand"]').value;
         const selectEvent = new CustomEvent('callpasstoparentgrand', { detail: messageSon , bubbles: true,});
         this.dispatchEvent(selectEvent);
     } */

}