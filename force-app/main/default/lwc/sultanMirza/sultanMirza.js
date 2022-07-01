import { LightningElement,api,wire,track } from 'lwc';
//import getOpportunities from '@salesforce/apex/ChartOpportunityController.getOpportunities';

export default class ParentComponent extends LightningElement {

   @track aqsa;
   @track elisa;
   @track statusAqsa;
   @track statusElisa;

    
   aqsaName(event){
        this.aqsa = event.detail.aqsaMsg;
        this.statusAqsa = event.detail.statusAqsa
        console.log('aqsa', this.aqsa);
    }
    
    elisaName(event){
        this.elisa = event.detail.elisaMsg;
        this.statusElisa = event.detail.statusElisa
        console.log('elisa', this.elisa);
    }
}