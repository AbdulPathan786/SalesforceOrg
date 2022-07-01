import {LightningElement, track, wire} from 'lwc';
import {refreshApex} from '@salesforce/apex';
import getUserList from '@salesforce/apex/UsersListController.fetchUserList';

export default class UserRecords extends LightningElement {
    allUsers;
    userList;
    @track userRecords;
    isStatus = true; // boolean
    dialogBox; // boolean
    userOwnerId;

    // user Records
    @wire(getUserList)
    userRecs(result) {
        this.allUsers = result;
        if (result.data) {
            this.userList = result.data;
            this.userRecords = result.data;
        } else if (result.error) {
            console.log('error#', result.error);
        }
    }

    // Search User Records
    handleChange(event) {
        const searchUserName = event.detail.value;
        //const searchUserName = this.template.querySelector('lightning-input[data-id ="userInput"]').value;
        this.userRecords = this.userList.filter((obj) => obj.objUser.Name.toLowerCase().includes(searchUserName.toLowerCase()));
        if (this.userRecords.length > 0) {
            this.isStatus = true;
        } else {
            this.isStatus = false;
        }
    }

    // click icon then show Tasks List
    onClickTasks(event) {
        this.dialogBox = true;
        this.userOwnerId = event.target.value;
        /* this.userTasks = this.userRecords.filter(obj => obj.objUser.Id.toLowerCase().includes(this.userOwnerId.toLowerCase()));
        if (this.userTasks) {
            this.taskList = this.userTasks[0].tasks;
        } */
    }

    // closeDialogBox
    closeDialogBox(event) {
        this.dialogBox = event.detail;
        refreshApex(this.allUsers);
    }
}