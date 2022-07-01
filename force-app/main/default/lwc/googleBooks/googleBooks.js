import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import getLatestBooks from '@salesforce/apex/GoogleBooksCallouts.getGoogleBooks';
import searchBookName from '@salesforce/apex/GoogleBooksCallouts.searchBooks';
import insertBooks from '@salesforce/apex/GoogleBooksCallouts.insertBooks';
import removedBooks from '@salesforce/apex/GoogleBooksCallouts.deleteBooks';

export default class GoogleBooks extends LightningElement {
    @track googleBookList;
    @track wiredGooglebookList= [];
    @track itemsDetails;
    isStatus = false;
    @track bookDetails;
    @track lstOptions = [];
    @track visibleItems;

    //show all books list
    @wire(getLatestBooks)
        bookList(result){
            this.wiredGooglebookList = result;
            if (result.data) {
                this.googleBookList = JSON.parse(JSON.stringify(result.data));
                this.itemsDetails = JSON.parse(JSON.stringify(this.googleBookList.items));
                //console.log('total data1',JSON.parse(JSON.stringify(this.itemsDetails)));
            }else if (result.error) {
                console.log('error#', result.error);
            }
        }

    //addNewBook Open Model
    addNewBook(event){
        this.isStatus = true;
        this.lstOptions = [];
    }

    //search books
    onSubmit(){
        var searchName = this.template.querySelector('lightning-input[data-id ="bookId"]').value;
        if(searchName){
            searchBookName({bookId: searchName})
            .then(result => {
                this.bookDetails = JSON.parse(JSON.stringify(result));
                this.bookDetails.items.forEach( objPicklist => {
                    this.lstOptions.push({
                        label: objPicklist.volumeInfo.title,
                        value: objPicklist.id
                    });
                });
            })
            .catch(error => {
                console.log('error#', error);
            });
        }
    }
    //Radio button value
    handleClickRadioButton(event){
        const volumeIdValue = event.target.value;
    }

    cancelButton(){
        refreshApex(this.wiredGooglebookList);
        this.isStatus = false;
    }
    
    updateContactHandler(event){
        this.visibleItems=[...event.detail.records]
        //console.log('event.detail.records',event.detail.records)
    }
    //Books Insert
    insertNewBook(){
        const volumeIdValue =this.template.querySelector('lightning-radio-group[data-id ="newbookId"]').value;
        if(volumeIdValue){
            insertBooks({volumeId: volumeIdValue})
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Book Insert Successfully',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                console.log('error#', error);
            });
        }
    }
    //Books Delete
    bookDelete(event){
        const volumeIdValue = event.target.value;
        if(volumeIdValue){
            removedBooks({volumeId: volumeIdValue})
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Book delete Successfully',
                        variant: 'success',
                    }),
                );
                refreshApex(this.wiredGooglebookList);
            })
            .catch(error => {
                console.log('error#', error);
            });
        }
    }
}