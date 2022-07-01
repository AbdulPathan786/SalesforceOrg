import { LightningElement } from 'lwc';

export default class IbirdsFather extends LightningElement {
    fatherName = "Shah Rukh Khan";
    sonName = "AbRam Khan";
    daughterName = "Suhana Khan";

    messageSon;
    messageDaughter;

    flagURL  = "https://upload.wikimedia.org/wikipedia/commons/4/4d/Shahrukh_Khan_CE.jpg";
    sonToParent(event){
        this.messageSon = event.detail;
    }
    daughterToParent(event){
        this.messageDaughter = event.detail;
    }
}