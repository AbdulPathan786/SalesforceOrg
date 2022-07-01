import { LightningElement, track, wire} from 'lwc';
import getUserList from '@salesforce/apex/UsersListController.fetchUserList';
import {refreshApex} from '@salesforce/apex';

export default class UsersList extends LightningElement {
  
  allUsers;
  userList;
  @track userRecords;
  ownerId;
  openDialBox;
  isUserRecord = true; // bealean
  //user Records
  @wire(getUserList)
  userRecs(result){
    this.allUsers = result;
    if (result.data) {
        this.userList = result.data;
        this.userRecords = result.data;
    }else if (result.error){
      console.log('error#', result.error);
    }
  }

  //handleChange
  handleChange() {
    const searchUserName = this.template.querySelector('lightning-input[data-id ="userInput"]').value;
    this.userRecords = this.userList.filter((obj) => obj.objUser.Name.toLowerCase().includes(searchUserName.toLowerCase()));
    if(this.userRecords.length > 0 ){
      this.isUserRecord = true;
    }else{
      this.isUserRecord = false;
    }
  }

  //sendUserOwnerId
  sendUserOwnerId(event){
      this.openDialBox = true;
      this.ownerId = event.detail.userOwnerId;
  }
  //closeDialogBox
  closeDialogBox(event){
    this.openDialBox = false;
    refreshApex(this.allUsers);
  } 

}