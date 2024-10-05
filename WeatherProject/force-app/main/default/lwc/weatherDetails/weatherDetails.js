import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import LOCATION from '@salesforce/schema/Account.BillingCity';
import weatherTomorrowLabel from '@salesforce/label/c.weatherTomorrow';
import weatherErrorsLabel from '@salesforce/label/c.weatherErrorsLabel';
import minLabel from '@salesforce/label/c.minLabel';
import maxLabel from '@salesforce/label/c.maxLabel';
import feelsLikeLabel from '@salesforce/label/c.feelsLikeLabel';

import getTomorrowsWeather from "@salesforce/apex/WeatherService.getWeatherDetailsForTomorrow";
export default class WeatherDetails extends LightningElement {
    labels = {
        weatherTomorrowLabel,
        weatherErrorsLabel,
        minLabel,
        maxLabel,
        feelsLikeLabel
    };
    minTemperature;
    maxTemperature;
    feelsLike;
    weatherDescription;
    weatherIcon;
    iconUrl;
    showWeatherDetails = false;
    hasErrors = false;
    @api recordId; 
    @wire(getRecord, { recordId: '$recordId', fields: [LOCATION] })
    account; 

    get location() {
        return getFieldValue(this.account.data, LOCATION); 
    }

    @wire(getTomorrowsWeather, { location: '$location' })
    getWeatherData({ error, data }) {
        if (data) {
            this.minTemperature = data.main.temp_min;
            this.maxTemperature = data.main.temp_max;
            this.feelsLike = data.main.feels_like;
            this.weatherDescription = data.weather[0].description;
            this.weatherIcon = data.weather[0].icon;
            this.iconUrl = `https://openweathermap.org/img/wn/${this.weatherIcon}.png`;
            this.showWeatherDetails = true;
            this.hasErrors = false;
        } else if (error || data == null) {
            this.showWeatherDetails = false;
            this.hasErrors = true;
        }
  }
}
