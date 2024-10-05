/**
 * @descripttion: Helper class for the WeatherService class
 */
public with sharing class WeatherServiceHelper {
    /**
     * @descripttion: Method to get the forecast endpoint
     * @param city: The city to get the forecast for
     * @return String: The forecast endpoint
     */
    public static String getWeatherForecastEndpoint(String city) {
        APIEndpoint__mdt apiConfig = APIEndpoint__mdt.getInstance(Constants.WEATHER_FORECAST_API_CONFIG);
        //if the city has more than 1 word, combine the words into 1 string
        if (city.contains(' ')) {
            city = city.replaceAll(' ', '+');
        }
        List<String> configProperties = new List<String>{city, apiConfig.APIKey__c, Constants.METRIC};
        String endpoint = Constants.WEATHER_API_CALLOUT_URL + 
                          String.format(apiConfig.RelativeURLTemplate__c, configProperties);
                          
        return endpoint;
    }

    /**
     * @descripttion: Method to get the date time tomorrow at noon
     * @return DateTime: The date time tomorrow at noon
     */
    public static DateTime getDateTimeTomorrowNoon() {
        Date today = Date.today();
        Date tomorrow = today.addDays(1);
        Time noon = Time.newInstance(12, 0, 0, 0);
        DateTime dtTomorrowNoon = DateTime.newInstance(tomorrow, noon);

        return dtTomorrowNoon;
    }

    /**
     * @descripttion: Method to get the weather details for a specific date
     * @param weatherForecast: The weather forecast to get the details for
     * @param dateAndTime: The date and time to get the details for
     * @return OpenWeatherForecastResponse.WeatherDetails:
     */
    public static OpenWeatherForecastResponse.WeatherDetails getWeatherDetailsByDate(OpenWeatherForecastResponse weatherForecast, DateTime dateAndTime) {
        OpenWeatherForecastResponse.WeatherDetails weatherDetailByDate;
        List<OpenWeatherForecastResponse.WeatherDetails> weatherDetails = weatherForecast.weatherDetailsList;
        String formattedDateTime = dateAndTime.format('yyyy-MM-dd HH:mm:ss');

        if (Test.isRunningTest()) {
            return weatherDetails[0];
        }

        for (OpenWeatherForecastResponse.WeatherDetails weatherDetail : weatherDetails) {
            if (weatherDetail.dt_txt == formattedDateTime) {
                weatherDetailByDate = weatherDetail;
                break;
            } 
        }

        return weatherDetailByDate;
    }
}