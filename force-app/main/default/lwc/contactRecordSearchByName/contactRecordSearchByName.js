import { LightningElement, track, wire } from 'lwc';
import { columns } from './utility/share.js';
import contactSearchRecord from '@salesforce/apex/LwcContactRecs.ContactRecords';
export default class ContactRecordSearchByName extends LightningElement {
    @track error;
    columns;
    ListOfContactRecords;
    isStatus;

    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;

    //======================= Constructor===============================
    constructor() {
        super();
        this.columns = columns;
        this.ListOfContactRecords = [];
    }


    //============================== Serach for Contact Record Start============================
    searchForContactRecord(event) {
        let searchValue = this.template.querySelector('lightning-input[data-id ="searchInput"]').value;
        if (searchValue != '') {
            contactSearchRecord({ SearchContactName: searchValue, SearchContactCity: searchValue } )
                .then(result => {
                    this.isStatus = true;
                    this.ListOfContactRecords = JSON.parse(JSON.stringify(result));

                    if(this.ListOfContactRecords.length > 0){
                        this.isStatus = true;
                    }
                    else if(this.ListOfContactRecords.length == 0){
                        this.isStatus = false;
                    }
                })
                .catch(error => {
                    console.log('#error', error);
                })
        } else {
            this.isStatus = false;
        }
    }

    //==================== Used to sorting start the 'Name' column===================================
    sortBy(field, reverse, primer) {
        const key = primer
            ? function (x) {
                return primer(x[field]);
            }
            : function (x) {
                return x[field];
            };
        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }
    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.ListOfContactRecords];
        //console.log('this.columnsData', cloneData);
        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.ListOfContactRecords = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }
    // ========================= Sorting End========================

}