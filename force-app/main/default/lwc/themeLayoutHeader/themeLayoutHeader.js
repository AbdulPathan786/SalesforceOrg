import { LightningElement } from 'lwc';
import Abdul_Pathan from '@salesforce/resourceUrl/abdulpathan';
export default class ThemeLayout extends LightningElement {
    abdulImage = Abdul_Pathan ;
    isHome = true;
    isAbout;
    isBooks;
    isProfile;
    isLogin;

    onClickHomePage(event){
        this.isHome = true;
        this.isAbout = false;
        this.isBooks = false;
        this.isProfile = false;
        this.isLogin = false;
    }
    onClickAbout(event){
        this.isHome = false;
        this.isAbout = true;
        this.isBooks = false;
        this.isProfile = false;
        this.isLogin = false;
    }
    onClickBook(event){
        this.isHome = false;
        this.isAbout = false;
        this.isBooks = true;
        this.isProfile = false;
        this.isLogin = false;
    }
    onClickProfile(event){
        this.isHome = false;
        this.isAbout = false;
        this.isBooks = false;
        this.isProfile = true;
        this.isLogin = false;
    }
    onClickLogin(event){
        this.isHome = false;
        this.isAbout = false;
        this.isBooks = false;
        this.isProfile = false;
        this.isLogin = true;
        //console.log('onClickLogin..',event.target.dataset.name);
    }
}