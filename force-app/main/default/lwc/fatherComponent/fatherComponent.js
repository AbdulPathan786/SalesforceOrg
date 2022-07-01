import { LightningElement } from 'lwc';

export default class FatherComponent extends LightningElement {
    fatherName;
    sonName;
    daughterName ;
    messageSend;

    constructor(){
        super();
        this.message = '';
        this.fatherName = "Father : Paul Johnson";
        this.sonName = "Son : Micheal";
        this.daughterName = "Daughter : Ruby";
    }

    passToParent(event){
        this.messageSend = event.detail;
    }
}