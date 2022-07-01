import {LightningElement, track, wire, api } from 'lwc';
import {refreshApex} from '@salesforce/apex';
import getUserList from '@salesforce/apex/UsersListController.fetchUserList';

export default class Users extends LightningElement {
    @api userName;
    
    allUsers;
    userList;
    @track userRecords;
    isStatus = true; // boolean
    dialogBox; // boolean
    userOwnerId;
    searchUserName;//user search

    // user Records
    @wire(getUserList, { userName: '$userName' })
    userRecs(result){
        this.allUsers = result;
        if (result.data) {
            this.userList = result.data[0];
            this.userRecords = result.data[0];
            console.log('userRecords',this.userRecords);
        } else if (result.error) {
            console.log('error#', result.error);
        }
    }

// Search User Records
     @api childFunction(){  
        refreshApex(this.allUsers);
       /*  this.searchUserName = userName;
            if(this.searchUserName){
                this.userRecords = this.userList.filter((obj) => obj.objUser.Name.toLowerCase().includes(this.searchUserName.toLowerCase()));
                  if (this.userRecords.length > 0) {
                     this.isStatus = true;
                 } else {
                     this.isStatus = false;
                 } 
            } */
    }   

    // click icon then show Tasks List
    onClickTasks(event) {
        this.dialogBox = true;
        this.userOwnerId = event.target.value;
        const custEvent = new CustomEvent('clickicon', { detail: { userOwnerId : this.userOwnerId, dialogBox: this.dialogBox} });
        this.dispatchEvent(custEvent);
    }

  /*   // closeDialogBox
    closeDialogBox(event) {
        this.dialogBox = event.detail;
        refreshApex(this.allUsers);
    } */
}