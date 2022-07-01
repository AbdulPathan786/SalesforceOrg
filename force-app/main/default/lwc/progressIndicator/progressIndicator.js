import { LightningElement, track } from 'lwc';

export default class ProgressIndicator extends LightningElement {

    status1 = false;
    status2 = false;
    status3 = false;

    status11() {
        this.status1 = true;
        this.status2 = false;
        this.status3 = false;
        console.log('status11', this.template.querySelector('lightning-progress-step[data-id="step1"]').value);
    }
    status22() {
        this.status1 = false;
        this.status2 = true;
        this.status3 = false;
        console.log('status22', this.template.querySelector('lightning-progress-step[data-id="step2"]').value);
    }
    status33() {
        this.status1 = false;
        this.status2 = false;
        this.status3 = true;
        console.log('status33', this.template.querySelector('lightning-progress-step[data-id="step3"]').value);
    }
    
    status9(){
        this.status1 = false;
        this.status2 = false;
        this.status3 = false;
    }
}