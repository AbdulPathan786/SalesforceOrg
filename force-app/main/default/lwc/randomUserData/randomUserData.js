import { LightningElement,track } from 'lwc';
import getUserData from "@salesforce/apex/RandomUserData.getUserData";

export default class RandomUserData extends LightningElement {
    @track userData;
    picture;
    name;
    email;
    phone;
    age;

  connectedCallback() {
    getUserData()
      .then((result) => {
        this.userData = JSON.parse(JSON.stringify(result.results[0]));
        this.picture = this.userData.picture.large;
        this.email = this.userData.email;
        this.phone = this.userData.phone;
        this.name = this.userData.name.first + " " + this.userData.name.last;
        this.age = this.userData.dob.age;
        //console.log("🚀 ~ result", this.userData.picture.large);
      })
      .catch((error) => {
        console.log("===>>Error during callout : " + JSON.stringify(error));
      });
  }
}