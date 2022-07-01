import { LightningElement } from 'lwc';

export default class RouteDistancePath extends LightningElement {
    handleChange(event){
        console.log('handleChange',event.target.value);
    }
}