import { LightningElement, api } from 'lwc';

export default class SonComponent extends LightningElement {
    @api sonName;
    @api message ;
   
}