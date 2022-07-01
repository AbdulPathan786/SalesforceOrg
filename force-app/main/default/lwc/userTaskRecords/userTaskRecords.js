import { LightningElement, wire } from 'lwc';

import {columns} from './utility/share.js';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import deleteRecord from '@salesforce/apex/UserTaskRecordsController.deleteTaskRecord';
import createTaskRecord from '@salesforce/apex/UserTaskRecordsController.createTaskRecords';
import userTaskRecordList from '@salesforce/apex/UserTaskRecordsController.userTaskRecordList';
import taskRecsList from '@salesforce/apex/UserTaskRecordsController.taskRecords';



export default class UserTaskRecords extends LightningElement {
    columns;
    userTaskRec;
    filterUserRec;
    searchUserRec;
    wiredTasksRec;
    taskRecList;
    dialogOpenbox;
    userOwnerId;
    isUserRecord;
    // constructor
    constructor(){
        super();
        this.columns = columns;
        this.userTaskRec=[];
        this.searchUserRec='';
        this.filterUserRec = [];
        this.taskRecList = [];
       this.wiredTasksRec = [];
       this.dialogOpenbox=false;
       this.isUserRecord = true;
    }
    //  userTask Record display
    @wire(userTaskRecordList)
    wiredUserTask({data,error}){
        if(data){
            this.userTaskRec = data;
        }else if(error){
            console.log('error#', error);
        }
        return refreshApex(this.userTaskRec);
    }
    // search User Records
    handleClick(){
        this.isUserRecord = true;
        this.searchUserRec = this.template.querySelector('lightning-input[data-id ="userInput"]').value;
        this.filterUserRec = this.userTaskRec.filter(obj => obj.objUser.Name.toLowerCase().includes(this.searchUserRec.toLowerCase()));
        if(this.filterUserRec.length > 0 ){
            this.isUserRecord = true;
        }
        else{
            this.isUserRecord = false;
        }
    }

    //  Task Record List Show
     @wire(taskRecsList, {ownerIdUser : '$userOwnerId'}) 
     wiredTasksMehods(result){
         this.wiredTasksRec = result;
        if(result.data){
            this.taskRecList = result.data;
        }else if(result.error){
            console.log('error#', result.error);
        }
     }
     
    //  Task Record List Show
    handleTaskRecords(event){
        this.dialogOpenbox = true;
        this.userOwnerId = event.target.value;
    }
    // Save Task Record
    handleSave(){
        const sub = this.template.querySelector('lightning-input[data-id="subject"]').value;
       if(sub){     
            createTaskRecord({userId : this.userOwnerId, subRec : sub })
            .then(task => {
                this.dispatchEvent( 
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'User Task Insert Successfully',
                        variant: 'success',
                    }),
                );                                   
                return refreshApex(this.wiredTasksRec);
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
    // delete Task Record
    handleRowAction(event){
        const deleteRow = event.detail.row.Id;
        deleteRecord({ deleteId : deleteRow})
        .then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Task Record is  Deleted',
                    variant: 'success',
                }),
            );
            this.template.querySelector('lightning-datatable').deleteRow= [];
            return refreshApex(this.wiredTasksRec);
        })
        .catch(error => {
           console.log('error#', error);
        });
    }
    cancelButton(){
        this.dialogOpenbox = false;
    }




    
}