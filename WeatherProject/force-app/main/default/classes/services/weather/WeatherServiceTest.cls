/**
 * @description: Unit tests for WeatherService
 */
@IsTest
private class WeatherServiceTest {

    /**
     * @description: Method to test the getForecast method
     */
    @IsTest
    static void testGetForecastSuccess() {
        Test.setMock(HttpCalloutMock.class, new WeatherServiceCalloutMock(true));

        Test.startTest();
        OpenWeatherForecastResponse.WeatherDetails weatherDetails = WeatherService.getWeatherDetailsForTomorrow('Paris');
        Test.stopTest();

        System.assertEquals(true,  weatherDetails != null, 'Should not be null');
    } 

    /**
     * @description: Method to test the getForecast method
     */
    @IsTest
    static void testGetForecastFailure() {
        Test.setMock(HttpCalloutMock.class, new WeatherServiceCalloutMock(false));

        Test.startTest();
        OpenWeatherForecastResponse.WeatherDetails weatherDetails = WeatherService.getWeatherDetailsForTomorrow('Paris');
        Test.stopTest();

        System.assertEquals(true,  weatherDetails == null, 'Should be null');

    } 

    /**
     * @description: Class to mock the callout
     */
    public class WeatherServiceCalloutMock implements HttpCalloutMock {
        private Boolean isSucces;

        public WeatherServiceCalloutMock(Boolean isSucces) {
            this.isSucces = isSucces;
        }

        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();

            if (isSucces) {
                response.setBody('{\"cod\":\"200\",\"message\":0,\"cnt\":40,\"list\":[{\"dt\":1728129600,\"main\":{\"temp\":289.18,\"feels_like\":288.59,\"temp_min\":289.18,\"temp_max\":289.63,\"pressure\":1014,\"sea_level\":1014,\"grnd_level\":1010,\"humidity\":67,\"temp_kf\":-0.45},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"brokenclouds\",\"icon\":\"04d\"}],\"clouds\":{\"all\":75},\"wind\":{\"speed\":4.39,\"deg\":160,\"gust\":6.09},\"visibility\":10000,\"pop\":0,\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2024-10-0512:00:00\"},{\"dt\":1728140400,\"main\":{\"temp\":289.21,\"feels_like\":288.49,\"temp_min\":289.21,\"temp_max\":289.28,\"pressure\":1013,\"sea_level\":1013,\"grnd_level\":1008,\"humidity\":62,\"temp_kf\":-0.07},\"weather\":[{\"id\":802,\"main\":\"Clouds\",\"description\":\"scatteredclouds\",\"icon\":\"03d\"}],\"clouds\":{\"all\":50},\"wind\":{\"speed\":5.08,\"deg\":159,\"gust\":6.94},\"visibility\":10000,\"pop\":0,\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2024-10-0515:00:00\"}],\"city\":{\"id\":2643743,\"name\":\"London\",\"coord\":{\"lat\":51.5085,\"lon\":-0.1257},\"country\":\"GB\",\"population\":1000000,\"timezone\":3600,\"sunrise\":1728108484,\"sunset\":1728149360}}');
                response.setStatusCode(Constants.HTTP_SUCCESS_CODE) ;
            } else {
                response.setStatusCode(Constants.HTTP_ERROR_CODE) ;
            }

            return response;
        }
    }
}