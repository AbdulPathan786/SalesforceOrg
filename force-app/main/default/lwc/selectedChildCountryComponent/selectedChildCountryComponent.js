import { LightningElement, track, api } from 'lwc';

export default class selectedChildCountryComponent extends LightningElement {
    @api selectCountryName;

    constructor() {
        super();
    }   
    get countryDetails() {
        if (this.selectCountryName == "India")
            return {
                flagURL: "https://cdn.countryflags.com/thumbs/india/flag-400.png",
                capital: "New Delhi",
                continent: "Asia",
                population: "7.8 Billion",
                president: "Ram Nath Kovind",
            };

        else if (this.selectCountryName == "Pakisthan")
            return {
                flagURL: "https://upload.wikimedia.org/wikipedia/commons/e/ea/Badshahi_Mosuqe_Complete_View_Pakistan.jpg",
                capital: "Islamabad",
                continent: "Asia",
                population: "21.22 crores (2018)",
                president: "Arif Alvi",
            };

        else if (this.selectCountryName == "Afganistan")
            return {
                flagURL: "https://wallpapercave.com/wp/wp5186202.jpg",
                capital: "Kabul",
                continent: "Asia",
                population: "38,788,794",
                president: "Ashraf Ghani",
            };
        else if (this.selectCountryName == "Bangledesh")
            return {
                flagURL: "https://previews.123rf.com/images/mathess/mathess1710/mathess171000419/87543804-ahsan-manzil-former-residential-palace-of-the-nawab-of-dhaka-bangladesh.jpg",
                capital: " Dhaka",
                continent: "Asia",
                population: "7.8 Billion",
                president: "Abdul Hamid",
            };
    }

    /* countryRecordDetails() {
        const cars = [
            {
                flagURL: "https://cdn.countryflags.com/thumbs/india/flag-400.png",
                capital: "New Delhi",
                continent: "Asia",
                population: "7.8 Billion",
                president: "Ram Nath Kovind",
            },
            {
                flagURL: "https://upload.wikimedia.org/wikipedia/commons/e/ea/Badshahi_Mosuqe_Complete_View_Pakistan.jpg",
                capital: "Islamabad",
                continent: "Asia",
                population: "21.22 crores (2018)",
                president: "Arif Alvi",
            },
            {
                flagURL: "https://wallpapercave.com/wp/wp5186202.jpg",
                capital: "Kabul",
                continent: "Asia",
                population: "38,788,794",
                president: "Ashraf Ghani",
            },
            {
                flagURL: "https://previews.123rf.com/images/mathess/mathess1710/mathess171000419/87543804-ahsan-manzil-former-residential-palace-of-the-nawab-of-dhaka-bangladesh.jpg",
                capital: " Dhaka",
                continent: "Asia",
                population: "7.8 Billion",
                president: "Abdul Hamid",
            }
        ];
    }
    get countryDetails() {
        if (this.selectCountryName == "India")
            return this.countryRecordDetails;
        else if (this.selectCountryName == "Pakisthan")
            return this.countryRecordDetails;
        else if (this.selectCountryName == "Afganistan")
            return this.countryRecordDetails;
        else if (this.selectCountryName == "Bangledesh")
            return this.countryRecordDetails;
    } */

}