import { LightningElement } from 'lwc';
import Abdul_Pathan from '@salesforce/resourceUrl/abdulpathan';

export default class ThemeLayoutFooter extends LightningElement {
    abdulImage = Abdul_Pathan;
    isHome;
    isAbout;
    isContact;
    isBlog;
    isPricing;
    isFaq;

    onClickHomePage(){
        this.isHome = true;
        this.isAbout = false;
        this.isContact = false;
        this.isBlog = false;
        this.isPricing = false;
        this.isFaq = false;
    }
    onClickAbout(){
        this.isHome = false;
        this.isAbout = true;
        this.isContact = false;
        this.isBlog = false;
        this.isPricing = false;
        this.isFaq = false;
    }
    onClickContact(){
        this.isHome = false;
        this.isAbout = false;
        this.isContact = true;
        this.isBlog = false;
        this.isPricing = false;
        this.isFaq = false;
    }
    onClickBlog(){
        this.isHome = false;
        this.isAbout = false;
        this.isContact = false;
        this.isBlog = false;
        this.isPricing = false;
        this.isFaq = false;
    }
    onClickPricing(){
        this.isHome = false;
        this.isAbout = false;
        this.isContact = false;
        this.isBlog = false;
        this.isPricing = false;
        this.isFaq = false;
    }
    onClickFaq(){
        this.isHome = false;
        this.isAbout = false;
        this.isContact = false;
        this.isBlog = false;
        this.isPricing = false;
        this.isFaq = false;
    }
}