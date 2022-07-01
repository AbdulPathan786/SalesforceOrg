import { LightningElement, wire } from 'lwc';
import {fireEvent, registerListener, unregisterAllListeners} from 'c/pubSubComponent';
import playerRecords from '@salesforce/apex/PlayerController.playerRecords';
import {CurrentPageReference} from 'lightning/navigation';

export default class PlayerRecordList extends LightningElement {
    playerInfo;
    contryValue;
    player;
    error;
    
    // CurrentPageReference
    @wire (CurrentPageReference) pageRef;

    connectedCallback() {
        registerListener('sendSearchCountry', this.handelSearchCountry, this);
    }

    handelSearchCountry(parcel){
        const searchCountryName = parcel.countrySerachName; 
        playerRecords({countryName: searchCountryName})
        .then(result => {
            //console.log('result', result);
            if(result.length > 0){
                this.contryValue = result;
                this.error = null
            }
            else{
                this.error = result;
                this.contryValue = null;
            }
       
        })
        .catch(error => {
            console.log('Error : ', error);
        })
    }
    disconnectedCallback(){
        unregisterAllListeners(this);
    }

 
    showDetails(event){
        this.player = event.target.value;
       //console.log('showDetails player ', this.player );                                           

    fireEvent(this.pageRef, 'sendCountry', {'name': this.player} );
   }
}