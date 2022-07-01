import { LightningElement, track } from 'lwc';
//const endPoint = 'https://api.github.com/repositories?since=364';
const endPoint = 'https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries+states+cities.json';

export default class CountriesStatesCities extends LightningElement {
    @track countryDetails;
    @track countries = [];
    @track states = [];
    @track cities = [];

    handleFetch() {
        fetch(endPoint, { method: 'GET' })
            .then((response) => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw Error(response);
                }
            })
            .then((repos) => {
                this.countryDetails = repos;
                let allCountryOptions = [...repos].map(country => {
                    let option = {
                        label: country.name,
                        value: country.iso3,
                        description: country.native
                    }
                    return option;
                });
                this.countries = allCountryOptions;
            })
            .catch(error => {
                console.log('error=== : ', error);
            });
    }

    handleCountryChanges(event) {
        let selectedCountry = event.target.value
        let country = [...this.countryDetails].filter(country => {
            return country.iso3 === selectedCountry;
        });

        if (country.length) {
            let allStateOptions = country[0].states.map(state => {
                let option = {
                    label: state.name,
                    value: state.id.toString(),
                    description: state.state_code
                }
                return option;
            });
            this.states = JSON.parse(JSON.stringify(allStateOptions));
        }
    }

    handleStateChanges(event) {
        try {
            let selectedState = event.target.value;
            let state = [...this.countryDetails[0].states].filter(stateValue => {
                // let state = [...this.states].filter(stateValue => {
                return stateValue.id == selectedState;
            });
            if (state.length) {
                let allCitiesOptions = state[0].cities.map(city => {
                    let option = {
                        label: city.name,
                        value: city.id,
                        // description: city.latitude
                    }
                    return option;
                })
                this.cities = allCitiesOptions;
            }
        } catch (error) {
            console.log('error=== : ', error);
        }


    }

 /*    handleCityChanges(event) {
        let selectedCity = event.target.value;
        console.log('selectedCity : ', JSON.stringify(selectedCity));
        let city = [...this.countryDetails[0].states[0].cities].filter(cityValue => {
            return cityValue.id == selectedCity;
        });
        if (city.length) {
            let allCities = [...this.city].forEach(city =>{
                let option = {
                    label: city.name,
                    value: city.id,
                    // description: city.latitude
                }
                return option;
            }) 
            this.cities = allCities;
        }
    } */
}