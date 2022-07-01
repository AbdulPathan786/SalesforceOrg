import { LightningElement,wire,track } from 'lwc';
import retriveNews from "@salesforce/apex/NewsAPIsCallOuts.retriveNews";
export default class NewsAPIsCallOuts extends LightningElement {
    wiredNewsList;
    newsList;
    @track articles;
    @wire(retriveNews)
        news(result){
            this.wiredNewsList = result;
            if (result.data) {
                this.newsList = JSON.parse(JSON.stringify(result.data));
                this.articles = JSON.parse(JSON.stringify(this.newsList.articles));
                console.log('articles', this.articles);
                //console.log('total data1',JSON.parse(JSON.stringify(this.itemsDetails)));
            }else if (result.error) {
                console.log('error#', result.error);
            }
        }

}