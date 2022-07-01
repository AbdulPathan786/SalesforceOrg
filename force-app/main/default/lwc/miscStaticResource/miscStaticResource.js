import { LightningElement } from 'lwc';
import Abdul_Pathan from '@salesforce/resourceUrl/abdulpathan';
import Imtiyaz_Pathan from '@salesforce/resourceUrl/tahir';
//import TRAILHEAD_CHARACTERS from '@salesforce/resourceUrl/lwcImage';

export default class MiscStaticResource extends LightningElement {
    abdulImage = Abdul_Pathan ;
      // Expose the static resource URL for use in the template
      tahirImage = Imtiyaz_Pathan;
      // Expose URL of assets included inside an archive file
     // einsteinUrl = TRAILHEAD_CHARACTERS ;
     

}