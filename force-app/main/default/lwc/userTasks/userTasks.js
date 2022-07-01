import {LightningElement, wire, track, api} from 'lwc';
import {refreshApex} from '@salesforce/apex';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import getTasksList from '@salesforce/apex/UsersListController.fetchtasksList';
import createTasks from '@salesforce/apex/UsersListController.createTasks';
import updateTask from '@salesforce/apex/UsersListController.updateTask';
import deleteRecord from '@salesforce/apex/UsersListController.deleteTask';

export default class UserTasksList extends LightningElement {
    allTasks;
    @api userOwnerId;
    @track taskList;

    // Tasks List
    @wire(getTasksList, {ownerIdUser: '$userOwnerId'})
    tasksList(result) {
        this.allTasks = result;
        if (result.data) {
            this.taskList = JSON.parse(JSON.stringify(result.data));
            this.taskList.forEach(element => {
                if (element.Status == "Completed") {
                    element.showCheckbox = false;
                } else {
                    element.showCheckbox = true;
                }
            });
        } else if (result.error) {
            console.log('error#', result.error);
        }
    }

    // Create Tasks
    createTask() {
        const subject = this.template.querySelector('lightning-input[data-id ="subjectInput"]').value;
        if (subject) {
            createTasks({userId: this.userOwnerId, sub: subject })
                .then(task => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Task Insert Successfully',
                            variant: 'success',
                        }),
                    );
                    this.template.querySelector('lightning-input[data-id ="subjectInput"]').value = '';
                    return refreshApex(this.allTasks);
                })
                .catch(error => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error creating record',
                            message: error.body.message,
                            variant: 'error',
                        }),
                    );
                });
        }
    }

    // Update/completed Task
    updateTasks(event) {
        const taskIds = event.currentTarget.dataset.id;
        updateTask({
                taskId: taskIds
            })
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Task Completed',
                        variant: 'success'
                    })
                );
                return refreshApex(this.allTasks);
            })
            .catch(error => {
                console.log('error#', error);
            });
    }

    // Delete Task Records
    deleteTask(event) {
        const deleteRow = event.currentTarget.dataset.id;
        deleteRecord({ deleteId: deleteRow })
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Task Record is  Deleted',
                        variant: 'success',
                    }),
                );
                return refreshApex(this.allTasks);
            })
            .catch(error => {
                console.log('error#', error);
            });
    }

    // Cancel Button
    cancelButton() {
        this.dialogBox = false;
        const custEvent = new CustomEvent('cancelbuttonclick', {
            detail: this.dialogBox
        });
        this.dispatchEvent(custEvent);
    }
}