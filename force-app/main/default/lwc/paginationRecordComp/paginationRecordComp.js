import { LightningElement,api } from 'lwc';
import { columns } from './utility/share.js';
import contactListRec from '@salesforce/apex/LwcContactRecs.contactRecList';
import contactCountRec from '@salesforce/apex/LwcContactRecs.contactRecCount';
export default class PaginationRecordComp extends LightningElement {
  defaultSortDirection = 'asc';
  sortDirection = 'asc';
  sortedBy;
  contactRecs;  
  error;  
  @api currentpage;  
  @api pagesize;  
  searchKey;  
  totalpages;
  columns = columns;
  localCurrentPage = null;  
  isSearchChangeExecuted = false;  
  isContactRecs;
  // not yet implemented  
  pageSizeOptions =[  
                      { label: '5', value: 5 },  
                      { label: '10', value: 10 },  
                      { label: '25', value: 25 },  
                      { label: '50', value: 50 },  
                      { label: 'All', value: '' },  
                ];
  handleKeyChange(event) { 
    if (this.searchKey !== event.target.value) {  
      this.isSearchChangeExecuted = false;  
      this.searchKey = event.target.value;  
      this.currentpage = 1;  
    }  
  }
  renderedCallback() {  
    // This line added to avoid duplicate/multiple executions of this code.  
    if (this.isSearchChangeExecuted && (this.localCurrentPage === this.currentpage)) {  
      return;  
    }  
    this.isSearchChangeExecuted = true;  
    this.localCurrentPage = this.currentpage;  
    contactCountRec({ searchString: this.searchKey })  // contactCountRec
    .then(recordsCount => {  
      this.totalrecords = recordsCount; 
      //console.log('totalrecords', this.totalrecords) ;
      if (recordsCount !== 0 && !isNaN(recordsCount)) {  
        this.totalpages = Math.ceil(recordsCount / this.pagesize);  
        contactListRec({ pagenumber: this.currentpage, numberOfRecords: recordsCount, pageSize: this.pagesize, searchString: this.searchKey })  
          .then(result => { 
            this.contactRecs = result;  
            this.error = undefined;  
            if(this.contactRecs.length > 0 ){
              this.isContactRecs = true;
          }
          else{
              this.isContactRecs = false;
          }
          })  
          .catch(error => {  
            this.error = error;  
            this.contactRecs = undefined; 
            console.log('error#', this.error); 
          });  
      }
      else {  
        this.contactRecs = [];  
        this.totalpages = 1;  
        this.totalrecords = 0;  
      }  
      const event = new CustomEvent('recordsload', { detail: recordsCount });  
      this.dispatchEvent(event);  
    })  
    .catch(error => {  
      this.error = error;  
      this.totalrecords = undefined;  
    });  
  }
  // Used to sort the 'Age' column Sorting start
  sortBy(field, reverse, primer) {
    const key = primer
        ? function(x) {
              return primer(x[field]);
          }
        : function(x) {
              return x[field];
          };

    return function(a, b) {
        a = key(a);
        b = key(b);
        return reverse * ((a > b) - (b > a));
    };
  }
  onHandleSort(event) {
    const { fieldName: sortedBy, sortDirection } = event.detail;
    const cloneData = [...this.contactRecs];

    cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
    this.contactRecs = cloneData;
    this.sortDirection = sortDirection;
    this.sortedBy = sortedBy;
  }
  // sorting close
    
}