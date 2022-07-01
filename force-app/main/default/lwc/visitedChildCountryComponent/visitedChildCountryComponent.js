import { LightningElement } from 'lwc';
import { countries } from './utility/share.js';
export default class visitedChildCountryComponent extends LightningElement {
    count;
    countryName;
    countries = countries;

   handleClick(){
       this.count=0;
        this.countryName='';
       let checkboxes = this.template.querySelectorAll('lightning-input[data-id ="checkbox"]');
       //console.log('checkbox', checkboxes[0].checked);
           for(let i=0; i< checkboxes.length; i++){
               if(checkboxes[i].checked == true){
                this.countryName +=checkboxes[i].value + ' , ' ;
                   this.count++;           
               }
           }
     /*
       // Query the DOM
       const checked = Array.from(this.template.querySelectorAll('lightning-input'))
           // Filter down to checked items
           .filter(element => element.checked)
           // Map checked items to their labels
           .map(element => element.value);
           this.countryName = checked.join(', ');
           this.count=checked.length;
       */

       
       const selectEvent = new CustomEvent('myfirstcustomevent', {
           detail: {
               count:this.count, 
               countryName:this.countryName
           } 
       });
       this.dispatchEvent(selectEvent);
   }  
}