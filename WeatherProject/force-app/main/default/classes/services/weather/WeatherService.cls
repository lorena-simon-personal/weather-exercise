/**
 * @descripttion: WeatherService class
 */
public with sharing class WeatherService {
    
    /**
     * @descripttion: Method to get the 5 days forecast for a city
     * @param city: The city to get the forecast for
     * @return OpenWeatherForecastResponse: The response from the callout
     */
    public static OpenWeatherForecastResponse getForecast(String city) {
        String endpoint = WeatherServiceHelper.getWeatherForecastEndpoint(city);
        String method = Constants.HTTP_GET;
        String body = '';

        HttpResponse response = CalloutUtil.doCallout(endpoint, method, body);
        Boolean isSucces = CalloutUtil.isSucces(response);

        if (isSucces) {
            OpenWeatherForecastResponse weatherForecast = OpenWeatherForecastResponse.parse(response.getBody());
            return weatherForecast;
        } else {
            return null;
        }
    }

    /**
     * @description: Method to get the weather details for tomorrow
     * @param recordId: The id of the record to get the weather details for
     * @return OpenWeatherForecastResponse.WeatherDetails: The weather details for tomorrow
     */
    @AuraEnabled(cacheable=true)
    public static OpenWeatherForecastResponse.WeatherDetails getWeatherDetailsForTomorrow(String location) {
        if (location == null) {
            return null;
        } else {
            OpenWeatherForecastResponse weatherForecast = getForecast(location);
            if (weatherForecast != null) {
                DateTime dtTomorrowNoon = WeatherServiceHelper.getDateTimeTomorrowNoon();
                OpenWeatherForecastResponse.WeatherDetails weatherDetails = WeatherServiceHelper.getWeatherDetailsByDate(weatherForecast, dtTomorrowNoon);
                
                return weatherDetails;
            } else {
                return null;
            }
        }
    }
}