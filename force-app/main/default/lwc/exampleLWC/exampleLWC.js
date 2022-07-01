import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

export default class WorkspaceAPILWC extends LightningElement {
    @api recordId;
    accountId;
    openAccountButtonDisabled = true;
   
    @wire(getRecord, { recordId: '$recordId', fields: ['Contact.AccountId']})
    getRecordAccount({ data }) {
      if (data) {
        console.log("data ", data);
        this.accountId = data.fields.AccountId.value;
        this.openAccountButtonDisabled = false;
      }
    }
    /* connectedCallback() {
        document.documentElement.setAttribute('lwc:dom', 'manual');
      } */
   
    onOpenAccountClick() {
      this.invokeWorkspaceAPI('isConsoleNavigation').then(isConsole => {
		  console.log('isConsole : ',isConsole);
        if (isConsole) {
          this.invokeWorkspaceAPI('getFocusedTabInfo').then(focusedTab => {
            console.log('focusedTab : ',focusedTab);
            this.invokeWorkspaceAPI('openSubtab', {
              parentTabId: focusedTab.tabId,
              recordId: this.accountId,
              focus: true
            }).then(tabId => {
              console.log("Solution #2 - SubTab ID: ", tabId);
            });
          });
        }
      });
    }
   
    invokeWorkspaceAPI(methodName, methodArgs) {
      console.log('methodName : ', methodName);
      console.log('methodArgs : ', methodArgs);
      return new Promise((resolve, reject) => {
        const apiEvent = new CustomEvent("internalapievent", {
          bubbles: true,
          composed: true,
          cancelable: false,
          detail: {
            category: "workspaceAPI",
            methodName: methodName,
            methodArgs: methodArgs,
            callback: (err, response) => {
              if (err) {
                  return reject(err);
              } else {
                  return resolve(response);
              }
            }
          }
        });
   
        window.dispatchEvent(apiEvent);
      });
    }
}