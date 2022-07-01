import { LightningElement, wire } from 'lwc';
import playerRecords from '@salesforce/apex/PlayerController.playerRecords';
import playerDetails from '@salesforce/apex/PlayerController.playerDetails';

export default class PlayersList extends LightningElement {
    //playerList;
    playerInfo;
    searchCountry = '';
    modalOpen = false;

    @wire( playerRecords, { countryName : '$searchCountry' } )lstPlayers;
    // Searching 
    handleChange(event){
        this.searchCountry = this.template.querySelector('lightning-input[data-id=txt]').value;   
    }

    // Player Details Show 
    showDetails(event){
        this.modalOpen = true;
        const player = event.target.value;
       console.log('player ', player );
       playerDetails( { playerId : player  } )
                       .then( result =>{ this.playerInfo = result; } )
                       .catch( error =>{ console.log('error ', error); } )
   }

    closeModal(){
        this.modalOpen = false;
    }
    
}