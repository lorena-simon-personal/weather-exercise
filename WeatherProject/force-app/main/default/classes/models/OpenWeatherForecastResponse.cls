/**
 * @descripttion: Open Weather Forecast Response class
 */
public class OpenWeatherForecastResponse{
	public String cod;
	public Double message;
	public Double cnt;	
	public List<WeatherDetails> weatherDetailsList;
	public City city;
	public class WeatherDetails {
        @AuraEnabled 
		public Double dt;	
        @AuraEnabled 
		public Main main;
        @AuraEnabled 
		public List<Weather> weather;
        @AuraEnabled 
		public Clouds clouds;
        @AuraEnabled 
		public Wind wind;
        @AuraEnabled 
		public Double visibility;	
        @AuraEnabled 
		public Double pop;	
        @AuraEnabled 
		public Sys sys;
        @AuraEnabled 
		public String dt_txt;
	}
	class Main {
		@AuraEnabled 
		public Double temp;	
		@AuraEnabled 
		public Double feels_like;
		@AuraEnabled 
		public Double temp_min;	
		@AuraEnabled 
		public Double temp_max;	
		@AuraEnabled 
		public Double pressure;
		@AuraEnabled 
		public Double sea_level;
		@AuraEnabled 
		public Double grnd_level;	
		@AuraEnabled 
		public Double humidity;
		@AuraEnabled 
		public Double temp_kf;
	}
	class Weather {
		@AuraEnabled 
		public Double id;
		@AuraEnabled
		public String main;
		@AuraEnabled	
		public String description;
		@AuraEnabled	
		public String icon;	
	}
	class Clouds {
		@AuraEnabled 
		public Double all;	
	}
	class Wind {
		@AuraEnabled 
		public Double speed;
		@AuraEnabled 	
		public Double deg;	
		@AuraEnabled 
		public Double gust;	
	}
	class Sys {
		@AuraEnabled 
		public String pod;	
	}
	class City {
		@AuraEnabled 
		public Double id;
		@AuraEnabled 	
		public String name;	
		@AuraEnabled 
		public Coord coord;
		@AuraEnabled 
		public String country;	
		@AuraEnabled 
		public Double population;	
		@AuraEnabled 
		public Double timezone;
		@AuraEnabled 	
		public Double sunrise;	
		@AuraEnabled 
		public Double sunset;	
	}
	class Coord {
		@AuraEnabled 
		public Double lat;	
		@AuraEnabled 
		public Double lon;	
	}
	
    /**
     * @description: Method to parse the JSON response
     * @param json: The JSON response
     * @return OpenWeatherForecastResponse: The parsed response
     */
	public static OpenWeatherForecastResponse parse(String json) {
		json = json.replaceAll('"list"','"weatherDetailsList"');
		return (OpenWeatherForecastResponse) System.JSON.deserialize(json, OpenWeatherForecastResponse.class);
	}
}