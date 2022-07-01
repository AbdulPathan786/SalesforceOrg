import { LightningElement, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import contactTaskRecs from '@salesforce/apex/ContactTaskRecordsController.contactRecords';
import createTaskRecord from '@salesforce/apex/ContactTaskRecordsController.createTaskRecords';
import deleteRecord from '@salesforce/apex/ContactTaskRecordsController.deleteTaskRecord';
import updateTaskRecords from '@salesforce/apex/ContactTaskRecordsController.updateTaskRecords';

export default class ContactTaskRecords extends LightningElement {
    searchContactRecs
    contactId;
    contactTaskList;
    taskRecords;
    isVisible;
    logo;
    @track contactRecords;
    @track allContact;
    constructor() {
        super();
        this.isVisible = false;
        this.contactRecords = [];
        this.logo = '';
    }

    @wire(contactTaskRecs)
    contactList(res) {
        this.allContact = res;
        if (res.data) {
            this.contactRecords = res.data;
            this.handleClick();
        }
        else if (res.error) {
            console.log('error#', res.error);
        }
    }

    // Search Contacts Records by Name
    handleClick() {
        let searchName = this.template.querySelector('lightning-input[data-id ="userInput"]').value;
        this.searchContactRecs = this.contactRecords.filter(obj => obj.objContact.Name.toLowerCase().includes(searchName.toLowerCase()));
    }
    // handleTaskRecords
    handleTaskRecords(event) {
        this.isVisible = true;
        this.contactId = event.target.value;
        this.contactTaskList = this.contactRecords.filter(obj => obj.objContact.Id.toLowerCase().includes(this.contactId.toLowerCase()));
        if (this.contactTaskList) {
            this.taskRecords = this.contactTaskList[0].tasks;
        }
    }

    // Create Task Records
    handleSave() {
        const description = this.template.querySelector('lightning-input[data-id="description"]').value;
        if (description) {
            createTaskRecord({ contactRecId: this.contactId, description: description })
                .then(result => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Task Insert Successfully',
                            variant: 'success',
                        }),
                    );
                    let taskData = [...this.taskRecords];
                    taskData.push({ Id: this.contactId, Description: description });
                    this.taskRecords = [...taskData];
                })
                .catch(error => {
                    console.log('error#', error);
                });
        }
    }

    // Delete Task Records
    deleteTask(event) {
        const taskId = event.currentTarget.dataset.id;
        const index = event.currentTarget.dataset.index;
        deleteRecord({ deleteId: taskId })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Task Record deleted',
                        variant: 'success'
                    })
                );
                let taskData = [...this.taskRecords];
                taskData.splice(index, 1);
                this.taskRecords = [...taskData];
            })
            .catch(error => {
                console.log('error#', error);
            });
    }
    // Task Record Completed
    completedTaskRecord(event) {
        const taskRecordId = event.currentTarget.dataset.id;
        updateTaskRecords({ taskId: taskRecordId})
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Task Record Completed',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                console.log('error#', error);
            });
    }


    // cancel Button
    cancelButton() {
        refreshApex(this.allContact);
        this.isVisible = false;
    }
}