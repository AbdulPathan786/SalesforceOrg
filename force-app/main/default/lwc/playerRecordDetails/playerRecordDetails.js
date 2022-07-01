import { LightningElement, wire } from 'lwc';
import playerDetails from '@salesforce/apex/PlayerController.playerDetails';
import {registerListener, unregisterAllListeners} from 'c/pubSubComponent';
import {CurrentPageReference} from 'lightning/navigation';

export default class PlayerRecordDetails extends LightningElement {
    playerInfo;
    modalOpen;

    @wire (CurrentPageReference) pageRef;

    connectedCallback() {
        registerListener('sendCountry', this.handelSearchCountry, this);
    }

    handelSearchCountry(parcel){
        this.modalOpen = true;
        const searchCName = parcel.name;
        console.log('searchCName', searchCName); 

        playerDetails( { playerId : searchCName  } )
                       .then( result =>{ this.playerInfo = result; } )
                       .catch( error =>{ console.log('error ', error); } )
    }
    disconnectedCallback(){
        unregisterAllListeners(this);
    }

    closeModal(){
        this.modalOpen = false;
    }

}