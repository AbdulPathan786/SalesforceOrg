import { LightningElement, track } from 'lwc';

export default class IbirdsGrandFather extends LightningElement {
    @track messageSon

    sonToGrandParent(event){
        console.log('message son to gran father1');
        this.messageSon = event.detail;
        console.log('message son to gran father', this.messageSon);
    }
}