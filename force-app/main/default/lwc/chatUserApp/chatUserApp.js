import { LightningElement, wire } from 'lwc';
import userRecord from '@salesforce/apex/UserChatApplicationController.activeChatUsers';
import { fireEvent } from 'c/pubSubComponent';
import { CurrentPageReference } from 'lightning/navigation';
import { getRecord } from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';

export default class UserChatAppComp extends LightningElement {
    userId;

    // current user 
    @wire(getRecord, { recordId: USER_ID, fields: ['User.Name', 'User.MediumPhotoUrl'] })
    userData({ error, data }) {
        if (data) {
            // window.console.log('data ====> '+JSON.stringify(data));
            let objCurrentData = data.fields;
            this.objUser = {
                Name : objCurrentData.Name.value,
                MediumPhotoUrl: objCurrentData.MediumPhotoUrl.value,
            }
        }
        else if (error) {
            window.console.log('error ====> ' + JSON.stringify(error))
        }
    }

    // active user List chat
    @wire(userRecord)
    userRecs;

    //CurrentPageReference
    @wire(CurrentPageReference) pageRef;

    // handle click send user id
    handleClick(event) {
        let { id, name } = event.currentTarget.dataset;
        // console.log('useName', id, name);
        this.userId = id;
        fireEvent(this.pageRef, 'sendUserId', { 'userName': this.userId, name: name });
    }
}