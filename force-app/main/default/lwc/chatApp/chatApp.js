import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import createRecords from '@salesforce/apex/UserChatApplicationController.createRecords';
import chatMsg from '@salesforce/apex/UserChatApplicationController.userChatMessages';
import { registerListener, unregisterAllListeners } from 'c/pubSubComponent';
import { CurrentPageReference } from 'lightning/navigation';
export default class UserChatChildComp extends LightningElement {
    messsage;
    userRecordId;
    userName;

    wiredUserRec;
    allChat;

    // handle Click send user Id
    handleSendMessage() {
        this.messsage = this.template.querySelector('lightning-input[data-id="textId"]').value;
        if (this.messsage) {
            let input = {
                userId: this.userRecordId,
                message: this.messsage,
                date: new Date(),
                type: 'Send'
            }
            createRecords({ userId: this.userRecordId, input: JSON.stringify(input) })
                .then(result => {
                    return refreshApex(this.wiredUserRec);
                })
                .catch(error => {
                    console.log('error#', error);
                });
        }
        this.template.querySelector('lightning-input[data-id="textId"]').value = '';
    }

    // CurrentPageReference
    @wire(CurrentPageReference) pageRef;

    connectedCallback() {
        registerListener('sendUserId', this.handelUserName, this);
    }

    handelUserName(parcel) {
        this.userRecordId = parcel.userName;
        this.userName = parcel.name;
    }

    disconnectedCallback() {
        unregisterAllListeners(this);
    }

    // Chat Details Show
    @wire(chatMsg, { userId: '$userRecordId' })
    wiredMehods(result) {
        this.wiredUserRec = result;
        if (result.data) {
            let mappedArray;
            if (result.data.length > 0) {
                let userChatList = result.data;
                userChatList.forEach(chat => {
                    this.allChat = JSON.parse('[' + chat.Content__c + ']');
                    mappedArray = this.allChat.map(item => {
                        const copy = Object.assign({}, item);
                        copy.isMyChat = (copy.userId == this.userRecordId)
                        return copy;
                    });
                });
                this.allChat = mappedArray;
            } else {
                this.allChat = [];
            }
        }
        else if (result.error) {
            console.log('error#', result.error);
        }
    }
}