import {LightningElement, api } from 'lwc';

export default class Users extends LightningElement {
    @api userList;
    @api status;

    //click icon then show Tasks List
    onClickTasks(event) {
        this.userOwnerId = event.target.value;
        const custEvent = new CustomEvent('clickicon', { detail: { userOwnerId : this.userOwnerId} });
        this.dispatchEvent(custEvent);
    }
}